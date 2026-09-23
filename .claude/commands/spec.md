Create a technical specification for the task defined in `.claude/task.md`.

Task source:
- Read `.claude/task.md` first and use it as the authoritative scope and acceptance criteria.

Return:
1. Problem statement and scope
2. Proposed public API (traits, structs, enums)
3. Internal module breakdown
4. Error handling model
5. Test strategy
6. Non-breaking rollout milestones

Constraints:
- Prefer composable crate/module boundaries.
- Keep performance and reliability tradeoffs explicit.
