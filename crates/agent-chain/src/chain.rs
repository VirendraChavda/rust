use std::error::Error;
use std::fmt::{Display, Formatter};

#[derive(Debug, Clone, Eq, PartialEq)]
pub enum ChainError {
    NoSteps,
    StepFailed(String),
}

impl Display for ChainError {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        match self {
            Self::NoSteps => write!(f, "agent chain has no steps"),
            Self::StepFailed(message) => write!(f, "agent chain step failed: {message}"),
        }
    }
}

impl Error for ChainError {}

pub trait ChainStep: Send + Sync {
    fn run(&self, input: String) -> Result<String, ChainError>;
}

pub struct AgentChain {
    steps: Vec<Box<dyn ChainStep>>,
}

impl Default for AgentChain {
    fn default() -> Self {
        Self::new()
    }
}

impl AgentChain {
    #[must_use]
    pub fn new() -> Self {
        Self { steps: Vec::new() }
    }

    #[must_use]
    pub fn with_step(mut self, step: impl ChainStep + 'static) -> Self {
        self.add_step(step);
        self
    }

    pub fn add_step(&mut self, step: impl ChainStep + 'static) {
        self.steps.push(Box::new(step));
    }

    pub fn run(&self, input: impl Into<String>) -> Result<String, ChainError> {
        if self.steps.is_empty() {
            return Err(ChainError::NoSteps);
        }

        let mut state = input.into();
        for step in &self.steps {
            state = step.run(state)?;
        }

        Ok(state)
    }
}

#[cfg(test)]
mod tests {
    use super::{AgentChain, ChainError, ChainStep};

    struct UppercaseStep;

    impl ChainStep for UppercaseStep {
        fn run(&self, input: String) -> Result<String, ChainError> {
            Ok(input.to_uppercase())
        }
    }

    struct SuffixStep(&'static str);

    impl ChainStep for SuffixStep {
        fn run(&self, input: String) -> Result<String, ChainError> {
            Ok(format!("{input}{}", self.0))
        }
    }

    #[test]
    fn chain_runs_all_steps_in_order() {
        let chain = AgentChain::new()
            .with_step(UppercaseStep)
            .with_step(SuffixStep("!"));

        let output = chain.run("agent-chain").expect("chain should run");
        assert_eq!(output, "AGENT-CHAIN!");
    }

    #[test]
    fn chain_requires_at_least_one_step() {
        let output = AgentChain::new().run("hello");
        assert_eq!(output, Err(ChainError::NoSteps));
    }
}
