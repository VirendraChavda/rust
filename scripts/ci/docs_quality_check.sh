#!/usr/bin/env bash
set -euo pipefail

echo "Building workspace docs with warnings denied"
RUSTDOCFLAGS="-D warnings" cargo doc --workspace --no-deps

echo "Docs quality checks passed."
