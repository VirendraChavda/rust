# agent-chain

`agent-chain` is a boilerplate crate for building composable AI agent execution chains in Rust.

## Scope

This crate currently provides a minimal pipeline abstraction to compose chain steps and execute them in order.

## Quick start

```rust
use agent_chain::{AgentChain, ChainError, ChainStep};

struct PrefixStep;

impl ChainStep for PrefixStep {
    fn run(&self, input: String) -> Result<String, ChainError> {
        Ok(format!("prefix-{input}"))
    }
}

let chain = AgentChain::new().with_step(PrefixStep);
let output = chain.run("hello")?;
assert_eq!(output, "prefix-hello");
# Ok::<(), ChainError>(())
```

## Development

```bash
cargo test -p agent-chain
```

## License

Dual-licensed under MIT OR Apache-2.0.
