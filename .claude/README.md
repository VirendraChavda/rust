# Claude Code Setup

This folder contains Claude Code command templates for Rust AI backend development.

## What is configured

Commands in `commands/`:

- `spec.md`
- `implement.md`
- `verify.md`
- `review.md`
- `bootstrap.md`
- `release-ready.md`
- `ship.md`
- `parity-gap.md`
- `parity-implement.md`
- `parity-review.md`
- `bootstrap-all-parity.md`
- `bootstrap-python-backend-essentials.md`
- `bootstrap-state-and-backend-gaps.md`
- `bootstrap-prompt-and-output-pipeline.md`
- `bootstrap-dag-and-cyclic-execution-gaps.md`

Project-level instruction file:

- `../CLAUDE.md`

## Quickstart

0. Define task in `.claude/task.md` (source of truth for commands).
1. Open Claude Code in this workspace.
2. Run staged commands:
   - `/spec <feature or crate request>`
   - `/implement <approved scope>`
   - `/verify`
   - `/review <diff scope>`
   - `/release-ready <optional-crate-name>`

3. For Python-parity module maturity work:
   - `/parity-gap <module-family and target-level>`
   - `/parity-implement <milestone-scope>`
   - `/parity-review <module-family and claimed-level>`

## Common workflows

### Autonomous Gap-Closing Implementation
Command:
- `/implement <workflow request and acceptance criteria>`

Expected effect:
- Implements requested behavior in existing crates first
- If required crates are missing, bootstraps them from the relevant manifest scripts and continues implementation
- Adds tests and returns residual parity gaps in priority order

Recommended command style:
- `/implement Implement <workflow>. If required crates are missing, create/update them and continue until validation passes.`

Task-file mode note:
- Commands in `.claude/commands/` are configured to read `.claude/task.md` instead of relying on command argument text.

### Bootstrap a new crate
Command:
- `/bootstrap <crate-name and description>`

Expected effect:
- Runs crate bootstrap script
- Generates metadata docs
- Adds minimal test scaffold

### Ship flow
Command:
- `/ship <crate and release scope>`

Expected effect:
- Executes staged orchestration
- Runs verification and release readiness checks
- Returns blocked or ready recommendation

### Bootstrap full parity module surface
Command:
- `/bootstrap-all-parity`

Expected effect:
- Scaffolds all parity crates from manifest
- Skips already existing crates
- Returns family-based next priority order

### Bootstrap extended Python backend essentials
Command:
- `/bootstrap-python-backend-essentials`

Expected effect:
- Scaffolds expanded backend-essential parity crates
- Skips already existing crates
- Returns family-based next priority order

### Bootstrap state machine and backend gaps
Command:
- `/bootstrap-state-and-backend-gaps`

Expected effect:
- Scaffolds state-machine and backend-critical missing crates
- Skips already existing crates
- Returns family-based next priority order

### Bootstrap prompt and output pipeline crates
Command:
- `/bootstrap-prompt-and-output-pipeline`

Expected effect:
- Scaffolds prompt, parsing, and agentic pipeline-critical crates
- Skips already existing crates
- Returns family-based next priority order

### Bootstrap DAG and cyclic execution gaps
Command:
- `/bootstrap-dag-and-cyclic-execution-gaps`

Expected effect:
- Scaffolds missing DAG/cyclic graph execution crates
- Skips already existing crates
- Returns family-based next priority order

## Validation scripts to know

- `scripts/ci/full_check.ps1`
- `scripts/ci/full_check.sh`
- `scripts/ci/reliability_check.ps1`
- `scripts/ci/reliability_check.sh`
- `scripts/ci/api_stability_check.ps1`
- `scripts/ci/api_stability_check.sh`
- `scripts/release/release_readiness_check.ps1`
- `scripts/release/release_readiness_check.sh`

## Source of truth docs

- `docs/ai-coding-workflow.md`
- `docs/agent-orchestration.md`
- `docs/policies/engineering-policy.md`
- `docs/knowledge/python-to-rust-module-context.md`
- `docs/roadmaps/module-parity-matrix.md`
- `docs/roadmaps/parity-module-manifest.md`
- `docs/roadmaps/python-ai-backend-essential-manifest.md`
- `docs/roadmaps/state-machine-and-backend-gap-manifest.md`
- `docs/roadmaps/prompt-and-output-pipeline-manifest.md`
- `docs/roadmaps/dag-and-cyclic-execution-gap-manifest.md`
