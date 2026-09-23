use crate::errors::PipelineResult;

pub trait JsonParserCoreContract {
    fn contract_name(&self) -> &'static str;
    fn validate(&self, payload: &str) -> PipelineResult<()>;
}
