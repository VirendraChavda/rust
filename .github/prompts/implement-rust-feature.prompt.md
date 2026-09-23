---
name: "Implement Rust Feature"
description: "Implement a Rust feature with focused diffs, tests, and validation output"
agent: "Rust AI Implementer"
argument-hint: "Feature request and acceptance criteria"
---

Implement the requested feature in this workspace:

{{input}}

Requirements:
- Keep the diff minimal and focused.
- Preserve public API compatibility unless explicitly requested otherwise.
- Add or update tests.
- Run validation commands and report outcomes:
  - `cargo fmt --all -- --check`
  - `cargo clippy --workspace --all-targets --all-features -- -D warnings`
  - `cargo test --workspace`
