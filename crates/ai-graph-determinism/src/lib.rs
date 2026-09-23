use ai_graph_core::{GraphError, GraphResult, stable_hash};

#[derive(Debug, Clone, Copy, PartialEq, Eq)]
pub enum DeterminismMode {
    Strict,
    BestEffort,
}

pub trait DeterminismPolicy {
    fn mode(&self) -> DeterminismMode;
    fn fingerprint(&self, payload: &str) -> u64;
    fn verify_pair(&self, left: &str, right: &str) -> GraphResult<()>;
}

#[derive(Debug, Default, Clone, Copy)]
pub struct StrictDeterminismPolicy;

impl DeterminismPolicy for StrictDeterminismPolicy {
    fn mode(&self) -> DeterminismMode {
        DeterminismMode::Strict
    }

    fn fingerprint(&self, payload: &str) -> u64 {
        stable_hash(payload)
    }

    fn verify_pair(&self, left: &str, right: &str) -> GraphResult<()> {
        if self.fingerprint(left) == self.fingerprint(right) {
            Ok(())
        } else {
            Err(GraphError::ReplayMismatch("fingerprint mismatch"))
        }
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn strict_policy_detects_mismatch() {
        let policy = StrictDeterminismPolicy;
        assert!(policy.verify_pair("a", "b").is_err());
    }
}
