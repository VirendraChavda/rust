Run full workspace validation for Rust crates and summarize outcome.

If specific crate scope is provided, validate that crate first and then workspace-wide if requested.

Task source:
- Read `.claude/task.md` and derive scope from `Crate Targets` and `Validation Plan`.

Commands:
1. cargo fmt --all -- --check
2. cargo clippy --workspace --all-targets --all-features -- -D warnings
3. cargo test --workspace

Output:
- Pass or fail for each command
- Key error excerpts
- Exact next-fix order
