# State Machine and Backend Gap Manifest

This manifest captures additional high-impact backend gaps after the essential parity bootstrap.

## State machine and durable orchestration internals

- ai-state-machine-core
- ai-state-machine-fsm
- ai-state-machine-event-sourcing
- ai-state-machine-saga
- ai-state-machine-compensation
- ai-state-machine-snapshots
- ai-state-machine-outbox
- ai-state-machine-inbox
- ai-state-machine-locks
- ai-state-machine-replay
- ai-state-machine-versioning
- ai-workflow-signals
- ai-workflow-human-loop
- ai-workflow-timeouts
- ai-workflow-activities

## Task queue worker runtime parity

- ai-queue-worker
- ai-queue-task-registry
- ai-queue-result-store
- ai-queue-dead-letter
- ai-queue-scheduler

## FastAPI-style serving ergonomics parity

- ai-serving-router
- ai-serving-di
- ai-serving-lifespan
- ai-serving-cors
- ai-serving-error-model
- ai-serving-multipart
- ai-serving-upload

## Websocket and realtime backend parity

- ai-websocket-pubsub
- ai-websocket-presence
- ai-websocket-session
- ai-websocket-broadcast
- ai-websocket-backpressure

## Retrieval and RAG operations parity

- ai-retrieval-hybrid
- ai-retrieval-query-rewrite
- ai-retrieval-router
- ai-rag-memory

## Backend reliability operations parity

- ai-config-core
- ai-config-runtime
- ai-feature-flags
- ai-tenancy-core
- ai-idempotency-core
- ai-request-signing
- ai-audit-log

## Notes

- These crates focus on internal reliability and backend ergonomics parity.
- They are intended as L1 scaffolds and should be implemented incrementally by family.
