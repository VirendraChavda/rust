# Rust AI Backend Workspace Guidelines

## Mission
Build production-grade Rust crates that are open source friendly equivalents of common AI/ML Python ecosystems.

## Scope
This workspace is a Cargo workspace with independently publishable crates under `crates/*`.

## Non-negotiable standards
- Preserve stable public APIs unless the task explicitly requests a breaking change.
- Prefer small, composable abstractions over framework-like monoliths.
- Avoid adding heavy dependencies unless there is a clear payoff in safety, performance, or maintainability.
- Keep code and comments in ASCII unless a file already uses Unicode intentionally.
- Never run destructive git commands (`git reset --hard`, `git checkout --`, history rewrites) unless explicitly asked.

## Development workflow
1. Read relevant crate docs and source before editing.
2. If behavior changes, add or update tests in `crates/<name>/tests` or module tests.
3. Run the full check workflow before finishing:
   - `cargo fmt --all -- --check`
   - `cargo clippy --workspace --all-targets --all-features -- -D warnings`
   - `cargo test --workspace`
4. For release-related changes, run additional checks:
  - `scripts/release/release_readiness_check.*`
  - `scripts/ci/api_stability_check.*` for published crates
5. Keep changes focused; do not refactor unrelated areas.

## Governance and policy
- Follow `docs/policies/engineering-policy.md` for semver, MSRV, maturity levels, and release blockers.
- Use RFC/ADR governance for major architecture and API changes:
  - `docs/governance/rfc-process.md`
  - `docs/governance/adr-process.md`

## Architecture direction
- Design crates as layered modules:
  - `core`: traits, error types, core data structures
  - `runtime`: execution, orchestration, state transitions
  - `io`: protocol adapters and external integrations
  - `observability`: tracing, metrics, and diagnostics
- Use traits and generics for provider abstraction.
- Prefer explicit error enums with actionable variants.

## AI backend concerns
- Be explicit about sync vs async boundaries.
- Treat retries, timeouts, cancellation, and idempotency as first-class concerns.
- Ensure deterministic behavior for state machine and orchestration logic.
- Require structured logging hooks for critical runtime paths.

## Review focus
Prioritize correctness, API stability, edge cases, and test coverage over style-only edits.
