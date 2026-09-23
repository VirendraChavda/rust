# Module Parity Matrix

Tracks Rust maturity against major Python module families.

## Status table

| Family | Python reference | Rust target area | Current level | Next milestone |
|---|---|---|---|---|
| Agent orchestration | LangChain, LangGraph | chain and graph runtime | L1 | deterministic graph state + replay |
| ML API | scikit-learn | estimator and pipeline traits | L0 | fit/predict/transform core traits |
| Dataframe | pandas | frame and query engine | L0 | schema, select, filter, join basics |
| Provider routing | LiteLLM | provider abstraction and fallback | L0 | unified request model + retries |
| DL bindings | PyTorch, TensorFlow, Keras | tensor/backend bridge | L0 | safe API over minimal ffi surfaces |
| Serving | FastAPI, websocket | HTTP and stream serving primitives | L0 | typed API contracts + streaming |
| Persistence | SQLAlchemy | typed persistence and migration helpers | L0 | repository + transaction primitives |
| Cloud sdk | boto3 | cloud adapters and middleware | L0 | storage and queue primitives |

## Exit criteria by level

### L1
- crate scaffold, typed errors, baseline tests

### L2
- core behaviors complete, docs/examples, reliability primitives

### L3
- stable API, integration adapters, benchmark baseline

### L4
- broad ecosystem interoperability and mature extension points

## Update process

- Update this matrix whenever a crate reaches a maturity milestone.
- Link milestone evidence in release notes and ADR/RFC records.
