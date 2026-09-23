# Prompt and Output Pipeline Manifest

This manifest captures prompt handling, output parsing, and agentic pipeline runtime crates needed for production-grade AI backend behavior.

## Prompt management

- ai-prompt-registry
- ai-prompt-loader
- ai-prompt-renderer
- ai-prompt-optimizer
- ai-prompt-ab-testing
- ai-prompt-localization

## Output parsing and repair

- ai-output-parser-core
- ai-output-guard
- ai-output-diff
- ai-json-parser-core
- ai-json-repair

## Tool-call and structured action parsing

- ai-tool-call-schema
- ai-tool-call-parser

## Agentic pipeline runtime

- ai-agent-memory-window
- ai-agent-transcript
- ai-agent-planner
- ai-agent-executor
- ai-agent-fallback
- ai-agent-simulation

## Quality and benchmarking

- ai-parser-benchmark

## Notes

- These crates are scaffolded as L1 placeholders for iterative implementation.
- Use parity and reliability prompts/skills to fill in APIs by family.
