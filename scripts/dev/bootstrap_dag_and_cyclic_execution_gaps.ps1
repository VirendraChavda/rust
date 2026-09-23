$ErrorActionPreference = "Stop"

$modules = @(
    @{ Name = "ai-graph-core"; Description = "Graph execution core contracts" },
    @{ Name = "ai-graph-schema"; Description = "Graph schema definitions" },
    @{ Name = "ai-graph-ir"; Description = "Graph intermediate representation" },
    @{ Name = "ai-graph-validation"; Description = "Graph validation rules and checks" },
    @{ Name = "ai-graph-typing"; Description = "Graph node and edge typing system" },
    @{ Name = "ai-graph-versioning"; Description = "Graph version compatibility contracts" },
    @{ Name = "ai-dag-planner"; Description = "DAG planning orchestration" },
    @{ Name = "ai-dag-toposort"; Description = "Topological sorting and ordering" },
    @{ Name = "ai-dag-partitioner"; Description = "DAG partitioning and sharding strategies" },
    @{ Name = "ai-dag-critical-path"; Description = "Critical path analysis" },
    @{ Name = "ai-dag-resource-scheduler"; Description = "Resource-aware DAG scheduling" },
    @{ Name = "ai-dag-backfill"; Description = "DAG backfill execution policies" },
    @{ Name = "ai-cycle-detector"; Description = "Cycle detection and diagnostics" },
    @{ Name = "ai-scc-analyzer"; Description = "Strongly connected components analysis" },
    @{ Name = "ai-fixed-point-engine"; Description = "Fixed-point iteration runtime" },
    @{ Name = "ai-iterative-convergence"; Description = "Convergence strategies for cyclic computation" },
    @{ Name = "ai-superstep-runtime"; Description = "Superstep-style graph execution runtime" },
    @{ Name = "ai-feedback-edges"; Description = "Feedback edge orchestration" },
    @{ Name = "ai-graph-executor"; Description = "Graph execution engine" },
    @{ Name = "ai-graph-event-loop"; Description = "Graph runtime event loop" },
    @{ Name = "ai-graph-signal-bus"; Description = "Signal and control event bus" },
    @{ Name = "ai-graph-cancellation"; Description = "Graph cancellation propagation" },
    @{ Name = "ai-graph-timeouts"; Description = "Graph timeout policies" },
    @{ Name = "ai-graph-retries"; Description = "Graph retry and retry budget policies" },
    @{ Name = "ai-graph-determinism"; Description = "Determinism checks and enforcement" },
    @{ Name = "ai-graph-replay-trace"; Description = "Replay trace format and replayer" },
    @{ Name = "ai-graph-snapshot-store"; Description = "Snapshot storage contracts" },
    @{ Name = "ai-graph-checkpoint-index"; Description = "Checkpoint indexing and lookup" },
    @{ Name = "ai-stream-core"; Description = "Streaming dataflow contracts" },
    @{ Name = "ai-stream-watermarks"; Description = "Watermark handling and progression" },
    @{ Name = "ai-stream-windowing"; Description = "Windowing semantics and operators" },
    @{ Name = "ai-stream-joins"; Description = "Stream join operators" },
    @{ Name = "ai-stream-backpressure"; Description = "Streaming backpressure control" },
    @{ Name = "ai-graph-debugger"; Description = "Graph runtime debugging tools" },
    @{ Name = "ai-graph-profiler"; Description = "Graph performance profiling" },
    @{ Name = "ai-graph-visualization"; Description = "Graph visualization outputs" },
    @{ Name = "ai-graph-inspector"; Description = "Graph state inspection APIs" },
    @{ Name = "ai-graph-admin-api"; Description = "Administrative control APIs for graph runtimes" },
    @{ Name = "ai-graph-migrations"; Description = "Graph schema and runtime migration support" }
)

$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$created = 0
$skipped = 0

foreach ($m in $modules) {
    $cratePath = Join-Path $root "crates\$($m.Name)"
    if (Test-Path $cratePath) {
        Write-Host "Skipping existing crate: $($m.Name)"
        $skipped += 1
        continue
    }

    & (Join-Path $root "scripts\dev\new_ai_crate.ps1") -Name $m.Name -Description $m.Description -SkipTests
    $created += 1
}

Write-Host "Bootstrap complete. Created: $created, Skipped: $skipped"
