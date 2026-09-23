# Copilot Task File

This file is the single source of truth for Copilot prompt execution in this workspace.

## How to use
1. Fill in this file before invoking prompts from `.github/prompts/`.
2. Run prompt commands (for example, `Implement Rust Feature`) without passing detailed chat input.
3. Keep this file updated as scope changes.

## Task Metadata
- task_id: TASK-YYYYMMDD-001
- owner: <name>
- date: <YYYY-MM-DD>
- priority: <P0|P1|P2>
- stage: <spec|implement|verify|review|release>
- status: <todo|in-progress|blocked|done>

## Objective
Describe the exact AI/backend workflow to implement.

## Problem Context
- Why this work matters
- Current state and gap
- Expected operational impact

## Scope
- In scope:
  - <item>
- Out of scope:
  - <item>

## Crate Targets
- Existing crates to modify:
  - crates/<crate-name>
- Allowed new crates (if missing capability is found):
  - crates/<new-crate-name>

## Autonomous Gap-Closing Policy
- If capability is missing, create/update crates in `crates/*`.
- Prefer evolving existing crates before creating new crates.
- For single crate bootstrap, use `scripts/dev/new_ai_crate.ps1` or `scripts/dev/new_ai_crate.sh`.
- For family-level parity gaps, use matching `scripts/dev/bootstrap_*.ps1` or `.sh` scripts.

## API and Compatibility Rules
- Keep APIs non-breaking unless explicitly authorized here.
- If breaking change is needed, include migration notes here first.
- Justify heavyweight dependencies here before adding them.

## Acceptance Criteria
- [ ] End-to-end behavior implemented
- [ ] Tests updated for success/failure/edge paths
- [ ] Reliability expectations covered (timeouts/retries/cancellation/determinism when relevant)
- [ ] Docs and changelog updated where needed

## Validation Plan
Default quality gate:
- cargo fmt --all -- --check
- cargo clippy --workspace --all-targets --all-features -- -D warnings
- cargo test --workspace

Focused fallback (when workspace has unrelated pre-existing issues):
- cargo clippy -p <crate> --all-targets --all-features -- -D warnings
- cargo test -p <crate>

## Deliverables
- Changed files and rationale
- Validation/test results
- Residual risks
- Remaining parity gaps and next milestone

## Notes For Agents
- Read this file first.
- Treat this file as higher priority than prompt input text.
- If required fields are missing, proceed with conservative assumptions and state them in the final report.
