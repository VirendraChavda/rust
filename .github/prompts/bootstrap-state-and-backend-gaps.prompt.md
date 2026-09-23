---
name: "Bootstrap State and Backend Gaps"
description: "Scaffold remaining state-machine and backend-critical parity crates"
agent: "Rust AI Implementer"
argument-hint: "Unused; define task in .github/task.md"
---

Bootstrap state-machine and backend gap crates for this scope:

Task source:

- Read `.github/task.md` and apply optional family filters from `Scope`.

Requirements:

- Use `scripts/dev/bootstrap_state_and_backend_gaps.ps1` on Windows or `scripts/dev/bootstrap_state_and_backend_gaps.sh` on bash.
- Do not overwrite existing crates.
- Report created and skipped counts.
- Return implementation priority by family.
