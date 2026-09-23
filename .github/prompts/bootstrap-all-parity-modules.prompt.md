---
name: "Bootstrap All Parity Modules"
description: "Scaffold the full Rust AI parity module catalog as workspace crates"
agent: "Rust AI Implementer"
argument-hint: "Optional subset pattern or family"
---

Bootstrap parity modules for this scope:

{{input}}

Requirements:
- Use `scripts/dev/bootstrap_parity_modules.ps1` on Windows or `scripts/dev/bootstrap_parity_modules.sh` on bash.
- Do not overwrite existing crates.
- Report created and skipped module counts.
- Provide next implementation order by family.
