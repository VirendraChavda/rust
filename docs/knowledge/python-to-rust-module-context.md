# Python-to-Rust Module Context

This document captures domain context needed to mature Rust crates toward parity with widely used Python ecosystems.

## Purpose

- Translate Python module expectations into Rust crate design requirements.
- Provide capability targets, reliability constraints, and API principles.
- Standardize maturity milestones across module families.

## Parity maturity levels

- L0: concept only, no stable user API.
- L1: minimal vertical slice, typed core API, baseline tests.
- L2: production basics, async and error model hardened, docs and examples.
- L3: ecosystem-ready, stable API, integration adapters, performance profile.
- L4: ecosystem-leading, broad adoption, strong extension/community tooling.

## Module families and expected capabilities

### Agent orchestration family (LangChain, LangGraph)

Rust target crates:
- agent chain runtime
- graph scheduler runtime
- tool and memory abstraction

Core capabilities:
- Typed step and tool interfaces.
- Deterministic graph execution with resumable state.
- Timeout, retry, cancellation, and idempotency controls.
- Structured tracing and execution lineage.

Reliability checklist:
- deterministic replay tests
- failure injection tests for tool/network timeouts
- graph state transition invariants

### ML API family (scikit-learn)

Rust target crates:
- estimator trait ecosystem
- preprocessing and feature pipeline components
- model persistence/interchange adapters

Core capabilities:
- fit, predict, transform style traits.
- composable pipeline and cross-validation utilities.
- reproducibility controls and random seed discipline.

Reliability checklist:
- numerical stability tests
- dataset edge-case tests (sparse, nulls, skew)
- baseline benchmark against reference datasets

### Dataframe family (pandas)

Rust target crates:
- tabular core frame
- expression and query engine
- io adapters (csv, parquet, json)

Core capabilities:
- columnar schema and nullability semantics.
- groupby, join, aggregate, window basics.
- deterministic type coercion and error behavior.

Reliability checklist:
- schema evolution tests
- join correctness property tests
- memory profile for large datasets

### Model provider family (LiteLLM style)

Rust target crates:
- provider trait abstraction
- routing and fallback engine
- token/usage accounting

Core capabilities:
- unified request and response model across providers.
- model routing policy with retries/fallback.
- normalized errors and rate-limit handling.

Reliability checklist:
- provider contract conformance tests
- retry and backoff policy tests
- usage accounting consistency checks

### Deep learning runtime bindings (PyTorch, TensorFlow, Keras-like)

Rust target crates:
- backend abstraction traits
- tensor operation bridge
- training/inference orchestration wrappers

Core capabilities:
- backend-agnostic tensor interfaces.
- clear boundary between safe Rust API and unsafe ffi internals.
- reproducible inference wrappers and model loading.

Reliability checklist:
- ffi safety coverage
- tensor shape/type invariant checks
- deterministic inference fixtures

### Serving and protocol family (FastAPI, websockets)

Rust target crates:
- HTTP serving toolkit for AI APIs
- websocket event stream layer
- schema and validation adapters

Core capabilities:
- request validation and typed error responses.
- streaming response support.
- middleware for auth, tracing, quotas.

Reliability checklist:
- contract tests for endpoints and schemas
- backpressure and connection churn tests
- latency and throughput benchmark baselines

### Persistence and data access family (SQLAlchemy)

Rust target crates:
- typed query abstraction
- migration helpers
- repository/unit-of-work patterns

Core capabilities:
- compile-time query safety where possible.
- transaction boundary and isolation controls.
- pool and connection lifecycle visibility.

Reliability checklist:
- transaction rollback tests
- migration compatibility tests
- deadlock and retry policy tests

### Cloud SDK and integration family (boto3)

Rust target crates:
- cloud service adapters
- retry and auth middleware
- storage and queue primitives

Core capabilities:
- consistent auth and request-signing abstractions.
- idempotent wrappers for mutating operations.
- regional/failover configuration model.

Reliability checklist:
- local emulator integration tests
- retry/idempotency correctness tests
- permission error and throttling tests

## Cross-family constraints

- API stability and semver discipline.
- clear synchronous and asynchronous boundaries.
- observability first: traces, metrics, and structured events.
- deterministic tests, minimal flaky external dependencies.

## Recommended implementation sequence

1. Build small stable cores (traits and errors).
2. Add production primitives (timeouts, retries, cancellation, observability).
3. Add adapters and integrations under feature flags.
4. Expand benchmarks, fuzzing, and contract tests.
5. Promote maturity level after release-readiness checks pass.
