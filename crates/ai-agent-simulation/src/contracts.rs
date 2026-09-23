use crate::errors::PipelineResult;

pub trait AgentSimulationContract {
    fn contract_name(&self) -> &'static str;
    fn validate(&self, payload: &str) -> PipelineResult<()>;
}
