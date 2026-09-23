use ai_graph_core::{GraphError, GraphResult};

#[derive(Debug, Clone, PartialEq, Eq)]
pub struct ConvergenceReport {
    pub value: String,
    pub iterations: usize,
}

pub trait ConvergenceStrategy {
    fn run<F>(&self, input: String, step: F) -> GraphResult<ConvergenceReport>
    where
        F: Fn(&str) -> String;
}

#[derive(Debug, Clone, Copy)]
pub struct BoundedConvergence {
    pub limit: usize,
}

impl ConvergenceStrategy for BoundedConvergence {
    fn run<F>(&self, mut input: String, step: F) -> GraphResult<ConvergenceReport>
    where
        F: Fn(&str) -> String,
    {
        for iteration in 1..=self.limit {
            let next = step(&input);
            if next == input {
                return Ok(ConvergenceReport {
                    value: next,
                    iterations: iteration,
                });
            }
            input = next;
        }
        Err(GraphError::Timeout("convergence limit reached"))
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn report_is_returned_for_stable_step() {
        let strategy = BoundedConvergence { limit: 2 };
        let report = strategy
            .run("x".to_string(), |value| value.to_string())
            .unwrap();
        assert_eq!(report.value, "x");
        assert_eq!(report.iterations, 1);
    }
}
