Bootstrap a new AI-focused Rust crate.

Task source:
- Read `.claude/task.md` and use `Crate Targets` plus `Objective` to determine crate name and description.

Steps:
1. Parse crate name and description from `.claude/task.md`.
2. Run:
   - PowerShell: ./scripts/dev/new_ai_crate.ps1 -Name <crate-name> -Description "<description>"
   - Bash: bash scripts/dev/new_ai_crate.sh <crate-name> "<description>"
3. Run cargo test for the created crate.
4. Return created files and next hardening tasks.
