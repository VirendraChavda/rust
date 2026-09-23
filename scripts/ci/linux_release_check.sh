#!/usr/bin/env bash
set -euo pipefail

echo "[1/2] full Linux quality checks"
bash "$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/full_check.sh"

echo "[2/2] release readiness checks"
bash "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/release/release_readiness_check.sh"

echo "Linux release-path checks passed."
