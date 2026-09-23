$ErrorActionPreference = "Stop"

$modules = @(
    @{ Name = "ai-agent-core"; Description = "Shared agent traits and contracts" },
    @{ Name = "ai-agent-chain"; Description = "Chain execution primitives" },
    @{ Name = "ai-agent-graph"; Description = "Durable graph runtime and scheduler" },
    @{ Name = "ai-agent-memory"; Description = "Agent memory abstractions" },
    @{ Name = "ai-agent-tools"; Description = "Tool interfaces and adapters" },
    @{ Name = "ai-agent-checkpoint"; Description = "Checkpoint and resume primitives" },
    @{ Name = "ai-llm-core"; Description = "Provider-agnostic LLM interfaces" },
    @{ Name = "ai-llm-openai"; Description = "OpenAI adapter" },
    @{ Name = "ai-llm-anthropic"; Description = "Anthropic adapter" },
    @{ Name = "ai-llm-gemini"; Description = "Gemini adapter" },
    @{ Name = "ai-llm-router"; Description = "Provider routing and fallback" },
    @{ Name = "ai-prompt-template"; Description = "Prompt templating and schema rendering" },
    @{ Name = "ai-embed-core"; Description = "Embedding abstraction layer" },
    @{ Name = "ai-ingest-core"; Description = "Document ingestion and normalization" },
    @{ Name = "ai-chunking"; Description = "Chunking and segmentation algorithms" },
    @{ Name = "ai-retrieval-core"; Description = "Retrieval and ranking contracts" },
    @{ Name = "ai-rerank-core"; Description = "Reranking interfaces and adapters" },
    @{ Name = "ai-vector-core"; Description = "Vector store abstraction" },
    @{ Name = "ai-vector-qdrant"; Description = "Qdrant adapter" },
    @{ Name = "ai-vector-pgvector"; Description = "Pgvector adapter" },
    @{ Name = "ai-vector-weaviate"; Description = "Weaviate adapter" },
    @{ Name = "ai-dataframe-core"; Description = "Tabular data model and expression engine" },
    @{ Name = "ai-dataframe-io"; Description = "Dataframe IO adapters" },
    @{ Name = "ai-feature-pipeline"; Description = "Feature pipeline runtime" },
    @{ Name = "ai-ml-estimator"; Description = "Estimator traits and contracts" },
    @{ Name = "ai-ml-metrics"; Description = "Model evaluation metrics" },
    @{ Name = "ai-serving-http"; Description = "HTTP serving toolkit for AI APIs" },
    @{ Name = "ai-serving-websocket"; Description = "Websocket streaming transport" },
    @{ Name = "ai-serving-gateway"; Description = "Gateway middleware and policy layer" },
    @{ Name = "ai-serving-batch"; Description = "Batch inference and queue execution" },
    @{ Name = "ai-store-core"; Description = "Persistence abstractions" },
    @{ Name = "ai-store-sql"; Description = "SQL persistence adapters" },
    @{ Name = "ai-store-vector-meta"; Description = "Vector metadata persistence" },
    @{ Name = "ai-workflow-jobs"; Description = "Async jobs orchestration" },
    @{ Name = "ai-workflow-state"; Description = "Durable workflow state" },
    @{ Name = "ai-observe-tracing"; Description = "Structured tracing" },
    @{ Name = "ai-observe-metrics"; Description = "Runtime and token metrics" },
    @{ Name = "ai-observe-evals"; Description = "Evaluation harness" },
    @{ Name = "ai-guardrails-core"; Description = "Safety and policy validation contracts" },
    @{ Name = "ai-guardrails-pii"; Description = "PII detection and redaction" },
    @{ Name = "ai-schema-output"; Description = "Structured output schema handling" },
    @{ Name = "ai-cloud-core"; Description = "Cloud integration abstractions" },
    @{ Name = "ai-cloud-aws"; Description = "AWS adapters" },
    @{ Name = "ai-cloud-gcp"; Description = "GCP adapters" },
    @{ Name = "ai-cloud-azure"; Description = "Azure adapters" },
    @{ Name = "ai-secrets-core"; Description = "Secrets and key management abstraction" },
    @{ Name = "ai-model-registry"; Description = "Model metadata and version management" },
    @{ Name = "ai-model-artifacts"; Description = "Artifact lineage and storage" },
    @{ Name = "ai-experiment-tracking"; Description = "Experiment run tracking" }
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
