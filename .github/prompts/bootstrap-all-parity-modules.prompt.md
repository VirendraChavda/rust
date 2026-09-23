---
name: "Bootstrap All Parity Modules"
description: "Scaffold the full Rust AI parity module catalog as workspace crates"
agent: "Rust AI Implementer"
argument-hint: "Unused; define task in .github/task.md"
---

Bootstrap parity modules for this scope:

Task source:

- Read `.github/task.md` and apply optional family filters from `Scope`.

Requirements:

- Use `scripts/dev/bootstrap_parity_modules.ps1` on Windows or `scripts/dev/bootstrap_parity_modules.sh` on bash.
- Do not overwrite existing crates.
- Report created and skipped module counts.
- Provide next implementation order by family.
