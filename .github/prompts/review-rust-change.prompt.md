---
name: "Review Rust Change"
description: "Review Rust changes for bugs, regressions, and missing tests"
agent: "Rust AI Reviewer"
argument-hint: "Unused; define task in .github/task.md"
---

Review the change request below:

Task source:

- Read `.github/task.md` and review changes against its scope and acceptance criteria.

Return findings first, ordered by severity:

1. Bugs and behavioral regressions
2. Reliability and performance risks
3. Missing tests

Then return: 4. Open questions 5. Suggested patch plan
