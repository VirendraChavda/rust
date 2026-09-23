use crate::errors::PipelineResult;

pub trait PromptLocalizationContract {
    fn contract_name(&self) -> &'static str;
    fn validate(&self, payload: &str) -> PipelineResult<()>;
}
