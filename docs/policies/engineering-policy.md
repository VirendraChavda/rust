# Engineering Policy

This policy defines baseline standards for all crates in this workspace.

## Versioning and stability

- Follow semantic versioning for all published crates.
- Public API breaking changes require a major version bump.
- Add deprecation notes before removing stable APIs when practical.

## MSRV

- Workspace Minimum Supported Rust Version (MSRV): 1.84.0.
- Raise MSRV only with changelog entry and release notes.
- CI must validate on stable and MSRV where possible.

## Platform strategy

- Primary release target: Linux (EKS-aligned runtime).
- Required release gates are Linux-based checks and release-readiness validation.
- Secondary compatibility target: Windows MSVC.
- Windows checks validate cross-platform compatibility but are not the primary release artifact source.

## Crate maturity levels

- experimental: API may change frequently.
- beta: API mostly stable, breaking changes must be justified.
- stable: API changes must preserve compatibility in minor releases.

Each crate README must declare its maturity level.

## Error and reliability standards

- Prefer typed error enums over string errors.
- Timeouts, retries, cancellation, and idempotency must be explicit in runtime-facing APIs.
- State transitions should be deterministic and testable.

## Documentation standards

- Every crate must include README.md and CHANGELOG.md.
- Public APIs should have rustdoc comments, especially trait methods and error variants.
- Include examples for primary user-facing flows.

## Dependency policy

- Keep dependency surface minimal.
- New heavy dependencies require rationale in PR description.
- Security and license checks must pass before release.

## Release blockers

A release is blocked if any of the following fail:
- Formatting, lint, or tests.
- Security checks.
- License policy checks.
- Release-readiness checks.
- API stability checks for published crates.
- Linux release-path checks.
