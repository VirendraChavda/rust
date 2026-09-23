#!/usr/bin/env bash
set -euo pipefail

echo "[0/4] preflight environment checks"
bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/preflight_check.sh"

echo "[1/4] cargo fmt --all -- --check"
cargo fmt --all -- --check

echo "[2/4] cargo clippy --workspace --all-targets --all-features -- -D warnings"
cargo clippy --workspace --all-targets --all-features -- -D warnings

echo "[3/4] cargo test --workspace"
cargo test --workspace

echo "All checks passed."
