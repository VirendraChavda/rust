use ai_cycle_detector::{CycleDetector, PairCycleDetector};
use ai_dag_planner::{DagEdge, KahnTopologicalPlanner, TopologicalPlanner};
use ai_fixed_point_engine::{BoundedFixedPointEngine, FixedPointEngine};
use ai_graph_core::{
    CancellationToken, DeterministicExecutor, ExecutionConfig, ExecutionId, GraphError, GraphNode,
    GraphResult, NodeId, StepOutcome, stable_hash,
};
use ai_graph_executor::{GraphExecutor, SequentialExecutor};
use ai_graph_replay_trace::{InMemoryReplayTraceStore, ReplayTraceStore};
use std::sync::{Arc, Mutex};
use std::time::Duration;

struct EchoNode {
    id: NodeId,
}

impl GraphNode for EchoNode {
    fn id(&self) -> NodeId {
        self.id
    }

    fn execute(&self, input: &str) -> GraphResult<String> {
        Ok(format!("{}:{}", self.id.0, input))
    }
}

#[derive(Debug, Clone, Copy)]
struct SimpleDeterministicExecutor;

impl DeterministicExecutor for SimpleDeterministicExecutor {
    fn execute_step(&self, node: &dyn GraphNode, input: &str) -> GraphResult<StepOutcome> {
        let output = node.execute(input)?;
        Ok(StepOutcome {
            node: node.id(),
            replay_fingerprint: stable_hash(&output),
            output,
        })
    }

    fn replay_seed(&self) -> u64 {
        7
    }
}

#[test]
fn topological_planner_returns_complete_order() {
    let planner = KahnTopologicalPlanner;
    let nodes = vec![NodeId(1), NodeId(2), NodeId(3)];
    let edges = vec![
        DagEdge {
            from: NodeId(1),
            to: NodeId(2),
        },
        DagEdge {
            from: NodeId(2),
            to: NodeId(3),
        },
    ];
    let order = planner.topological_order(&nodes, &edges).unwrap();
    assert_eq!(order.len(), 3);
    assert_eq!(order[0], NodeId(1));
}

#[test]
fn cycle_detector_finds_two_node_cycle() {
    let detector = PairCycleDetector;
    let nodes = vec![NodeId(1), NodeId(2)];
    let edges = vec![
        DagEdge {
            from: NodeId(1),
            to: NodeId(2),
        },
        DagEdge {
            from: NodeId(2),
            to: NodeId(1),
        },
    ];
    let cycle = detector.find_cycle(&nodes, &edges);
    assert!(cycle.is_some());
}

#[test]
fn fixed_point_engine_converges() {
    let engine = BoundedFixedPointEngine { max_iterations: 5 };
    let out = engine
        .converge("HELLO".to_string(), |value| value.to_lowercase())
        .unwrap();
    assert_eq!(out, "hello");
}

#[test]
fn sequential_executor_yields_outcome() {
    let exec = SequentialExecutor::new(SimpleDeterministicExecutor);
    let node = EchoNode { id: NodeId(5) };
    let outcomes = exec.execute(&[&node], "ping").unwrap();
    assert_eq!(outcomes.len(), 1);
    assert_eq!(outcomes[0].node, NodeId(5));
    assert!(outcomes[0].output.contains("ping"));
}

#[test]
fn planner_rejects_cycle() {
    let planner = KahnTopologicalPlanner;
    let nodes = vec![NodeId(1), NodeId(2)];
    let edges = vec![
        DagEdge {
            from: NodeId(1),
            to: NodeId(2),
        },
        DagEdge {
            from: NodeId(2),
            to: NodeId(1),
        },
    ];
    let err = planner.topological_order(&nodes, &edges).unwrap_err();
    assert!(matches!(err, GraphError::InvalidTopology(_)));
}

struct FailableNode {
    id: NodeId,
    failures_remaining: Arc<Mutex<u32>>,
}

impl GraphNode for FailableNode {
    fn id(&self) -> NodeId {
        self.id
    }

    fn execute(&self, input: &str) -> GraphResult<String> {
        let mut guard = self.failures_remaining.lock().unwrap();
        if *guard > 0 {
            *guard -= 1;
            return Err(GraphError::NodeFailure {
                node: self.id,
                message: "injected failure".to_string(),
            });
        }
        Ok(format!("{}:{}", self.id.0, input))
    }
}

struct SlowNode {
    id: NodeId,
    delay: Duration,
}

impl GraphNode for SlowNode {
    fn id(&self) -> NodeId {
        self.id
    }

    fn execute(&self, input: &str) -> GraphResult<String> {
        std::thread::sleep(self.delay);
        Ok(format!("{}:{}", self.id.0, input))
    }
}

#[test]
fn runtime_retries_and_recovers_from_injected_failure() {
    let exec = SequentialExecutor::new(SimpleDeterministicExecutor);
    let node = FailableNode {
        id: NodeId(11),
        failures_remaining: Arc::new(Mutex::new(1)),
    };
    let config = ExecutionConfig {
        max_retries: 2,
        timeout_ms: 1_000,
    };
    let cancellation = CancellationToken::new();

    let report = exec
        .execute_runtime(ExecutionId(10), &[&node], "payload", config, &cancellation)
        .unwrap();

    assert_eq!(report.outcomes.len(), 1);
    assert!(report.transitions.iter().any(|transition| {
        transition.node == NodeId(11) && transition.to == ai_graph_core::ExecutionState::Failed
    }));
    assert!(report.transitions.iter().any(|transition| {
        transition.node == NodeId(11) && transition.to == ai_graph_core::ExecutionState::Succeeded
    }));
}

#[test]
fn runtime_times_out_when_node_exceeds_budget() {
    let exec = SequentialExecutor::new(SimpleDeterministicExecutor);
    let node = SlowNode {
        id: NodeId(12),
        delay: Duration::from_millis(30),
    };
    let config = ExecutionConfig {
        max_retries: 0,
        timeout_ms: 5,
    };
    let cancellation = CancellationToken::new();

    let err = exec
        .execute_runtime(ExecutionId(11), &[&node], "payload", config, &cancellation)
        .unwrap_err();

    assert!(matches!(err, GraphError::Timeout(_)));
}

#[test]
fn runtime_cancel_propagates_before_execution() {
    let exec = SequentialExecutor::new(SimpleDeterministicExecutor);
    let node = EchoNode { id: NodeId(13) };
    let config = ExecutionConfig {
        max_retries: 0,
        timeout_ms: 100,
    };
    let cancellation = CancellationToken::new();
    cancellation.cancel();

    let err = exec
        .execute_runtime(ExecutionId(12), &[&node], "payload", config, &cancellation)
        .unwrap_err();

    assert!(matches!(err, GraphError::Cancelled(_)));
}

#[test]
fn deterministic_replay_verification_catches_drift() {
    let mut store = InMemoryReplayTraceStore::default();

    store.append(ai_graph_core::ReplayEvent {
        execution_id: ExecutionId(77),
        node: NodeId(99),
        input_hash: 123,
        output_hash: 456,
    });
    store.append(ai_graph_core::ReplayEvent {
        execution_id: ExecutionId(77),
        node: NodeId(99),
        input_hash: 123,
        output_hash: 457,
    });

    let err = store.verify_deterministic(ExecutionId(77)).unwrap_err();
    assert!(matches!(err, GraphError::ReplayMismatch(_)));
}
