#!/usr/bin/env bash
set -euo pipefail

echo "[1/3] cargo fmt --all -- --check"
cargo fmt --all -- --check

echo "[2/3] cargo clippy --workspace --all-targets --all-features -- -D warnings"
cargo clippy --workspace --all-targets --all-features -- -D warnings

echo "[3/3] cargo test --workspace"
cargo test --workspace

echo "All checks passed."
