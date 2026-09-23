---
name: "Bootstrap Prompt and Output Pipeline"
description: "Scaffold prompt handling, output parsing, and agentic pipeline parity crates"
agent: "Rust AI Implementer"
argument-hint: "Unused; define task in .github/task.md"
---

Bootstrap prompt and output pipeline crates for this scope:

Task source:

- Read `.github/task.md` and apply optional family filters from `Scope`.

Requirements:

- Use `scripts/dev/bootstrap_prompt_and_output_pipeline.ps1` on Windows or `scripts/dev/bootstrap_prompt_and_output_pipeline.sh` on bash.
- Do not overwrite existing crates.
- Report created and skipped counts.
- Return implementation priority by family.
