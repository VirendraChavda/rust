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

Project-level instruction file:

- `../CLAUDE.md`

## Quickstart

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
