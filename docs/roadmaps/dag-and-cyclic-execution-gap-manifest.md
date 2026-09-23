# DAG and Cyclic Execution Gap Manifest

This manifest targets missing crates for robust agentic flow execution across DAG and cyclic graph pipelines.

## Graph model and compilation layer

- ai-graph-core
- ai-graph-schema
- ai-graph-ir
- ai-graph-validation
- ai-graph-typing
- ai-graph-versioning

## DAG planning and scheduling layer

- ai-dag-planner
- ai-dag-toposort
- ai-dag-partitioner
- ai-dag-critical-path
- ai-dag-resource-scheduler
- ai-dag-backfill

## Cyclic graph execution layer

- ai-cycle-detector
- ai-scc-analyzer
- ai-fixed-point-engine
- ai-iterative-convergence
- ai-superstep-runtime
- ai-feedback-edges

## Runtime orchestration control layer

- ai-graph-executor
- ai-graph-event-loop
- ai-graph-signal-bus
- ai-graph-cancellation
- ai-graph-timeouts
- ai-graph-retries

## Checkpoint and determinism layer

- ai-graph-determinism
- ai-graph-replay-trace
- ai-graph-snapshot-store
- ai-graph-checkpoint-index

## Streaming dataflow layer

- ai-stream-core
- ai-stream-watermarks
- ai-stream-windowing
- ai-stream-joins
- ai-stream-backpressure

## Debug and operations layer

- ai-graph-debugger
- ai-graph-profiler
- ai-graph-visualization
- ai-graph-inspector
- ai-graph-admin-api
- ai-graph-migrations

## Notes

- This manifest complements existing state machine and workflow crates.
- It focuses on graph execution mechanics rather than provider or API adapters.
- Crates are scaffold-first and intended for phased L1 to L4 implementation.
