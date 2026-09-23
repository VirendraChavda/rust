# Agent Orchestration Workflow

This workflow aligns Copilot and Claude into the same multi-stage delivery loop.

## Stages

1. Spec stage
- Define scope, API, and compatibility constraints.
- Output: design proposal with acceptance criteria.

2. Implement stage
- Apply minimal focused changes.
- Add tests for behavior changes.
- Output: patch plus test updates.

3. Verify stage
- Run quality gate and reliability checks.
- Output: pass/fail with error excerpts.

4. Review stage
- Severity-first review for regressions and reliability risks.
- Output: findings with fix order.

5. Release-ready stage
- Run release metadata and API stability checks.
- Output: go/no-go decision.

## Stop conditions

- Stop and fix before proceeding if any stage fails.
- Do not proceed to publish recommendation with unresolved blockers.

## Command mapping

Copilot prompts:
- Spec Rust AI Module
- Implement Rust Feature
- Review Rust Change
- Release Readiness Check

Claude commands:
- /spec
- /implement
- /verify
- /review
- /release-ready
