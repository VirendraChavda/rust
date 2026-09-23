# rust

Repo for Rust modules focused on AI backend development.

## Repository structure

This repository is configured as a Cargo workspace for multi-crate development.

- Workspace root: `/home/runner/work/rust/rust/Cargo.toml`
- Crates directory: `/home/runner/work/rust/rust/crates/*`
- Crates currently included:
  - `/home/runner/work/rust/rust/crates/rust`
  - `/home/runner/work/rust/rust/crates/agent-chain`

You can add more crates under `crates/` and version/publish them independently.

## Development setup

Install pre-commit hooks locally:

```bash
pip install pre-commit
pre-commit install
```

Run checks:

```bash
pre-commit run --all-files
cargo test --workspace
```

## AI coding setup

This repository includes preconfigured workflows for both GitHub Copilot and Claude Code.

- Setup and usage guide: `docs/ai-coding-workflow.md`
- Copilot setup reference: `.github/README.md`
- Claude setup reference: `.claude/README.md`
- Orchestration stages: `docs/agent-orchestration.md`
- Engineering policy: `docs/policies/engineering-policy.md`
- Python parity context: `docs/knowledge/python-to-rust-module-context.md`
- Module parity matrix: `docs/roadmaps/module-parity-matrix.md`
- Full parity module manifest: `docs/roadmaps/parity-module-manifest.md`
- Contributor guide: `CONTRIBUTING.md`
- Unified validation scripts:
  - `scripts/ci/full_check.sh`
  - `scripts/ci/full_check.ps1`
- Fuzzing guide:
  - `docs/testing/fuzzing.md`
- Dependency updates:
  - `.github/dependabot.yml`
- Crate bootstrap scripts:
  - `scripts/dev/new_ai_crate.sh`
  - `scripts/dev/new_ai_crate.ps1`
  - `scripts/dev/bootstrap_parity_modules.sh`
  - `scripts/dev/bootstrap_parity_modules.ps1`
- Release-readiness scripts:
  - `scripts/release/release_readiness_check.sh`
  - `scripts/release/release_readiness_check.ps1`

## Publishing crates

- Manual publish workflow: run `Publish Crate` with `package=<crate-name>`.
- Release publish: create a tag in `<package>-v<version>` format.

## License

Dual-licensed under:

- Apache License, Version 2.0 ([LICENSE](/LICENSE))
- MIT license ([LICENSE-MIT](/LICENSE-MIT))
