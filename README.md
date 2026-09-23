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

## Publishing crates

- Manual publish workflow: run `Publish Crate` with `package=<crate-name>`.
- Release publish: create a tag in `<package>-v<version>` format.

## License

Dual-licensed under:

- Apache License, Version 2.0 ([LICENSE](/LICENSE))
- MIT license ([LICENSE-MIT](/LICENSE-MIT))
