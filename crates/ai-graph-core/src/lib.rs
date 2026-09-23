use std::sync::{
    Arc,
    atomic::{AtomicBool, Ordering},
};

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct NodeId(pub u64);

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct EdgeId(pub u64);

#[derive(Debug, Clone, Copy, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct ExecutionId(pub u64);

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum GraphError {
    InvalidTopology(&'static str),
    NodeFailure { node: NodeId, message: String },
    ReplayMismatch(&'static str),
    Timeout(&'static str),
    Cancelled(&'static str),
    Internal(String),
}

pub type GraphResult<T> = Result<T, GraphError>;

pub fn stable_hash(input: &str) -> u64 {
    let mut hash = 14695981039346656037_u64;
    for byte in input.as_bytes() {
        hash ^= u64::from(*byte);
        hash = hash.wrapping_mul(1099511628211_u64);
    }
    hash
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct StepOutcome {
    pub node: NodeId,
    pub output: String,
    pub replay_fingerprint: u64,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum ExecutionState {
    Pending,
    Running,
    Succeeded,
    Failed,
    TimedOut,
    Cancelled,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct StateTransition {
    pub node: NodeId,
    pub from: ExecutionState,
    pub to: ExecutionState,
    pub attempt: u32,
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct ExecutionConfig {
    pub max_retries: u32,
    pub timeout_ms: u64,
}

impl Default for ExecutionConfig {
    fn default() -> Self {
        Self {
            max_retries: 1,
            timeout_ms: 5_000,
        }
    }
}

#[derive(Debug, Clone)]
pub struct CancellationToken {
    cancelled: Arc<AtomicBool>,
}

impl Default for CancellationToken {
    fn default() -> Self {
        Self::new()
    }
}

impl CancellationToken {
    pub fn new() -> Self {
        Self {
            cancelled: Arc::new(AtomicBool::new(false)),
        }
    }

    pub fn cancel(&self) {
        self.cancelled.store(true, Ordering::SeqCst);
    }

    pub fn is_cancelled(&self) -> bool {
        self.cancelled.load(Ordering::SeqCst)
    }
}

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub struct ReplayEvent {
    pub execution_id: ExecutionId,
    pub node: NodeId,
    pub input_hash: u64,
    pub output_hash: u64,
}

pub trait GraphNode {
    fn id(&self) -> NodeId;
    fn execute(&self, input: &str) -> GraphResult<String>;
}

pub trait DeterministicExecutor {
    fn execute_step(&self, node: &dyn GraphNode, input: &str) -> GraphResult<StepOutcome>;
    fn replay_seed(&self) -> u64;
}

pub trait ReplayRecorder {
    fn record(&mut self, event: ReplayEvent);
    fn events(&self) -> &[ReplayEvent];
}

pub fn build_replay_event(
    execution_id: ExecutionId,
    node: NodeId,
    input: &str,
    output: &str,
) -> ReplayEvent {
    ReplayEvent {
        execution_id,
        node,
        input_hash: stable_hash(input),
        output_hash: stable_hash(output),
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn stable_hash_is_deterministic() {
        assert_eq!(stable_hash("abc"), stable_hash("abc"));
    }

    #[test]
    fn stable_hash_changes_for_different_inputs() {
        assert_ne!(stable_hash("abc"), stable_hash("abd"));
    }

    #[test]
    fn cancellation_token_switches_state() {
        let token = CancellationToken::new();
        assert!(!token.is_cancelled());
        token.cancel();
        assert!(token.is_cancelled());
    }

    #[test]
    fn replay_event_builder_hashes_input_and_output() {
        let event = build_replay_event(ExecutionId(1), NodeId(7), "in", "out");
        assert_eq!(event.input_hash, stable_hash("in"));
        assert_eq!(event.output_hash, stable_hash("out"));
    }
}
