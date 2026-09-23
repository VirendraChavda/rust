# Python AI Backend Essential Manifest

This manifest extends the initial parity scaffold with additional modules commonly used in production Python AI backends.

## Provider and model gateway expansion

- ai-llm-azure-openai
- ai-llm-bedrock
- ai-llm-ollama
- ai-llm-cohere
- ai-llm-mistral
- ai-llm-groq
- ai-llm-vertex

## RAG pipeline and document intelligence

- ai-rag-core
- ai-rag-pipeline
- ai-rag-citations
- ai-document-parsers
- ai-document-ocr
- ai-document-pdf
- ai-document-web-crawl
- ai-indexing-core
- ai-indexing-incremental

## Vector backend parity

- ai-vector-milvus
- ai-vector-pinecone
- ai-vector-elasticsearch
- ai-vector-opensearch
- ai-vector-chroma

## Serving and API platform parity

- ai-serving-openapi
- ai-serving-validation
- ai-serving-auth
- ai-serving-rate-limit
- ai-serving-background-tasks
- ai-serving-sse
- ai-serving-grpc

## Workflow, queue, and scheduling parity

- ai-workflow-scheduler
- ai-workflow-cron
- ai-workflow-dag
- ai-workflow-retries
- ai-queue-core
- ai-queue-redis
- ai-queue-rabbitmq
- ai-queue-kafka
- ai-queue-sqs

## Persistence, caching, and migrations parity

- ai-store-redis
- ai-store-postgres
- ai-store-mongodb
- ai-cache-core
- ai-cache-redis
- ai-migrations-core

## Observability and evaluation expansion

- ai-observe-logging
- ai-observe-opentelemetry
- ai-observe-prometheus
- ai-observe-alerting
- ai-eval-datasets
- ai-eval-regression

## Schema, auth, policy, and safety expansion

- ai-schema-model
- ai-schema-validation
- ai-auth-core
- ai-auth-jwt
- ai-auth-oauth
- ai-policy-engine
- ai-secrets-vault

## MLOps and lifecycle expansion

- ai-model-serving
- ai-model-monitoring
- ai-model-drift
- ai-model-rollout
- ai-feature-store-core
- ai-dataset-versioning

## Integrations and platform adapters

- ai-integration-slack
- ai-integration-github
- ai-cloud-kubernetes
- ai-cloud-helm

## Notes

- Crates are scaffolded as independent workspace members under crates/.
- Initial scaffolds provide placeholders for iterative implementation.
- Use domain parity prompts and skills to drive milestone-by-milestone implementation.
