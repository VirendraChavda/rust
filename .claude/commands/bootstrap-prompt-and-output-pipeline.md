Bootstrap prompt handling and output parsing pipeline crates.

Task source:
- Read `.claude/task.md` and apply optional family filters from `Scope`.

Steps:
1. Run PowerShell: ./scripts/dev/bootstrap_prompt_and_output_pipeline.ps1
   or bash: bash scripts/dev/bootstrap_prompt_and_output_pipeline.sh
2. Report created and skipped modules.
3. Group implementation order by module family.
