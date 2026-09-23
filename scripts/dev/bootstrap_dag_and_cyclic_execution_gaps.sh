#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

modules=(
  "ai-graph-core|Graph execution core contracts"
  "ai-graph-schema|Graph schema definitions"
  "ai-graph-ir|Graph intermediate representation"
  "ai-graph-validation|Graph validation rules and checks"
  "ai-graph-typing|Graph node and edge typing system"
  "ai-graph-versioning|Graph version compatibility contracts"
  "ai-dag-planner|DAG planning orchestration"
  "ai-dag-toposort|Topological sorting and ordering"
  "ai-dag-partitioner|DAG partitioning and sharding strategies"
  "ai-dag-critical-path|Critical path analysis"
  "ai-dag-resource-scheduler|Resource-aware DAG scheduling"
  "ai-dag-backfill|DAG backfill execution policies"
  "ai-cycle-detector|Cycle detection and diagnostics"
  "ai-scc-analyzer|Strongly connected components analysis"
  "ai-fixed-point-engine|Fixed-point iteration runtime"
  "ai-iterative-convergence|Convergence strategies for cyclic computation"
  "ai-superstep-runtime|Superstep-style graph execution runtime"
  "ai-feedback-edges|Feedback edge orchestration"
  "ai-graph-executor|Graph execution engine"
  "ai-graph-event-loop|Graph runtime event loop"
  "ai-graph-signal-bus|Signal and control event bus"
  "ai-graph-cancellation|Graph cancellation propagation"
  "ai-graph-timeouts|Graph timeout policies"
  "ai-graph-retries|Graph retry and retry budget policies"
  "ai-graph-determinism|Determinism checks and enforcement"
  "ai-graph-replay-trace|Replay trace format and replayer"
  "ai-graph-snapshot-store|Snapshot storage contracts"
  "ai-graph-checkpoint-index|Checkpoint indexing and lookup"
  "ai-stream-core|Streaming dataflow contracts"
  "ai-stream-watermarks|Watermark handling and progression"
  "ai-stream-windowing|Windowing semantics and operators"
  "ai-stream-joins|Stream join operators"
  "ai-stream-backpressure|Streaming backpressure control"
  "ai-graph-debugger|Graph runtime debugging tools"
  "ai-graph-profiler|Graph performance profiling"
  "ai-graph-visualization|Graph visualization outputs"
  "ai-graph-inspector|Graph state inspection APIs"
  "ai-graph-admin-api|Administrative control APIs for graph runtimes"
  "ai-graph-migrations|Graph schema and runtime migration support"
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
