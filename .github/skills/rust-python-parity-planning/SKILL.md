---
name: rust-python-parity-planning
description: "Use when planning Rust parity with Python module ecosystems such as LangChain, LangGraph, sklearn, pandas, FastAPI, SQLAlchemy, websockets, and boto3. Produces milestone plans, API targets, and maturity checkpoints."
---

# Rust Python Parity Planning Skill

## Use this skill when
- defining new crate families that mirror Python ecosystem capabilities
- prioritizing parity milestones and maturity levels
- deciding test and reliability requirements for parity claims

## Inputs expected
- target module family
- desired maturity level (L1-L4)
- constraints (performance, compatibility, timeline)

## Workflow
1. Map target family using `docs/knowledge/python-to-rust-module-context.md`.
2. Identify current and target level in `docs/roadmaps/module-parity-matrix.md`.
3. Produce milestone plan with API, reliability, and test deliverables.
4. Recommend agent and command workflow for execution.

## Output format
1. Parity gap summary
2. Proposed milestones
3. Risks and assumptions
4. Verification checklist
