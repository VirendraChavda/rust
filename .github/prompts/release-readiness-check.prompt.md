---
name: "Release Readiness Check"
description: "Auto-check crate changelog, version, license, README, and release blockers before publishing"
agent: "Rust Release Manager"
argument-hint: "Optional crate name; leave empty for all crates"
---

Run release-readiness checks for the requested crate scope:

{{input}}

Requirements:
- Execute `scripts/release/release_readiness_check.ps1` (Windows) or `scripts/release/release_readiness_check.sh` (bash).
- Report blockers for missing changelog, version, license metadata, and README.
- Recommend exact next actions to unblock release.
