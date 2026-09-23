use ai_graph_core::{GraphError, GraphResult};

pub trait FixedPointEngine {
    fn converge<F>(&self, input: String, step: F) -> GraphResult<String>
    where
        F: Fn(&str) -> String;
}

#[derive(Debug, Clone, Copy)]
pub struct BoundedFixedPointEngine {
    pub max_iterations: usize,
}

impl FixedPointEngine for BoundedFixedPointEngine {
    fn converge<F>(&self, mut input: String, step: F) -> GraphResult<String>
    where
        F: Fn(&str) -> String,
    {
        for _ in 0..self.max_iterations {
            let next = step(&input);
            if next == input {
                return Ok(next);
            }
            input = next;
        }
        Err(GraphError::Timeout(
            "fixed-point not reached within iteration budget",
        ))
    }
}

pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn converges_to_lowercase() {
        let engine = BoundedFixedPointEngine { max_iterations: 4 };
        let result = engine
            .converge("HELLO".to_string(), |value| value.to_lowercase())
            .unwrap();
        assert_eq!(result, "hello");
    }
}
