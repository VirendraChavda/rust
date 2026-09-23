#!/usr/bin/env bash
set -euo pipefail

echo "[1/3] cargo test --workspace"
cargo test --workspace

echo "[2/3] cargo test --workspace --release"
cargo test --workspace --release

echo "[3/3] benchmark compile check (if benches exist)"
if find crates -type f -path '*/benches/*' | grep -q .; then
  cargo bench --workspace --no-run
else
  echo "No benches found, skipping bench compile check."
fi

echo "Reliability checks passed."
