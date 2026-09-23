$ErrorActionPreference = "Stop"

$modules = @(
    @{ Name = "ai-prompt-registry"; Description = "Prompt registry and versioning" },
    @{ Name = "ai-prompt-loader"; Description = "Prompt loading from file, db, and remote sources" },
    @{ Name = "ai-prompt-renderer"; Description = "Deterministic prompt rendering engine" },
    @{ Name = "ai-prompt-optimizer"; Description = "Prompt optimization and budget shaping" },
    @{ Name = "ai-prompt-ab-testing"; Description = "Prompt A/B testing orchestration" },
    @{ Name = "ai-prompt-localization"; Description = "Prompt localization and locale strategies" },
    @{ Name = "ai-output-parser-core"; Description = "Unified output parser contracts" },
    @{ Name = "ai-output-guard"; Description = "Post-parse validation and guard pipeline" },
    @{ Name = "ai-output-diff"; Description = "Output comparison and regression diffing" },
    @{ Name = "ai-json-parser-core"; Description = "Robust JSON extraction and parsing" },
    @{ Name = "ai-json-repair"; Description = "Malformed JSON repair engine" },
    @{ Name = "ai-tool-call-schema"; Description = "Tool-call schema definitions" },
    @{ Name = "ai-tool-call-parser"; Description = "Tool-call payload parsing and coercion" },
    @{ Name = "ai-agent-memory-window"; Description = "Agent memory window and truncation policies" },
    @{ Name = "ai-agent-transcript"; Description = "Canonical transcript and replay format" },
    @{ Name = "ai-agent-planner"; Description = "Plan generation and step modeling" },
    @{ Name = "ai-agent-executor"; Description = "Plan execution runtime" },
    @{ Name = "ai-agent-fallback"; Description = "Agent fallback and retry orchestration" },
    @{ Name = "ai-agent-simulation"; Description = "Agent simulation and dry-run harness" },
    @{ Name = "ai-parser-benchmark"; Description = "Parser performance and correctness benchmark suite" }
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
