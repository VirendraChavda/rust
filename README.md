# rust

Repo for Rust modules focused on AI backend development.

## Repository structure

This repository is configured as a Cargo workspace for multi-crate development.

- Workspace root: `Cargo.toml`
- Crates directory: `crates/*`
- Crates are organized by capability families (agent runtime, graph execution, serving, storage, observability, workflow, retrieval, etc.).

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
- Platform strategy (Linux primary, Windows compatibility): `docs/ai-coding-workflow.md`
- Python parity context: `docs/knowledge/python-to-rust-module-context.md`
- Module parity matrix: `docs/roadmaps/module-parity-matrix.md`
- Full parity module manifest: `docs/roadmaps/parity-module-manifest.md`
- Extended Python backend essentials manifest: `docs/roadmaps/python-ai-backend-essential-manifest.md`
- State machine and backend gap manifest: `docs/roadmaps/state-machine-and-backend-gap-manifest.md`
- Prompt and output pipeline manifest: `docs/roadmaps/prompt-and-output-pipeline-manifest.md`
- DAG and cyclic execution gap manifest: `docs/roadmaps/dag-and-cyclic-execution-gap-manifest.md`
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
  - `scripts/dev/bootstrap_python_backend_essentials.sh`
  - `scripts/dev/bootstrap_python_backend_essentials.ps1`
  - `scripts/dev/bootstrap_state_and_backend_gaps.sh`
  - `scripts/dev/bootstrap_state_and_backend_gaps.ps1`
  - `scripts/dev/bootstrap_prompt_and_output_pipeline.sh`
  - `scripts/dev/bootstrap_prompt_and_output_pipeline.ps1`
  - `scripts/dev/bootstrap_dag_and_cyclic_execution_gaps.sh`
  - `scripts/dev/bootstrap_dag_and_cyclic_execution_gaps.ps1`

## Autonomous gap-closing workflow

You can direct Copilot or Claude to implement an AI/backend workflow and close missing parity during implementation.

Recommended request pattern:
- "Implement <workflow>. If required crates are missing, create/update them and continue until tests pass."

Supporting setup references:
- `docs/ai-coding-workflow.md`
- `.github/README.md`
- `.claude/README.md`
- Release-readiness scripts:
  - `scripts/release/release_readiness_check.sh`
  - `scripts/release/release_readiness_check.ps1`
- Dual-target CI scripts:
  - `scripts/ci/linux_release_check.sh`
  - `scripts/ci/windows_compat_check.ps1`

## Publishing crates

- Manual publish workflow: run `Publish Crate` with `package=<crate-name>`.
- Release publish: create a tag in `<package>-v<version>` format.

## License

Dual-licensed under:

- Apache License, Version 2.0 ([LICENSE](/LICENSE))
- MIT license ([LICENSE-MIT](/LICENSE-MIT))
