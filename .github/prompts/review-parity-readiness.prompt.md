---
name: "Review Parity Readiness"
description: "Review whether a Rust module family is ready to claim a higher parity maturity level"
agent: "Rust AI Reviewer"
argument-hint: "Unused; define task in .github/task.md"
---

Review parity-readiness for this scope:

Task source:

- Read `.github/task.md` and review against target maturity in task metadata/scope.

Return findings first:

1. correctness and regression risks
2. reliability and observability gaps
3. missing tests, docs, or benchmarks

Then return: 4. recommended maturity level now 5. exact blockers for next level
