#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

modules=(
  "ai-llm-azure-openai|Azure OpenAI provider adapter"
  "ai-llm-bedrock|AWS Bedrock provider adapter"
  "ai-llm-ollama|Ollama provider adapter"
  "ai-llm-cohere|Cohere provider adapter"
  "ai-llm-mistral|Mistral provider adapter"
  "ai-llm-groq|Groq provider adapter"
  "ai-llm-vertex|Vertex AI provider adapter"
  "ai-rag-core|RAG orchestration core"
  "ai-rag-pipeline|RAG pipeline composition"
  "ai-rag-citations|Citation-grounded output assembly"
  "ai-document-parsers|Document parser interfaces and adapters"
  "ai-document-ocr|OCR abstraction and adapters"
  "ai-document-pdf|PDF extraction and normalization"
  "ai-document-web-crawl|Web crawl ingestion adapters"
  "ai-indexing-core|Indexing contracts and orchestration"
  "ai-indexing-incremental|Incremental indexing strategies"
  "ai-vector-milvus|Milvus vector adapter"
  "ai-vector-pinecone|Pinecone vector adapter"
  "ai-vector-elasticsearch|Elasticsearch vector adapter"
  "ai-vector-opensearch|OpenSearch vector adapter"
  "ai-vector-chroma|Chroma vector adapter"
  "ai-serving-openapi|OpenAPI schema generation and docs"
  "ai-serving-validation|Request and response validation middleware"
  "ai-serving-auth|Serving-layer auth middleware"
  "ai-serving-rate-limit|Rate limiting and quota controls"
  "ai-serving-background-tasks|Background task integration for serving"
  "ai-serving-sse|Server-sent events transport"
  "ai-serving-grpc|gRPC transport and schemas"
  "ai-workflow-scheduler|Workflow scheduling primitives"
  "ai-workflow-cron|Cron-based workflow triggers"
  "ai-workflow-dag|DAG workflow execution"
  "ai-workflow-retries|Workflow retry and backoff policies"
  "ai-queue-core|Queue abstraction layer"
  "ai-queue-redis|Redis queue adapter"
  "ai-queue-rabbitmq|RabbitMQ queue adapter"
  "ai-queue-kafka|Kafka queue and stream adapter"
  "ai-queue-sqs|SQS queue adapter"
  "ai-store-redis|Redis persistence adapter"
  "ai-store-postgres|Postgres persistence adapter"
  "ai-store-mongodb|MongoDB persistence adapter"
  "ai-cache-core|Cache abstraction contracts"
  "ai-cache-redis|Redis cache adapter"
  "ai-migrations-core|Schema migration orchestration"
  "ai-observe-logging|Structured logging adapters"
  "ai-observe-opentelemetry|OpenTelemetry exporter integration"
  "ai-observe-prometheus|Prometheus metrics exporter"
  "ai-observe-alerting|Alerting and incident signal hooks"
  "ai-eval-datasets|Evaluation dataset management"
  "ai-eval-regression|Regression evaluation harness"
  "ai-schema-model|Schema model definitions and versions"
  "ai-schema-validation|Schema validation engine"
  "ai-auth-core|Authentication contracts and primitives"
  "ai-auth-jwt|JWT auth adapters"
  "ai-auth-oauth|OAuth auth adapters"
  "ai-policy-engine|Policy evaluation runtime"
  "ai-secrets-vault|Secrets vault integration"
  "ai-model-serving|Model serving control plane"
  "ai-model-monitoring|Model behavior and health monitoring"
  "ai-model-drift|Model and data drift detection"
  "ai-model-rollout|Canary and staged rollout orchestration"
  "ai-feature-store-core|Feature store contracts"
  "ai-dataset-versioning|Dataset version and lineage tracking"
  "ai-integration-slack|Slack integration adapters"
  "ai-integration-github|GitHub integration adapters"
  "ai-cloud-kubernetes|Kubernetes adapter primitives"
  "ai-cloud-helm|Helm deployment adapter"
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
