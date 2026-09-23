use ai_graph_core::ExecutionId;

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct SnapshotRecord {
    pub execution_id: ExecutionId,
    pub revision: u64,
    pub payload: String,
}

pub trait SnapshotStore {
    fn save(&mut self, snapshot: SnapshotRecord);
    fn load_latest(&self, execution_id: ExecutionId) -> Option<SnapshotRecord>;
}

#[derive(Debug, Clone, Default)]
pub struct InMemorySnapshotStore {
    snapshots: Vec<SnapshotRecord>,
}

impl SnapshotStore for InMemorySnapshotStore {
    fn save(&mut self, snapshot: SnapshotRecord) {
        self.snapshots.push(snapshot);
    }

    fn load_latest(&self, execution_id: ExecutionId) -> Option<SnapshotRecord> {
        self.snapshots
            .iter()
            .filter(|record| record.execution_id == execution_id)
            .max_by_key(|record| record.revision)
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
    fn latest_snapshot_is_returned() {
        let mut store = InMemorySnapshotStore::default();
        store.save(SnapshotRecord {
            execution_id: ExecutionId(9),
            revision: 1,
            payload: "a".to_string(),
        });
        store.save(SnapshotRecord {
            execution_id: ExecutionId(9),
            revision: 2,
            payload: "b".to_string(),
        });
        assert_eq!(store.load_latest(ExecutionId(9)).unwrap().revision, 2);
    }
}
