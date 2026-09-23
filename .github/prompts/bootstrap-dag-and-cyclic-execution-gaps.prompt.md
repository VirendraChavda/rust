---
name: "Bootstrap DAG and Cyclic Execution Gaps"
description: "Scaffold missing DAG and cyclic graph execution crates for agentic runtimes"
agent: "Rust Agent Runtime Specialist"
argument-hint: "Unused; define task in .github/task.md"
---

Bootstrap DAG and cyclic execution gap crates for this scope:

Task source:

- Read `.github/task.md` and apply optional family filters from `Scope`.

Requirements:

- Use `scripts/dev/bootstrap_dag_and_cyclic_execution_gaps.ps1` on Windows or `scripts/dev/bootstrap_dag_and_cyclic_execution_gaps.sh` on bash.
- Do not overwrite existing crates.
- Report created and skipped counts.
- Return implementation priority by graph-runtime family.
