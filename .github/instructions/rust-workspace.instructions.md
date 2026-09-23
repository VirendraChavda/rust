---
description: "Use when editing Rust code in this workspace; enforces crate design, API stability, and AI backend reliability checks"
applyTo: "crates/**/*.rs"
---

# Rust Workspace File Instructions

## Code design rules
- Keep modules small and purpose-driven.
- Prefer traits for extension points and backend/provider abstraction.
- Avoid leaking implementation details through public API types.
- Use `Result<T, E>` with crate-specific error enums instead of opaque string errors.

## Reliability rules
- Handle timeouts and cancellation in async flows.
- Ensure state transitions are explicit and testable.
- Validate external inputs at module boundaries.

## Change discipline
- Keep each change cohesive and bounded.
- Do not rename public items unless requested.
- Add concise comments only where the reasoning is non-obvious.
