# AI Coding Workflow for Rust AI Crates

This document standardizes how to use GitHub Copilot and Claude Code in this workspace.

## Objectives
- Faster iteration with fewer regressions
- Consistent crate architecture and API quality
- Predictable validation before merge or publish

## Shared quality gate
Always run one of these before finalizing substantial changes:

- Bash: `bash scripts/ci/full_check.sh`
- PowerShell: `./scripts/ci/full_check.ps1`

Additional specialized checks:

- Reliability: `bash scripts/ci/reliability_check.sh` or `./scripts/ci/reliability_check.ps1`
- API stability: `bash scripts/ci/api_stability_check.sh` or `./scripts/ci/api_stability_check.ps1`
- Docs quality: `bash scripts/ci/docs_quality_check.sh` or `./scripts/ci/docs_quality_check.ps1`
- Release readiness: `bash scripts/release/release_readiness_check.sh [crate]` or `./scripts/release/release_readiness_check.ps1 -Package <crate>`
- Fuzz build checks: `bash scripts/ci/fuzz_build_check.sh` or `./scripts/ci/fuzz_build_check.ps1`

## GitHub Copilot setup (already committed)
- Project instructions: `.github/copilot-instructions.md`
- File-scoped instructions:
  - `.github/instructions/rust-workspace.instructions.md`
  - `.github/instructions/rust-testing.instructions.md`
- Custom agents:
  - `.github/agents/rust-architect.agent.md`
  - `.github/agents/rust-implementer.agent.md`
  - `.github/agents/rust-reviewer.agent.md`
  - `.github/agents/rust-release-manager.agent.md`
- Prompt shortcuts:
  - `.github/prompts/spec-rust-ai-module.prompt.md`
  - `.github/prompts/implement-rust-feature.prompt.md`
  - `.github/prompts/review-rust-change.prompt.md`
  - `.github/prompts/bootstrap-ai-crate.prompt.md`
  - `.github/prompts/release-readiness-check.prompt.md`
  - `.github/prompts/ship-rust-crate.prompt.md`
  - `.github/prompts/parity-gap-analysis.prompt.md`
  - `.github/prompts/implement-parity-milestone.prompt.md`
  - `.github/prompts/review-parity-readiness.prompt.md`
 - Domain skills:
  - `.github/skills/rust-python-parity-planning/SKILL.md`
  - `.github/skills/rust-runtime-reliability/SKILL.md`

### Suggested Copilot workflow
1. Run prompt: `Spec Rust AI Module`
2. Run prompt: `Implement Rust Feature`
3. Run prompt: `Review Rust Change`
4. Resolve review findings
5. Run `scripts/ci/full_check`
6. Run `Release Readiness Check` before publish

### Python parity workflow in Copilot
1. Run prompt: `Parity Gap Analysis`
2. Run prompt: `Implement Parity Milestone`
3. Run prompt: `Review Parity Readiness`

## Claude Code setup (already committed)
- Project instruction file: `CLAUDE.md`
- Command prompts:
  - `.claude/commands/spec.md`
  - `.claude/commands/implement.md`
  - `.claude/commands/verify.md`
  - `.claude/commands/review.md`
  - `.claude/commands/bootstrap.md`
  - `.claude/commands/release-ready.md`
  - `.claude/commands/ship.md`
  - `.claude/commands/parity-gap.md`
  - `.claude/commands/parity-implement.md`
  - `.claude/commands/parity-review.md`

### Suggested Claude workflow
1. `/spec <crate or feature request>`
2. `/implement <approved scope and acceptance criteria>`
3. `/verify`
4. `/review <diff summary or PR scope>`
5. `/release-ready <optional-crate-name>`

### Python parity workflow in Claude
1. `/parity-gap <module-family and target-level>`
2. `/parity-implement <milestone-scope>`
3. `/parity-review <module-family and claimed-level>`

## Guardrail policy
- No destructive git operations unless explicitly approved.
- No breaking API changes without clear migration notes.
- No new heavy dependencies without explicit rationale.
- Any behavior change must include test updates.

## Governance and policy layer
- Engineering policy: `docs/policies/engineering-policy.md`
- RFC process: `docs/governance/rfc-process.md`
- ADR process: `docs/governance/adr-process.md`
- Templates:
  - `docs/templates/rfc-template.md`
  - `docs/templates/adr-template.md`

## Domain knowledge layer
- Python-to-Rust context map: `docs/knowledge/python-to-rust-module-context.md`
- Maturity tracking matrix: `docs/roadmaps/module-parity-matrix.md`
- Full parity module manifest: `docs/roadmaps/parity-module-manifest.md`

## Automation layers
- Dependency updates:
  - `.github/dependabot.yml`
- Toolchain compatibility:
  - `.github/workflows/msrv.yml`
- Security and supply chain:
  - `deny.toml`
  - `.github/workflows/security.yml`
- Reliability and performance:
  - `.github/workflows/reliability.yml`
  - `scripts/ci/reliability_check.sh`
  - `scripts/ci/reliability_check.ps1`
- Fuzzing:
  - `.github/workflows/fuzz.yml`
  - `scripts/ci/fuzz_build_check.sh`
  - `scripts/ci/fuzz_build_check.ps1`
  - `docs/testing/fuzzing.md`
- API stability:
  - `.github/workflows/api-stability.yml`
  - `scripts/ci/api_stability_check.sh`
  - `scripts/ci/api_stability_check.ps1`
- Release readiness:
  - `.github/workflows/release-readiness.yml`
  - `scripts/release/release_readiness_check.sh`
  - `scripts/release/release_readiness_check.ps1`

## Crate bootstrap command set
- Bash: `bash scripts/dev/new_ai_crate.sh <crate-name> "<description>"`
- PowerShell: `./scripts/dev/new_ai_crate.ps1 -Name <crate-name> -Description "<description>"`
- Fuzz scaffold bootstrap:
  - Bash: `bash scripts/dev/init_fuzz_for_crate.sh <crate-name>`
  - PowerShell: `./scripts/dev/init_fuzz_for_crate.ps1 -Crate <crate-name>`
- Full parity module bootstrap:
  - Bash: `bash scripts/dev/bootstrap_parity_modules.sh`
  - PowerShell: `./scripts/dev/bootstrap_parity_modules.ps1`

## Orchestration
- Stage model and stop conditions: `docs/agent-orchestration.md`

## Crate evolution playbook
For each new capability family (agent chain, graph runtime, model APIs, dataframes, orchestration):
1. Start with a trait-first core API.
2. Implement a minimal usable vertical slice.
3. Add integration adapters behind feature flags.
4. Add observability and benchmarking hooks.
5. Publish incremental non-breaking versions.

## Recommended PR structure
- PR 1: core traits and error model
- PR 2: runtime behavior and tests
- PR 3: adapter integrations and docs
- PR 4: performance and observability improvements

## Contributor onboarding
- Contributor process and PR expectations: `CONTRIBUTING.md`
