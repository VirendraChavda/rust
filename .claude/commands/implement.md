Implement the Rust feature request defined in `.claude/task.md`.

Task source:
- Read `.claude/task.md` first and treat it as the source of truth.

Requirements:
1. Keep diffs minimal and focused.
2. Preserve public API compatibility unless explicitly requested.
3. If required crates/modules for the request are missing, bootstrap them with the matching `scripts/dev/bootstrap_*.ps1` or `.sh` script and continue implementation.
4. Add or update tests for behavior changes.
5. Run and summarize:
   - cargo fmt --all -- --check
   - cargo clippy --workspace --all-targets --all-features -- -D warnings
   - cargo test --workspace
6. Report residual risks, follow-ups, and any remaining parity gaps.
