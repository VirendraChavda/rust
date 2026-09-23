# Claude Task File

This file is the single source of truth for Claude command execution in this workspace.

## How to use
1. Fill in all sections before running commands in `.claude/commands/`.
2. Run `/spec`, `/implement`, `/verify`, `/review`, or `/ship` without relying on chat arguments.
3. Update this file when scope changes.

## Task Metadata
- task_id: TASK-YYYYMMDD-001
- owner: <name>
- date: <YYYY-MM-DD>
- priority: <P0|P1|P2>
- stage: <spec|implement|verify|review|release>
- status: <todo|in-progress|blocked|done>

## Objective
Describe the exact backend/agentic workflow to build.

## Problem Context
- Why this change is needed
- User/system impact
- Current limitation

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
- If required capability is missing, create/update crates in `crates/*`.
- Prefer extending existing crates first; create new crates only when separation is justified.
- For new crates, use `scripts/dev/new_ai_crate.ps1` on Windows or `scripts/dev/new_ai_crate.sh` on bash.
- For known parity families, use the matching bootstrap scripts in `scripts/dev/`.

## API and Compatibility Rules
- Preserve public APIs unless this task explicitly allows breaking changes.
- If a breaking change is required, document migration notes in this file before implementation.
- Avoid heavy dependencies unless justified in this file.

## Acceptance Criteria
- [ ] Behavior implemented end-to-end
- [ ] Tests added/updated for new behavior and edge cases
- [ ] Determinism/reliability concerns addressed where applicable
- [ ] Documentation updated (README/changelog/docs as needed)

## Validation Plan
Run and report these commands unless scope says otherwise:
- cargo fmt --all -- --check
- cargo clippy --workspace --all-targets --all-features -- -D warnings
- cargo test --workspace

Optional focused checks (if workspace-wide gate is noisy):
- cargo clippy -p <crate> --all-targets --all-features -- -D warnings
- cargo test -p <crate>

## Deliverables
- File-level change summary
- Test evidence
- Residual risks
- Remaining parity gaps and next milestone

## Notes For Agents
- Read this file first.
- Use this file over chat arguments when they conflict.
- If information is missing, proceed with safest assumptions and document them in the output.
