#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "usage: scripts/dev/new_ai_crate.sh <kebab-case-name> [description] [--skip-tests]"
  exit 1
fi

NAME="$1"
DESCRIPTION="${2:-Rust AI backend crate}"
SKIP_TESTS="${3:-}"

if [[ ! "$NAME" =~ ^[a-z][a-z0-9-]*$ ]]; then
  echo "crate name must be kebab-case and start with a letter"
  exit 1
fi

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
CRATE_DIR="$ROOT_DIR/crates/$NAME"

if [[ -d "$CRATE_DIR" ]]; then
  echo "crate directory already exists: $CRATE_DIR"
  exit 1
fi

cd "$ROOT_DIR"
cargo new "crates/$NAME" --lib

cat > "$CRATE_DIR/Cargo.toml" <<EOF
[package]
name = "$NAME"
version = "0.1.0"
edition = "2024"
license = "MIT OR Apache-2.0"
description = "$DESCRIPTION"
repository = "https://github.com/VirendraChavda/rust"
readme = "README.md"
keywords = ["ai", "backend", "rust"]
categories = ["development-tools"]

[dependencies]
EOF

cat > "$CRATE_DIR/README.md" <<EOF
# $NAME

$DESCRIPTION

## Maturity

experimental

## Development

\`\`\`bash
cargo test -p $NAME
\`\`\`

## License

Dual-licensed under MIT OR Apache-2.0.
EOF

cat > "$CRATE_DIR/CHANGELOG.md" <<'EOF'
# Changelog

All notable changes to this crate will be documented in this file.

## [0.1.0] - TBD

- Initial scaffold.
EOF

mkdir -p "$CRATE_DIR/tests"

cat > "$CRATE_DIR/src/lib.rs" <<'EOF'
/// Returns a static crate health string.
pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn health_is_ok() {
        assert_eq!(health(), "ok");
    }
}
EOF

crate_mod_name="${NAME//-/_}"
cat > "$CRATE_DIR/tests/smoke.rs" <<EOF
use ${crate_mod_name}::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
EOF

if [[ "$SKIP_TESTS" != "--skip-tests" ]]; then
  cargo test -p "$NAME"
fi
echo "Created crate: $NAME"
