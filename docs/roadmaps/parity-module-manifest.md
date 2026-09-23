# Parity Module Manifest

This manifest enumerates target Rust crates needed to approach Python AI backend ecosystem maturity.

## Agent and orchestration

- ai-agent-core: shared traits and request/response contracts
- ai-agent-chain: chain execution primitives
- ai-agent-graph: durable graph runtime and scheduler
- ai-agent-memory: short and long-term memory abstractions
- ai-agent-tools: tool contracts and adapters
- ai-agent-checkpoint: state checkpoint and resume primitives

## LLM providers and prompting

- ai-llm-core: provider-agnostic model interfaces
- ai-llm-openai: OpenAI provider adapter
- ai-llm-anthropic: Anthropic provider adapter
- ai-llm-gemini: Gemini provider adapter
- ai-llm-router: routing, fallback, and policy engine
- ai-prompt-template: prompt templates, renderers, and variable schemas

## RAG and retrieval

- ai-embed-core: embedding interfaces and model wrappers
- ai-ingest-core: document ingestion and normalization
- ai-chunking: chunking and segmentation algorithms
- ai-retrieval-core: retrieval APIs and ranking contracts
- ai-rerank-core: reranking abstraction and adapters
- ai-vector-core: vector store abstraction layer
- ai-vector-qdrant: qdrant adapter
- ai-vector-pgvector: pgvector adapter
- ai-vector-weaviate: weaviate adapter

## Data and ml

- ai-dataframe-core: tabular data model and expression engine
- ai-dataframe-io: csv, parquet, json io adapters
- ai-feature-pipeline: feature transform and pipeline runtime
- ai-ml-estimator: fit and predict style estimator traits
- ai-ml-metrics: evaluation metrics and scoring toolkit

## Serving and runtime

- ai-serving-http: ai-oriented http serving toolkit
- ai-serving-websocket: websocket and stream transport
- ai-serving-gateway: auth, quota, routing, and middleware layer
- ai-serving-batch: batch inference and queue-driven execution

## Persistence and workflows

- ai-store-core: persistence and repository abstractions
- ai-store-sql: sql persistence adapters and transaction helpers
- ai-store-vector-meta: metadata and retrieval indexing persistence
- ai-workflow-jobs: async jobs and pipeline orchestration
- ai-workflow-state: durable workflow state and transitions

## Observability and safety

- ai-observe-tracing: structured tracing for ai runtime events
- ai-observe-metrics: runtime metrics and token accounting
- ai-observe-evals: offline and online evaluation harness
- ai-guardrails-core: policy checks and validation contracts
- ai-guardrails-pii: pii detection and redaction utilities
- ai-schema-output: schema-first structured output handling

## Cloud and integration

- ai-cloud-core: cloud integration abstractions
- ai-cloud-aws: aws service adapters and primitives
- ai-cloud-gcp: gcp service adapters and primitives
- ai-cloud-azure: azure service adapters and primitives
- ai-secrets-core: secrets and key management abstraction

## Model lifecycle

- ai-model-registry: model metadata, versions, and promotion
- ai-model-artifacts: model artifact storage and lineage
- ai-experiment-tracking: experiment runs and parameter tracking
