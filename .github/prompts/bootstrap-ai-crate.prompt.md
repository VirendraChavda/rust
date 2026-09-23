---
name: "Bootstrap AI Crate"
description: "Create a new AI-focused Rust crate scaffold in crates/ using workspace conventions"
agent: "Rust AI Implementer"
argument-hint: "Crate name and one-line description"
---

Bootstrap a new crate using workspace conventions.

Input:
{{input}}

Requirements:
- Use the script `scripts/dev/new_ai_crate.ps1` on Windows or `scripts/dev/new_ai_crate.sh` on bash.
- Ensure README, CHANGELOG, smoke test, and metadata are generated.
- Run `cargo test -p <crate-name>` and report results.
- Return follow-up tasks to make the crate production-ready.
