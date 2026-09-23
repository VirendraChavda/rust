# GitHub Copilot Setup

This folder contains workspace-level Copilot configuration for Rust AI backend development.

## What is configured

- Global project guidance:
  - `copilot-instructions.md`
- File-scoped guidance:
  - `instructions/rust-workspace.instructions.md`
  - `instructions/rust-testing.instructions.md`
- Custom agents:
  - `agents/rust-architect.agent.md`
  - `agents/rust-implementer.agent.md`
  - `agents/rust-reviewer.agent.md`
  - `agents/rust-release-manager.agent.md`
  - `agents/rust-agent-runtime-specialist.agent.md`
  - `agents/rust-ml-data-specialist.agent.md`
  - `agents/rust-serving-integration-specialist.agent.md`
- Domain skills:
  - `skills/rust-python-parity-planning/SKILL.md`
  - `skills/rust-runtime-reliability/SKILL.md`
- Reusable prompts:
  - `prompts/spec-rust-ai-module.prompt.md`
  - `prompts/implement-rust-feature.prompt.md`
  - `prompts/review-rust-change.prompt.md`
  - `prompts/bootstrap-ai-crate.prompt.md`
  - `prompts/release-readiness-check.prompt.md`
  - `prompts/ship-rust-crate.prompt.md`
  - `prompts/parity-gap-analysis.prompt.md`
  - `prompts/implement-parity-milestone.prompt.md`
  - `prompts/review-parity-readiness.prompt.md`
  - `prompts/bootstrap-all-parity-modules.prompt.md`

## Quickstart

1. Open Copilot Chat in this workspace.
2. Use slash prompts from this repo by typing `/` and selecting one.
3. For a new feature:
   - Run `Spec Rust AI Module`
   - Run `Implement Rust Feature`
   - Run `Review Rust Change`
   - Run `Release Readiness Check`

4. For Python-parity module planning:
  - Run `Parity Gap Analysis`
  - Run `Implement Parity Milestone`
  - Run `Review Parity Readiness`

## Common workflows

### Bootstrap a new crate
Use prompt: `Bootstrap AI Crate`

Expected effect:
- Runs crate bootstrap script
- Generates README and changelog
- Adds smoke tests

### Bootstrap full parity module surface
Use prompt: `Bootstrap All Parity Modules`

Expected effect:
- Scaffolds all parity crates from the module manifest
- Skips crates that already exist
- Reports next implementation order by family

### Prepare release
Use prompt: `Ship Rust Crate`

Expected effect:
- Runs staged validation and review path
- Checks release metadata completeness
- Produces go/no-go recommendation

## Validation scripts to know

- Full checks:
  - `scripts/ci/full_check.ps1`
  - `scripts/ci/full_check.sh`
- Reliability checks:
  - `scripts/ci/reliability_check.ps1`
  - `scripts/ci/reliability_check.sh`
- API stability checks:
  - `scripts/ci/api_stability_check.ps1`
  - `scripts/ci/api_stability_check.sh`
- Release readiness checks:
  - `scripts/release/release_readiness_check.ps1`
  - `scripts/release/release_readiness_check.sh`

## Source of truth docs

- Combined workflow: `docs/ai-coding-workflow.md`
- Agent orchestration: `docs/agent-orchestration.md`
- Engineering policy: `docs/policies/engineering-policy.md`
- Python parity context: `docs/knowledge/python-to-rust-module-context.md`
- Parity matrix: `docs/roadmaps/module-parity-matrix.md`
- Full parity manifest: `docs/roadmaps/parity-module-manifest.md`
