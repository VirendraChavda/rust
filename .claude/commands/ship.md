Run full crate ship workflow.

Task source:
- Read `.claude/task.md` and execute ship stages for that scope.

Stages:
1. /spec for remaining scope ambiguity.
2. /implement for required code/test deltas.
3. /verify for workspace quality checks.
4. /review for severity-ranked findings.
5. /release-ready for metadata and release blockers.

Output:
- Ready or blocked status
- Blocking items
- Exact next actions
