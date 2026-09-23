#!/usr/bin/env bash
set -euo pipefail

if ! command -v cargo >/dev/null 2>&1; then
  echo "cargo is not available in PATH. Install Rustup and ensure cargo is on PATH."
  exit 1
fi

if [[ "${OSTYPE:-}" == msys* || "${OSTYPE:-}" == cygwin* || "${OS:-}" == Windows_NT ]]; then
  if ! command -v link.exe >/dev/null 2>&1; then
    echo "link.exe is not available. Install Visual Studio Build Tools with C++ toolchain and use a Developer shell."
    exit 1
  fi
fi

echo "Preflight checks passed."
