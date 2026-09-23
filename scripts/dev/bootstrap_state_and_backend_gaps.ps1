$ErrorActionPreference = "Stop"

$modules = @(
    @{ Name = "ai-state-machine-core"; Description = "State machine core contracts" },
    @{ Name = "ai-state-machine-fsm"; Description = "Finite state machine primitives" },
    @{ Name = "ai-state-machine-event-sourcing"; Description = "Event-sourcing support for workflows" },
    @{ Name = "ai-state-machine-saga"; Description = "Saga orchestration semantics" },
    @{ Name = "ai-state-machine-compensation"; Description = "Compensation handlers and rollback contracts" },
    @{ Name = "ai-state-machine-snapshots"; Description = "State snapshotting contracts" },
    @{ Name = "ai-state-machine-outbox"; Description = "Transactional outbox patterns" },
    @{ Name = "ai-state-machine-inbox"; Description = "Inbox idempotency and dedupe patterns" },
    @{ Name = "ai-state-machine-locks"; Description = "Leases and distributed lock abstractions" },
    @{ Name = "ai-state-machine-replay"; Description = "Deterministic replay engine" },
    @{ Name = "ai-state-machine-versioning"; Description = "Workflow and state schema versioning" },
    @{ Name = "ai-workflow-signals"; Description = "Workflow signal and event ingress" },
    @{ Name = "ai-workflow-human-loop"; Description = "Human-in-the-loop workflow controls" },
    @{ Name = "ai-workflow-timeouts"; Description = "Workflow timeout and deadline policies" },
    @{ Name = "ai-workflow-activities"; Description = "Activity execution contracts" },
    @{ Name = "ai-queue-worker"; Description = "Queue worker runtime" },
    @{ Name = "ai-queue-task-registry"; Description = "Task registration and dispatch" },
    @{ Name = "ai-queue-result-store"; Description = "Task result storage contracts" },
    @{ Name = "ai-queue-dead-letter"; Description = "Dead-letter queue handling" },
    @{ Name = "ai-queue-scheduler"; Description = "Scheduled task orchestration" },
    @{ Name = "ai-serving-router"; Description = "Routing and endpoint composition layer" },
    @{ Name = "ai-serving-di"; Description = "Dependency injection patterns for serving" },
    @{ Name = "ai-serving-lifespan"; Description = "Application lifespan hooks and lifecycle" },
    @{ Name = "ai-serving-cors"; Description = "CORS middleware and policy controls" },
    @{ Name = "ai-serving-error-model"; Description = "Typed API error model and handlers" },
    @{ Name = "ai-serving-multipart"; Description = "Multipart parsing and validation" },
    @{ Name = "ai-serving-upload"; Description = "File upload orchestration" },
    @{ Name = "ai-websocket-pubsub"; Description = "Websocket pubsub abstraction" },
    @{ Name = "ai-websocket-presence"; Description = "Presence tracking for websocket sessions" },
    @{ Name = "ai-websocket-session"; Description = "Websocket session management" },
    @{ Name = "ai-websocket-broadcast"; Description = "Broadcast fanout primitives" },
    @{ Name = "ai-websocket-backpressure"; Description = "Backpressure and flow control" },
    @{ Name = "ai-retrieval-hybrid"; Description = "Hybrid retrieval strategies" },
    @{ Name = "ai-retrieval-query-rewrite"; Description = "Query rewrite and expansion" },
    @{ Name = "ai-retrieval-router"; Description = "Retrieval strategy routing" },
    @{ Name = "ai-rag-memory"; Description = "RAG memory context management" },
    @{ Name = "ai-config-core"; Description = "Configuration contracts" },
    @{ Name = "ai-config-runtime"; Description = "Runtime config loading and refresh" },
    @{ Name = "ai-feature-flags"; Description = "Feature flag evaluation and rollout" },
    @{ Name = "ai-tenancy-core"; Description = "Multi-tenant boundaries and contracts" },
    @{ Name = "ai-idempotency-core"; Description = "Idempotency key and replay guards" },
    @{ Name = "ai-request-signing"; Description = "Request signature validation" },
    @{ Name = "ai-audit-log"; Description = "Audit log contracts and emitters" }
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
