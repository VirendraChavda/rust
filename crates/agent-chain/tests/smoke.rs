use agent_chain::{AgentChain, ChainError, ChainStep};

struct PrefixStep(&'static str);

impl ChainStep for PrefixStep {
    fn run(&self, input: String) -> Result<String, ChainError> {
        Ok(format!("{}{}", self.0, input))
    }
}

#[test]
fn smoke_pipeline_executes() {
    let chain = AgentChain::new().with_step(PrefixStep("rust-"));
    let output = chain.run("agent").expect("pipeline should execute");
    assert_eq!(output, "rust-agent");
}
