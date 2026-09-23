use crate::errors::PipelineResult;

pub trait ParserBenchmarkContract {
    fn contract_name(&self) -> &'static str;
    fn validate(&self, payload: &str) -> PipelineResult<()>;
}
