use crate::errors::PipelineResult;

pub trait ToolCallSchemaContract {
    fn contract_name(&self) -> &'static str;
    fn validate(&self, payload: &str) -> PipelineResult<()>;
}
