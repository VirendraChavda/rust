---
description: "Use when adding or changing behavior in Rust crates; requires tests and workspace-level validation"
applyTo: "crates/**/{src,tests}/**/*.rs"
---

# Testing and Validation Instructions

## Test expectations
- Add or update tests for behavior changes.
- Cover at least one success path and one failure or edge path.
- Prefer deterministic tests with no external network dependencies.

## Validation commands
Run these before finalizing substantial Rust changes:

```bash
cargo fmt --all -- --check
cargo clippy --workspace --all-targets --all-features -- -D warnings
cargo test --workspace
```

## Review checklist
- Are errors actionable and typed?
- Are async boundaries and cancellation behavior clear?
- Is there at least baseline coverage for changed behavior?
