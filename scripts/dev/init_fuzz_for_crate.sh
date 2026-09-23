#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: scripts/dev/init_fuzz_for_crate.sh <crate-name>"
  exit 1
fi

CRATE_NAME="$1"
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CRATE_DIR="$ROOT_DIR/crates/$CRATE_NAME"

if [[ ! -d "$CRATE_DIR" ]]; then
  echo "crate not found: $CRATE_NAME"
  exit 1
fi

if ! command -v cargo-fuzz >/dev/null 2>&1; then
  echo "cargo-fuzz not found, installing..."
  cargo install cargo-fuzz --locked
fi

pushd "$CRATE_DIR" >/dev/null
if [[ ! -d "fuzz" ]]; then
  cargo fuzz init
fi

TARGET_FILE="fuzz/fuzz_targets/fuzz_target_1.rs"
if [[ -f "$TARGET_FILE" ]]; then
  echo "fuzz target already exists: $TARGET_FILE"
else
  mkdir -p "fuzz/fuzz_targets"
  cat > "$TARGET_FILE" <<'EOF'
#![no_main]
use libfuzzer_sys::fuzz_target;

fuzz_target!(|data: &[u8]| {
    let _ = data;
});
EOF
fi
popd >/dev/null

echo "Fuzz scaffold ready for crate: $CRATE_NAME"
