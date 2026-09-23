---
name: "Bootstrap Python Backend Essentials"
description: "Scaffold the extended set of essential Python AI-backend parity crates in Rust"
agent: "Rust AI Implementer"
argument-hint: "Unused; define task in .github/task.md"
---

Bootstrap essential Python-backend parity crates for this scope:

Task source:

- Read `.github/task.md` and apply optional family filters from `Scope`.

Requirements:

- Use `scripts/dev/bootstrap_python_backend_essentials.ps1` on Windows or `scripts/dev/bootstrap_python_backend_essentials.sh` on bash.
- Do not overwrite existing crates.
- Report created and skipped counts.
- Return implementation priority by family.
