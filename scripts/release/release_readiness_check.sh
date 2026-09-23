#!/usr/bin/env bash
set -euo pipefail

PACKAGE="${1:-}"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "$ROOT_DIR"

shopt -s nullglob
MANIFESTS=(crates/*/Cargo.toml)
if [[ ${#MANIFESTS[@]} -eq 0 ]]; then
  echo "No crate manifests found under crates/."
  exit 1
fi

FAILED=0

for manifest in "${MANIFESTS[@]}"; do
  crate_dir="$(dirname "$manifest")"
  crate_name="$(basename "$crate_dir")"

  if [[ -n "$PACKAGE" && "$crate_name" != "$PACKAGE" ]]; then
    continue
  fi

  echo "Checking release readiness for $crate_name"

  if ! grep -Eq '^version\s*=\s*"[^"]+"' "$manifest"; then
    echo "[$crate_name] Missing version in Cargo.toml"
    FAILED=1
  fi

  if ! grep -Eq '^license\s*=' "$manifest" && ! grep -Eq '^license-file\s*=' "$manifest"; then
    echo "[$crate_name] Missing license or license-file in Cargo.toml"
    FAILED=1
  fi

  if [[ ! -f "$crate_dir/README.md" ]]; then
    echo "[$crate_name] Missing README.md"
    FAILED=1
  fi

  if [[ ! -f "$crate_dir/CHANGELOG.md" ]]; then
    echo "[$crate_name] Missing CHANGELOG.md"
    FAILED=1
  fi
done

if [[ $FAILED -ne 0 ]]; then
  echo "Release readiness checks failed."
  exit 1
fi

echo "Release readiness checks passed."
