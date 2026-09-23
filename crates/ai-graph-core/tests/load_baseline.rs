use ai_graph_core::{
    DeterministicExecutor, GraphNode, GraphResult, NodeId, StepOutcome, stable_hash,
};
use ai_graph_executor::{GraphExecutor, SequentialExecutor};
use std::time::{Duration, Instant};

struct FastNode;

impl GraphNode for FastNode {
    fn id(&self) -> NodeId {
        NodeId(1)
    }

    fn execute(&self, input: &str) -> GraphResult<String> {
        Ok(input.to_string())
    }
}

#[derive(Debug, Clone, Copy)]
struct FastExecutor;

impl DeterministicExecutor for FastExecutor {
    fn execute_step(&self, node: &dyn GraphNode, input: &str) -> GraphResult<StepOutcome> {
        let output = node.execute(input)?;
        Ok(StepOutcome {
            node: node.id(),
            replay_fingerprint: stable_hash(&output),
            output,
        })
    }

    fn replay_seed(&self) -> u64 {
        1
    }
}

#[test]
fn baseline_hash_loop_under_budget() {
    let start = Instant::now();
    let mut acc = 0_u64;
    for idx in 0..50_000_u64 {
        acc ^= stable_hash(&format!("payload-{idx}"));
    }
    assert_ne!(acc, 0);
    assert!(start.elapsed() < Duration::from_secs(15));
}

#[test]
fn baseline_executor_loop_under_budget() {
    let start = Instant::now();
    let node = FastNode;
    let runner = SequentialExecutor::new(FastExecutor);

    let mut total = 0_usize;
    for _ in 0..50_000 {
        total += runner.execute(&[&node], "ok").unwrap().len();
    }

    assert_eq!(total, 50_000);
    assert!(start.elapsed() < Duration::from_secs(15));
}
