Run release-readiness checks before publish.

Input:
$ARGUMENTS

Steps:
1. If a crate name is provided, run checks for that crate only.
2. Execute:
   - PowerShell: ./scripts/release/release_readiness_check.ps1 -Package <crate-name>
   - Bash: bash scripts/release/release_readiness_check.sh <crate-name>
3. Report pass/fail and blockers.
4. Include a go/no-go recommendation.
