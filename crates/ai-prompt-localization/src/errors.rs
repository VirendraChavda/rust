#[derive(Debug, Clone, PartialEq, Eq)]
pub enum PipelineError {
    InvalidInput(&'static str),
    NotFound(String),
    ParseFailure(String),
    PolicyViolation(&'static str),
    Internal(String),
}

pub type PipelineResult<T> = Result<T, PipelineError>;
