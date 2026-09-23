use ai_graph_core::ExecutionId;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct CheckpointPointer {
    pub execution_id: ExecutionId,
    pub step: u64,
    pub token: String,
}

pub trait CheckpointIndex {
    fn insert(&mut self, pointer: CheckpointPointer);
    fn latest(&self, execution_id: ExecutionId) -> Option<CheckpointPointer>;
}

#[derive(Debug, Clone, Default)]
pub struct InMemoryCheckpointIndex {
    pointers: Vec<CheckpointPointer>,
}

impl CheckpointIndex for InMemoryCheckpointIndex {
    fn insert(&mut self, pointer: CheckpointPointer) {
        self.pointers.push(pointer);
    }

    fn latest(&self, execution_id: ExecutionId) -> Option<CheckpointPointer> {
        self.pointers
            .iter()
            .filter(|pointer| pointer.execution_id == execution_id)
            .max_by_key(|pointer| pointer.step)
            .cloned()
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn latest_pointer_is_returned() {
        let mut index = InMemoryCheckpointIndex::default();
        index.insert(CheckpointPointer {
            execution_id: ExecutionId(1),
            step: 1,
            token: "a".to_string(),
        });
        index.insert(CheckpointPointer {
            execution_id: ExecutionId(1),
            step: 3,
            token: "b".to_string(),
        });
        assert_eq!(index.latest(ExecutionId(1)).unwrap().step, 3);
    }
}
