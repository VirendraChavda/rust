#!/usr/bin/env bash
set -euo pipefail

if ! command -v cargo-fuzz >/dev/null 2>&1; then
  echo "cargo-fuzz is required. Install with: cargo install cargo-fuzz --locked"
  exit 1
fi

FOUND=0
for manifest in crates/*/fuzz/Cargo.toml; do
  crate_dir="$(dirname "$(dirname "$manifest")")"
  crate_name="$(basename "$crate_dir")"
  echo "Building fuzz targets for $crate_name"
  FOUND=1
  (
    cd "$crate_dir"
    cargo fuzz build
  )
done

if [[ $FOUND -eq 0 ]]; then
  echo "No fuzz targets found under crates/*/fuzz, skipping."
fi

echo "Fuzz build checks completed."
