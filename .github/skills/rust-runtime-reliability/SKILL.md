---
name: rust-runtime-reliability
description: "Use when implementing or reviewing runtime-critical Rust modules (agent chains, graph execution, serving layers) to enforce deterministic behavior, failure handling, and observability."
---

# Rust Runtime Reliability Skill

## Use this skill when

- editing runtime orchestration behavior
- adding retries, timeout policies, cancellation semantics
- assessing reliability regressions and state consistency risks

## Workflow

1. Read `.github/task.md` and extract objective, scope, crate targets, and acceptance criteria.
2. Identify runtime boundaries and state transitions.
3. Validate retry, timeout, cancellation, and idempotency behavior.
4. Require deterministic tests and failure-mode coverage.
5. Run reliability and full CI checks.

## Output format

1. Reliability findings
2. Required code/test deltas
3. Validation results
4. Residual risk notes
