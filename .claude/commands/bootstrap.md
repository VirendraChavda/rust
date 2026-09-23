Bootstrap a new AI-focused Rust crate.

Input:
$ARGUMENTS

Steps:
1. Parse crate name and description from input.
2. Run:
   - PowerShell: ./scripts/dev/new_ai_crate.ps1 -Name <crate-name> -Description "<description>"
   - Bash: bash scripts/dev/new_ai_crate.sh <crate-name> "<description>"
3. Run cargo test for the created crate.
4. Return created files and next hardening tasks.
