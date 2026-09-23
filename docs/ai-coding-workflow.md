# AI Coding Workflow for Rust AI Crates

This document standardizes how to use GitHub Copilot and Claude Code in this workspace.

## Objectives
- Faster iteration with fewer regressions
- Consistent crate architecture and API quality
- Predictable validation before merge or publish

## Platform strategy
- Primary path: Linux/WSL for release-grade builds and tests (EKS aligned).
- Secondary path: Windows MSVC compatibility checks.
- Release artifacts should be produced from Linux pipeline.

## Shared quality gate
Always run one of these before finalizing substantial changes:

- Bash: `bash scripts/ci/full_check.sh`
- PowerShell: `./scripts/ci/full_check.ps1`

Release-path Linux check:

- `bash scripts/ci/linux_release_check.sh`

Windows compatibility check:

- `./scripts/ci/windows_compat_check.ps1`
- `./scripts/ci/run_windows_compat_with_msvc.ps1` (auto-loads MSVC tools)

## Autonomous Agentic Build Mode
Use this mode when requesting end-to-end agentic, AI, or backend workflows where crate coverage may be incomplete.

Execution loop:
1. Implement in existing crates when possible.
2. If required capability crates are missing, bootstrap them using the relevant `scripts/dev/bootstrap_*.ps1` or `.sh` script.
3. Add a minimal vertical slice API and tests in the new/updated crates.
4. Re-run validation and continue iterating until requested behavior is implemented or a concrete blocker is found.

Prompting pattern for both Copilot and Claude:
- "Implement <workflow>. If required Rust crates are missing, create/update them and continue until validation passes."

## Install requirements

### Linux/WSL path (recommended)
- WSL2 with Ubuntu (or equivalent Linux distro)
- Rust via rustup
- Build essentials: gcc, g++, make, pkg-config
- Optional: clang and lld

### Windows MSVC compatibility path
- Rust via rustup (`stable-x86_64-pc-windows-msvc`)
- Visual Studio Build Tools with Desktop development with C++ workload
- Use Developer PowerShell when running MSVC-based builds locally

Additional specialized checks:

- Preflight environment: `bash scripts/ci/preflight_check.sh` or `./scripts/ci/preflight_check.ps1`
- Reliability: `bash scripts/ci/reliability_check.sh` or `./scripts/ci/reliability_check.ps1`
- API stability: `bash scripts/ci/api_stability_check.sh` or `./scripts/ci/api_stability_check.ps1`
- Docs quality: `bash scripts/ci/docs_quality_check.sh` or `./scripts/ci/docs_quality_check.ps1`
- Release readiness: `bash scripts/release/release_readiness_check.sh [crate]` or `./scripts/release/release_readiness_check.ps1 -Package <crate>`
- Fuzz build checks: `bash scripts/ci/fuzz_build_check.sh` or `./scripts/ci/fuzz_build_check.ps1`

## GitHub Copilot setup (already committed)
- Project instructions: `.github/copilot-instructions.md`
- Task source file: `.github/task.md`
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
- Task source file: `.claude/task.md`
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
- Extended Python backend essentials manifest: `docs/roadmaps/python-ai-backend-essential-manifest.md`
- State machine and backend gap manifest: `docs/roadmaps/state-machine-and-backend-gap-manifest.md`
- Prompt and output pipeline manifest: `docs/roadmaps/prompt-and-output-pipeline-manifest.md`
- DAG and cyclic execution gap manifest: `docs/roadmaps/dag-and-cyclic-execution-gap-manifest.md`

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
- Extended Python backend essentials bootstrap:
  - Bash: `bash scripts/dev/bootstrap_python_backend_essentials.sh`
  - PowerShell: `./scripts/dev/bootstrap_python_backend_essentials.ps1`
- State machine and backend gaps bootstrap:
  - Bash: `bash scripts/dev/bootstrap_state_and_backend_gaps.sh`
  - PowerShell: `./scripts/dev/bootstrap_state_and_backend_gaps.ps1`
- Prompt and output pipeline bootstrap:
  - Bash: `bash scripts/dev/bootstrap_prompt_and_output_pipeline.sh`
  - PowerShell: `./scripts/dev/bootstrap_prompt_and_output_pipeline.ps1`
- DAG and cyclic execution gaps bootstrap:
  - Bash: `bash scripts/dev/bootstrap_dag_and_cyclic_execution_gaps.sh`
  - PowerShell: `./scripts/dev/bootstrap_dag_and_cyclic_execution_gaps.ps1`

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
