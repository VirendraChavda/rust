---
name: "Release Readiness Check"
description: "Auto-check crate changelog, version, license, README, and release blockers before publishing"
agent: "Rust Release Manager"
argument-hint: "Unused; define task in .github/task.md"
---

Run release-readiness checks for the requested crate scope:

Task source:

- Read `.github/task.md` and derive release scope from `Crate Targets` and `Acceptance Criteria`.

Requirements:

- Execute `scripts/release/release_readiness_check.ps1` (Windows) or `scripts/release/release_readiness_check.sh` (bash).
- Report blockers for missing changelog, version, license metadata, and README.
- Recommend exact next actions to unblock release.
