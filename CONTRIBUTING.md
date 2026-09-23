# Contributing

Thanks for contributing to this Rust AI backend workspace.

## Development prerequisites

- Rust toolchain
- Linux/WSL toolchain for primary release-path development:
  - WSL2 + Ubuntu (or Linux host)
  - gcc, g++, make, pkg-config
- Optional Windows compatibility toolchain:
  - Visual Studio Build Tools with C++ toolchain (provides `link.exe`)
- Optional: pre-commit for local checks

If tests fail with linker errors on Windows, open a Developer PowerShell session where `link.exe` is available.

Primary recommendation for EKS deployments: run full checks in Linux/WSL.

Install hooks:

```bash
pip install pre-commit
pre-commit install
```

## Core quality gates

Run before opening a PR:

- `cargo fmt --all -- --check`
- `cargo clippy --workspace --all-targets --all-features -- -D warnings`
- `cargo test --workspace`

Or use:

- `scripts/ci/full_check.sh`
- `scripts/ci/full_check.ps1`

For release-path validation (Linux/WSL):

- `scripts/ci/linux_release_check.sh`

For Windows compatibility validation:

- `scripts/ci/windows_compat_check.ps1`
- `scripts/ci/run_windows_compat_with_msvc.ps1` (auto-loads MSVC environment)

## Additional quality layers

- Reliability checks:
  - `scripts/ci/reliability_check.sh`
  - `scripts/ci/reliability_check.ps1`
- API stability checks:
  - `scripts/ci/api_stability_check.sh`
  - `scripts/ci/api_stability_check.ps1`
- Release readiness checks:
  - `scripts/release/release_readiness_check.sh`
  - `scripts/release/release_readiness_check.ps1`
- Fuzz build checks:
  - `scripts/ci/fuzz_build_check.sh`
  - `scripts/ci/fuzz_build_check.ps1`

## Governance expectations

- Engineering policy: `docs/policies/engineering-policy.md`
- RFC process: `docs/governance/rfc-process.md`
- ADR process: `docs/governance/adr-process.md`

Use RFC for major design/API changes.
Use ADR to record accepted architecture decisions.

## Crate maturity

Each crate should declare maturity in its README:

- experimental
- beta
- stable

## Branching and pull requests

- Keep PRs focused and small.
- Include tests for behavior changes.
- Document non-trivial design tradeoffs in PR description.
- For breaking changes, include migration guidance.

## Release preparation

Before publish, verify:

- Version and license metadata in Cargo.toml
- README.md present
- CHANGELOG.md present and updated
- Release-readiness checks passing

## New crate bootstrap

- Bash:

```bash
bash scripts/dev/new_ai_crate.sh <crate-name> "<description>"
```

- PowerShell:

```powershell
./scripts/dev/new_ai_crate.ps1 -Name <crate-name> -Description "<description>"
```
