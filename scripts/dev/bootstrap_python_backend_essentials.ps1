$ErrorActionPreference = "Stop"

$modules = @(
    @{ Name = "ai-llm-azure-openai"; Description = "Azure OpenAI provider adapter" },
    @{ Name = "ai-llm-bedrock"; Description = "AWS Bedrock provider adapter" },
    @{ Name = "ai-llm-ollama"; Description = "Ollama provider adapter" },
    @{ Name = "ai-llm-cohere"; Description = "Cohere provider adapter" },
    @{ Name = "ai-llm-mistral"; Description = "Mistral provider adapter" },
    @{ Name = "ai-llm-groq"; Description = "Groq provider adapter" },
    @{ Name = "ai-llm-vertex"; Description = "Vertex AI provider adapter" },
    @{ Name = "ai-rag-core"; Description = "RAG orchestration core" },
    @{ Name = "ai-rag-pipeline"; Description = "RAG pipeline composition" },
    @{ Name = "ai-rag-citations"; Description = "Citation-grounded output assembly" },
    @{ Name = "ai-document-parsers"; Description = "Document parser interfaces and adapters" },
    @{ Name = "ai-document-ocr"; Description = "OCR abstraction and adapters" },
    @{ Name = "ai-document-pdf"; Description = "PDF extraction and normalization" },
    @{ Name = "ai-document-web-crawl"; Description = "Web crawl ingestion adapters" },
    @{ Name = "ai-indexing-core"; Description = "Indexing contracts and orchestration" },
    @{ Name = "ai-indexing-incremental"; Description = "Incremental indexing strategies" },
    @{ Name = "ai-vector-milvus"; Description = "Milvus vector adapter" },
    @{ Name = "ai-vector-pinecone"; Description = "Pinecone vector adapter" },
    @{ Name = "ai-vector-elasticsearch"; Description = "Elasticsearch vector adapter" },
    @{ Name = "ai-vector-opensearch"; Description = "OpenSearch vector adapter" },
    @{ Name = "ai-vector-chroma"; Description = "Chroma vector adapter" },
    @{ Name = "ai-serving-openapi"; Description = "OpenAPI schema generation and docs" },
    @{ Name = "ai-serving-validation"; Description = "Request and response validation middleware" },
    @{ Name = "ai-serving-auth"; Description = "Serving-layer auth middleware" },
    @{ Name = "ai-serving-rate-limit"; Description = "Rate limiting and quota controls" },
    @{ Name = "ai-serving-background-tasks"; Description = "Background task integration for serving" },
    @{ Name = "ai-serving-sse"; Description = "Server-sent events transport" },
    @{ Name = "ai-serving-grpc"; Description = "gRPC transport and schemas" },
    @{ Name = "ai-workflow-scheduler"; Description = "Workflow scheduling primitives" },
    @{ Name = "ai-workflow-cron"; Description = "Cron-based workflow triggers" },
    @{ Name = "ai-workflow-dag"; Description = "DAG workflow execution" },
    @{ Name = "ai-workflow-retries"; Description = "Workflow retry and backoff policies" },
    @{ Name = "ai-queue-core"; Description = "Queue abstraction layer" },
    @{ Name = "ai-queue-redis"; Description = "Redis queue adapter" },
    @{ Name = "ai-queue-rabbitmq"; Description = "RabbitMQ queue adapter" },
    @{ Name = "ai-queue-kafka"; Description = "Kafka queue and stream adapter" },
    @{ Name = "ai-queue-sqs"; Description = "SQS queue adapter" },
    @{ Name = "ai-store-redis"; Description = "Redis persistence adapter" },
    @{ Name = "ai-store-postgres"; Description = "Postgres persistence adapter" },
    @{ Name = "ai-store-mongodb"; Description = "MongoDB persistence adapter" },
    @{ Name = "ai-cache-core"; Description = "Cache abstraction contracts" },
    @{ Name = "ai-cache-redis"; Description = "Redis cache adapter" },
    @{ Name = "ai-migrations-core"; Description = "Schema migration orchestration" },
    @{ Name = "ai-observe-logging"; Description = "Structured logging adapters" },
    @{ Name = "ai-observe-opentelemetry"; Description = "OpenTelemetry exporter integration" },
    @{ Name = "ai-observe-prometheus"; Description = "Prometheus metrics exporter" },
    @{ Name = "ai-observe-alerting"; Description = "Alerting and incident signal hooks" },
    @{ Name = "ai-eval-datasets"; Description = "Evaluation dataset management" },
    @{ Name = "ai-eval-regression"; Description = "Regression evaluation harness" },
    @{ Name = "ai-schema-model"; Description = "Schema model definitions and versions" },
    @{ Name = "ai-schema-validation"; Description = "Schema validation engine" },
    @{ Name = "ai-auth-core"; Description = "Authentication contracts and primitives" },
    @{ Name = "ai-auth-jwt"; Description = "JWT auth adapters" },
    @{ Name = "ai-auth-oauth"; Description = "OAuth auth adapters" },
    @{ Name = "ai-policy-engine"; Description = "Policy evaluation runtime" },
    @{ Name = "ai-secrets-vault"; Description = "Secrets vault integration" },
    @{ Name = "ai-model-serving"; Description = "Model serving control plane" },
    @{ Name = "ai-model-monitoring"; Description = "Model behavior and health monitoring" },
    @{ Name = "ai-model-drift"; Description = "Model and data drift detection" },
    @{ Name = "ai-model-rollout"; Description = "Canary and staged rollout orchestration" },
    @{ Name = "ai-feature-store-core"; Description = "Feature store contracts" },
    @{ Name = "ai-dataset-versioning"; Description = "Dataset version and lineage tracking" },
    @{ Name = "ai-integration-slack"; Description = "Slack integration adapters" },
    @{ Name = "ai-integration-github"; Description = "GitHub integration adapters" },
    @{ Name = "ai-cloud-kubernetes"; Description = "Kubernetes adapter primitives" },
    @{ Name = "ai-cloud-helm"; Description = "Helm deployment adapter" }
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
