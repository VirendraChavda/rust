#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

modules=(
  "ai-state-machine-core|State machine core contracts"
  "ai-state-machine-fsm|Finite state machine primitives"
  "ai-state-machine-event-sourcing|Event-sourcing support for workflows"
  "ai-state-machine-saga|Saga orchestration semantics"
  "ai-state-machine-compensation|Compensation handlers and rollback contracts"
  "ai-state-machine-snapshots|State snapshotting contracts"
  "ai-state-machine-outbox|Transactional outbox patterns"
  "ai-state-machine-inbox|Inbox idempotency and dedupe patterns"
  "ai-state-machine-locks|Leases and distributed lock abstractions"
  "ai-state-machine-replay|Deterministic replay engine"
  "ai-state-machine-versioning|Workflow and state schema versioning"
  "ai-workflow-signals|Workflow signal and event ingress"
  "ai-workflow-human-loop|Human-in-the-loop workflow controls"
  "ai-workflow-timeouts|Workflow timeout and deadline policies"
  "ai-workflow-activities|Activity execution contracts"
  "ai-queue-worker|Queue worker runtime"
  "ai-queue-task-registry|Task registration and dispatch"
  "ai-queue-result-store|Task result storage contracts"
  "ai-queue-dead-letter|Dead-letter queue handling"
  "ai-queue-scheduler|Scheduled task orchestration"
  "ai-serving-router|Routing and endpoint composition layer"
  "ai-serving-di|Dependency injection patterns for serving"
  "ai-serving-lifespan|Application lifespan hooks and lifecycle"
  "ai-serving-cors|CORS middleware and policy controls"
  "ai-serving-error-model|Typed API error model and handlers"
  "ai-serving-multipart|Multipart parsing and validation"
  "ai-serving-upload|File upload orchestration"
  "ai-websocket-pubsub|Websocket pubsub abstraction"
  "ai-websocket-presence|Presence tracking for websocket sessions"
  "ai-websocket-session|Websocket session management"
  "ai-websocket-broadcast|Broadcast fanout primitives"
  "ai-websocket-backpressure|Backpressure and flow control"
  "ai-retrieval-hybrid|Hybrid retrieval strategies"
  "ai-retrieval-query-rewrite|Query rewrite and expansion"
  "ai-retrieval-router|Retrieval strategy routing"
  "ai-rag-memory|RAG memory context management"
  "ai-config-core|Configuration contracts"
  "ai-config-runtime|Runtime config loading and refresh"
  "ai-feature-flags|Feature flag evaluation and rollout"
  "ai-tenancy-core|Multi-tenant boundaries and contracts"
  "ai-idempotency-core|Idempotency key and replay guards"
  "ai-request-signing|Request signature validation"
  "ai-audit-log|Audit log contracts and emitters"
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
