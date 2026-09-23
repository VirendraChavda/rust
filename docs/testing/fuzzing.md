# Fuzzing Guide

This workspace supports crate-level fuzzing with cargo-fuzz.

## Initialize fuzzing for a crate

- Bash:

```bash
bash scripts/dev/init_fuzz_for_crate.sh <crate-name>
```

- PowerShell:

```powershell
./scripts/dev/init_fuzz_for_crate.ps1 -Crate <crate-name>
```

This creates a `fuzz/` directory in the crate if missing and adds a baseline fuzz target.

## Run fuzz target locally

From inside the crate directory:

```bash
cargo fuzz run fuzz_target_1
```

## CI behavior

CI workflow [`.github/workflows/fuzz.yml`](../../.github/workflows/fuzz.yml) installs cargo-fuzz and builds all fuzz targets under `crates/*/fuzz`.

If no fuzz targets exist yet, the check passes with a skip message.

## Recommendation

- Add at least one fuzz target for all parser, protocol, serializer, and state-transition crates.
- Prefer deterministic core logic to maximize fuzz signal quality.
