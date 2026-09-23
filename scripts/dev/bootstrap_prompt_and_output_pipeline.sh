#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

modules=(
  "ai-prompt-registry|Prompt registry and versioning"
  "ai-prompt-loader|Prompt loading from file, db, and remote sources"
  "ai-prompt-renderer|Deterministic prompt rendering engine"
  "ai-prompt-optimizer|Prompt optimization and budget shaping"
  "ai-prompt-ab-testing|Prompt A/B testing orchestration"
  "ai-prompt-localization|Prompt localization and locale strategies"
  "ai-output-parser-core|Unified output parser contracts"
  "ai-output-guard|Post-parse validation and guard pipeline"
  "ai-output-diff|Output comparison and regression diffing"
  "ai-json-parser-core|Robust JSON extraction and parsing"
  "ai-json-repair|Malformed JSON repair engine"
  "ai-tool-call-schema|Tool-call schema definitions"
  "ai-tool-call-parser|Tool-call payload parsing and coercion"
  "ai-agent-memory-window|Agent memory window and truncation policies"
  "ai-agent-transcript|Canonical transcript and replay format"
  "ai-agent-planner|Plan generation and step modeling"
  "ai-agent-executor|Plan execution runtime"
  "ai-agent-fallback|Agent fallback and retry orchestration"
  "ai-agent-simulation|Agent simulation and dry-run harness"
  "ai-parser-benchmark|Parser performance and correctness benchmark suite"
)

created=0
skipped=0

for item in "${modules[@]}"; do
  name="${item%%|*}"
  description="${item#*|}"
  crate_dir="$ROOT_DIR/crates/$name"

  if [[ -d "$crate_dir" ]]; then
    echo "Skipping existing crate: $name"
    skipped=$((skipped + 1))
    continue
  fi

  bash "$ROOT_DIR/scripts/dev/new_ai_crate.sh" "$name" "$description" --skip-tests
  created=$((created + 1))
done

echo "Bootstrap complete. Created: $created, Skipped: $skipped"
