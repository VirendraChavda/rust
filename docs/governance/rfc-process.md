# RFC Process

Use RFCs for cross-crate design decisions and major API changes.

## When RFC is required

- New foundational crate architecture.
- Public trait or error-model redesign.
- Runtime model changes (async strategy, scheduling, state engine behavior).
- Breaking API changes.
- Adoption of heavy core dependencies.

## Lifecycle

1. Draft RFC from template.
2. Collect review feedback.
3. Mark accepted or rejected.
4. If accepted, create implementation plan with milestones.
5. Track follow-up ADRs for key design decisions.

## Mandatory RFC sections

- Motivation and goals
- Non-goals
- Proposed design
- Alternatives considered
- Compatibility and migration impact
- Testing and observability plan
- Rollout strategy
