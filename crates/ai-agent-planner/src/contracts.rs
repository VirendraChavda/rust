use crate::errors::PipelineResult;

pub trait AgentPlannerContract {
    fn contract_name(&self) -> &'static str;
    fn validate(&self, payload: &str) -> PipelineResult<()>;
}
