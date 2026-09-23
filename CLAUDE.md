# Claude Code Project Instructions

## Mission
Build robust Rust crates for AI backend development, comparable in capability to major Python AI/ML ecosystems.

## Repository shape
- Cargo workspace root at `Cargo.toml`
- Publishable crates under `crates/*`
- Existing checks in CI: fmt, clippy, tests
- Extended checks: security, reliability, API stability, release readiness

## Guardrails
- Keep patches minimal and scoped to the request.
- Preserve public API compatibility unless explicitly asked to break it.
- Prefer typed errors and explicit state transitions.
- No destructive git commands unless explicitly requested.
- Do not add heavyweight dependencies without rationale.

## Standard execution workflow
1. Understand scope and acceptance criteria.
2. Read relevant crate docs and source files.
3. Implement focused changes.
4. Add or update tests for behavior changes.
5. Run validation:
   - `cargo fmt --all -- --check`
   - `cargo clippy --workspace --all-targets --all-features -- -D warnings`
   - `cargo test --workspace`
6. Report what changed, what was validated, and any residual risks.

## Release-readiness workflow
- Run `scripts/release/release_readiness_check.ps1` (Windows) or `scripts/release/release_readiness_check.sh` (bash).
- Treat missing changelog, README, version metadata, and license metadata as release blockers.
- For published crates, include API stability checks before go/no-go recommendation.

## Governance
- Follow engineering policy in `docs/policies/engineering-policy.md`.
- Use RFC and ADR process for major design and API decisions:
   - `docs/governance/rfc-process.md`
   - `docs/governance/adr-process.md`

## Rust AI backend design heuristics
- Use trait-first interfaces for model providers and external backends.
- Keep async boundaries explicit; include timeout/retry/cancellation behavior.
- Prefer deterministic core logic for chain, graph, and state-machine runtimes.
- Make observability hooks first-class: tracing spans and structured diagnostics.

## Review mode expectations
When asked for review, prioritize:
1. Correctness and regressions
2. Reliability and failure modes
3. Missing tests and edge cases
4. Secondary style issues
