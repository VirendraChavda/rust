Implement the following Rust feature request:

$ARGUMENTS

Requirements:
1. Keep diffs minimal and focused.
2. Preserve public API compatibility unless explicitly requested.
3. Add or update tests for behavior changes.
4. Run and summarize:
   - cargo fmt --all -- --check
   - cargo clippy --workspace --all-targets --all-features -- -D warnings
   - cargo test --workspace
5. Report residual risks and follow-ups.
