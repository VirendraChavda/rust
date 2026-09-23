---
name: "Ship Rust Crate"
description: "Run staged orchestration: spec, implement, verify, review, and release-readiness for a crate scope"
agent: "Rust Release Manager"
argument-hint: "Unused; define task in .github/task.md"
---

Run the full release orchestration for this scope:

Task source:

- Read `.github/task.md` and execute the orchestration for that scope.

Stages:

1. Confirm acceptance criteria and release scope.
2. Verify implementation and tests are complete.
3. Run quality gates and reliability checks.
4. Run review-focused risk checks.
5. Run release-readiness checks and provide go/no-go.

Do not provide go recommendation if any blocker remains.
