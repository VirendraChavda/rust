#!/usr/bin/env bash
set -euo pipefail

if ! command -v cargo-semver-checks >/dev/null 2>&1; then
  echo "cargo-semver-checks is required. Install with: cargo install cargo-semver-checks --locked"
  exit 1
fi

echo "Running API stability checks for published crates"

FAILED=0
for manifest in crates/*/Cargo.toml; do
  crate_dir="$(dirname "$manifest")"
  crate_name="$(basename "$crate_dir")"

  crate_status=$(curl -s -o /dev/null -w "%{http_code}" "https://crates.io/api/v1/crates/${crate_name}")
  if [[ "$crate_status" != "200" ]]; then
    echo "[${crate_name}] not published on crates.io, skipping semver check"
    continue
  fi

  echo "[${crate_name}] running cargo semver-checks"
  if ! cargo semver-checks check-release --package "$crate_name"; then
    echo "[${crate_name}] semver check failed"
    FAILED=1
  fi
done

if [[ $FAILED -ne 0 ]]; then
  echo "API stability checks failed."
  exit 1
fi

echo "API stability checks passed."
