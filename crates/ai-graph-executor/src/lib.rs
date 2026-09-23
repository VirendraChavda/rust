use ai_graph_core::{
    CancellationToken, DeterministicExecutor, ExecutionConfig, ExecutionId, ExecutionState,
    GraphError, GraphNode, GraphResult, ReplayEvent, StateTransition, StepOutcome,
    build_replay_event,
};
use std::time::{Duration, Instant};

pub trait GraphExecutor {
    fn execute(&self, nodes: &[&dyn GraphNode], input: &str) -> GraphResult<Vec<StepOutcome>>;
}

#[derive(Debug, Clone)]
pub struct ExecutionReport {
    pub outcomes: Vec<StepOutcome>,
    pub transitions: Vec<StateTransition>,
    pub replay_events: Vec<ReplayEvent>,
}

impl ExecutionReport {
    pub fn succeeded_nodes(&self) -> usize {
        self.outcomes.len()
    }
}

#[derive(Debug, Clone)]
pub struct SequentialExecutor<T>
where
    T: DeterministicExecutor,
{
    inner: T,
}

impl<T> SequentialExecutor<T>
where
    T: DeterministicExecutor,
{
    pub fn new(inner: T) -> Self {
        Self { inner }
    }
}

impl<T> GraphExecutor for SequentialExecutor<T>
where
    T: DeterministicExecutor,
{
    fn execute(&self, nodes: &[&dyn GraphNode], input: &str) -> GraphResult<Vec<StepOutcome>> {
        let mut outcomes = Vec::with_capacity(nodes.len());
        for node in nodes {
            outcomes.push(self.inner.execute_step(*node, input)?);
        }
        Ok(outcomes)
    }
}

impl<T> SequentialExecutor<T>
where
    T: DeterministicExecutor,
{
    pub fn execute_runtime(
        &self,
        execution_id: ExecutionId,
        nodes: &[&dyn GraphNode],
        input: &str,
        config: ExecutionConfig,
        cancellation: &CancellationToken,
    ) -> GraphResult<ExecutionReport> {
        let timeout = Duration::from_millis(config.timeout_ms);
        let mut outcomes = Vec::with_capacity(nodes.len());
        let mut transitions = Vec::new();
        let mut replay_events = Vec::with_capacity(nodes.len());

        for node in nodes {
            if cancellation.is_cancelled() {
                transitions.push(StateTransition {
                    node: node.id(),
                    from: ExecutionState::Pending,
                    to: ExecutionState::Cancelled,
                    attempt: 0,
                });
                return Err(GraphError::Cancelled("execution cancelled before node run"));
            }

            let mut attempt = 0_u32;
            loop {
                attempt += 1;
                transitions.push(StateTransition {
                    node: node.id(),
                    from: ExecutionState::Pending,
                    to: ExecutionState::Running,
                    attempt,
                });

                let started = Instant::now();
                let result = self.inner.execute_step(*node, input);
                let elapsed = started.elapsed();

                if elapsed > timeout {
                    transitions.push(StateTransition {
                        node: node.id(),
                        from: ExecutionState::Running,
                        to: ExecutionState::TimedOut,
                        attempt,
                    });
                    if attempt > config.max_retries {
                        return Err(GraphError::Timeout(
                            "node execution exceeded timeout budget",
                        ));
                    }
                    continue;
                }

                match result {
                    Ok(outcome) => {
                        transitions.push(StateTransition {
                            node: node.id(),
                            from: ExecutionState::Running,
                            to: ExecutionState::Succeeded,
                            attempt,
                        });

                        replay_events.push(build_replay_event(
                            execution_id,
                            outcome.node,
                            input,
                            &outcome.output,
                        ));
                        outcomes.push(outcome);
                        break;
                    }
                    Err(error) => {
                        transitions.push(StateTransition {
                            node: node.id(),
                            from: ExecutionState::Running,
                            to: ExecutionState::Failed,
                            attempt,
                        });
                        if attempt > config.max_retries {
                            return Err(error);
                        }
                    }
                }
            }
        }

        Ok(ExecutionReport {
            outcomes,
            transitions,
            replay_events,
        })
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;
    use ai_graph_core::{GraphResult, NodeId, stable_hash};

    struct StaticNode {
        id: NodeId,
        value: &'static str,
    }

    impl GraphNode for StaticNode {
        fn id(&self) -> NodeId {
            self.id
        }

        fn execute(&self, _input: &str) -> GraphResult<String> {
            Ok(self.value.to_string())
        }
    }

    #[derive(Debug, Clone, Copy)]
    struct TestDeterministicExecutor;

    impl DeterministicExecutor for TestDeterministicExecutor {
        fn execute_step(&self, node: &dyn GraphNode, input: &str) -> GraphResult<StepOutcome> {
            let output = node.execute(input)?;
            Ok(StepOutcome {
                node: node.id(),
                replay_fingerprint: stable_hash(&output),
                output,
            })
        }

        fn replay_seed(&self) -> u64 {
            11
        }
    }

    #[test]
    fn runtime_execution_produces_report() {
        let exec = SequentialExecutor::new(TestDeterministicExecutor);
        let node = StaticNode {
            id: NodeId(1),
            value: "ok",
        };
        let cancellation = CancellationToken::new();
        let config = ExecutionConfig {
            max_retries: 0,
            timeout_ms: 500,
        };
        let report = exec
            .execute_runtime(ExecutionId(1), &[&node], "input", config, &cancellation)
            .unwrap();

        assert_eq!(report.succeeded_nodes(), 1);
        assert_eq!(report.replay_events.len(), 1);
        assert!(
            report
                .transitions
                .iter()
                .any(|transition| transition.to == ExecutionState::Succeeded)
        );
    }
}
