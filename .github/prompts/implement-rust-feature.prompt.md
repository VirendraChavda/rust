---
name: "Implement Rust Feature"
description: "Implement a Rust feature with focused diffs, tests, and validation output"
agent: "Rust AI Implementer"
argument-hint: "Unused; define task in .github/task.md"
---

Implement the requested feature in this workspace:

Task source:

- Read `.github/task.md` first and treat it as the source of truth.

Requirements:

- Keep the diff minimal and focused.
- Preserve public API compatibility unless explicitly requested otherwise.
- If requested behavior depends on missing crates/modules, bootstrap missing crates using the relevant scripts in `scripts/dev/` and continue implementation.
- Prefer adding minimal viable APIs first, then iterate with tests.
- Add or update tests.
- Run validation commands and report outcomes:
  - `cargo fmt --all -- --check`
  - `cargo clippy --workspace --all-targets --all-features -- -D warnings`
  - `cargo test --workspace`
