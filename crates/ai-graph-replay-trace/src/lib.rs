use ai_graph_core::{ExecutionId, GraphError, GraphResult, NodeId, ReplayEvent};
use std::collections::BTreeMap;

#[derive(Debug, Clone, Default)]
pub struct ReplayTrace {
    pub events: Vec<ReplayEvent>,
}

pub trait ReplayTraceStore {
    fn append(&mut self, event: ReplayEvent);
    fn by_execution(&self, execution_id: ExecutionId) -> Vec<ReplayEvent>;
    fn by_node(&self, node: NodeId) -> Vec<ReplayEvent>;
    fn verify_deterministic(&self, execution_id: ExecutionId) -> GraphResult<()>;
}

#[derive(Debug, Clone, Default)]
pub struct InMemoryReplayTraceStore {
    pub trace: ReplayTrace,
}

impl ReplayTraceStore for InMemoryReplayTraceStore {
    fn append(&mut self, event: ReplayEvent) {
        self.trace.events.push(event);
    }

    fn by_execution(&self, execution_id: ExecutionId) -> Vec<ReplayEvent> {
        self.trace
            .events
            .iter()
            .copied()
            .filter(|event| event.execution_id == execution_id)
            .collect()
    }

    fn by_node(&self, node: NodeId) -> Vec<ReplayEvent> {
        self.trace
            .events
            .iter()
            .copied()
            .filter(|event| event.node == node)
            .collect()
    }

    fn verify_deterministic(&self, execution_id: ExecutionId) -> GraphResult<()> {
        let mut seen: BTreeMap<(NodeId, u64), u64> = BTreeMap::new();
        for event in self.by_execution(execution_id) {
            let key = (event.node, event.input_hash);
            if let Some(previous_output_hash) = seen.get(&key) {
                if *previous_output_hash != event.output_hash {
                    return Err(GraphError::ReplayMismatch(
                        "output hash mismatch for identical node/input pair",
                    ));
                }
            } else {
                seen.insert(key, event.output_hash);
            }
        }

        Ok(())
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn stores_event_by_execution() {
        let mut store = InMemoryReplayTraceStore::default();
        store.append(ReplayEvent {
            execution_id: ExecutionId(7),
            node: NodeId(1),
            input_hash: 1,
            output_hash: 2,
        });
        assert_eq!(store.by_execution(ExecutionId(7)).len(), 1);
    }

    #[test]
    fn deterministic_verification_fails_for_mismatch() {
        let mut store = InMemoryReplayTraceStore::default();
        store.append(ReplayEvent {
            execution_id: ExecutionId(1),
            node: NodeId(4),
            input_hash: 10,
            output_hash: 20,
        });
        store.append(ReplayEvent {
            execution_id: ExecutionId(1),
            node: NodeId(4),
            input_hash: 10,
            output_hash: 21,
        });

        assert!(store.verify_deterministic(ExecutionId(1)).is_err());
    }
}
