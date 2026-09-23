pub mod contracts;
pub mod errors;

pub use contracts::PromptLocalizationContract;
pub use errors::{PipelineError, PipelineResult};

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn health_is_ok() {
        assert_eq!(health(), "ok");
    }

    #[test]
    fn pipeline_error_equality() {
        let lhs = PipelineError::InvalidInput("payload");
        let rhs = PipelineError::InvalidInput("payload");
        assert_eq!(lhs, rhs);
    }
}
