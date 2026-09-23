Bootstrap missing DAG and cyclic graph execution crates.

Task source:
- Read `.claude/task.md` and apply optional family filters from `Scope`.

Steps:
1. Run PowerShell: ./scripts/dev/bootstrap_dag_and_cyclic_execution_gaps.ps1
   or bash: bash scripts/dev/bootstrap_dag_and_cyclic_execution_gaps.sh
2. Report created and skipped modules.
3. Group implementation order by graph-runtime family.
