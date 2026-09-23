#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

modules=(
  "ai-agent-core|Shared agent traits and contracts"
  "ai-agent-chain|Chain execution primitives"
  "ai-agent-graph|Durable graph runtime and scheduler"
  "ai-agent-memory|Agent memory abstractions"
  "ai-agent-tools|Tool interfaces and adapters"
  "ai-agent-checkpoint|Checkpoint and resume primitives"
  "ai-llm-core|Provider-agnostic LLM interfaces"
  "ai-llm-openai|OpenAI adapter"
  "ai-llm-anthropic|Anthropic adapter"
  "ai-llm-gemini|Gemini adapter"
  "ai-llm-router|Provider routing and fallback"
  "ai-prompt-template|Prompt templating and schema rendering"
  "ai-embed-core|Embedding abstraction layer"
  "ai-ingest-core|Document ingestion and normalization"
  "ai-chunking|Chunking and segmentation algorithms"
  "ai-retrieval-core|Retrieval and ranking contracts"
  "ai-rerank-core|Reranking interfaces and adapters"
  "ai-vector-core|Vector store abstraction"
  "ai-vector-qdrant|Qdrant adapter"
  "ai-vector-pgvector|Pgvector adapter"
  "ai-vector-weaviate|Weaviate adapter"
  "ai-dataframe-core|Tabular data model and expression engine"
  "ai-dataframe-io|Dataframe IO adapters"
  "ai-feature-pipeline|Feature pipeline runtime"
  "ai-ml-estimator|Estimator traits and contracts"
  "ai-ml-metrics|Model evaluation metrics"
  "ai-serving-http|HTTP serving toolkit for AI APIs"
  "ai-serving-websocket|Websocket streaming transport"
  "ai-serving-gateway|Gateway middleware and policy layer"
  "ai-serving-batch|Batch inference and queue execution"
  "ai-store-core|Persistence abstractions"
  "ai-store-sql|SQL persistence adapters"
  "ai-store-vector-meta|Vector metadata persistence"
  "ai-workflow-jobs|Async jobs orchestration"
  "ai-workflow-state|Durable workflow state"
  "ai-observe-tracing|Structured tracing"
  "ai-observe-metrics|Runtime and token metrics"
  "ai-observe-evals|Evaluation harness"
  "ai-guardrails-core|Safety and policy validation contracts"
  "ai-guardrails-pii|PII detection and redaction"
  "ai-schema-output|Structured output schema handling"
  "ai-cloud-core|Cloud integration abstractions"
  "ai-cloud-aws|AWS adapters"
  "ai-cloud-gcp|GCP adapters"
  "ai-cloud-azure|Azure adapters"
  "ai-secrets-core|Secrets and key management abstraction"
  "ai-model-registry|Model metadata and version management"
  "ai-model-artifacts|Artifact lineage and storage"
  "ai-experiment-tracking|Experiment run tracking"
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
