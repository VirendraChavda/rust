$ErrorActionPreference = "Stop"

Write-Host "[1/4] preflight environment checks"
& (Join-Path $PSScriptRoot "preflight_check.ps1")

Write-Host "[2/4] cargo fmt --all -- --check"
cargo fmt --all -- --check

Write-Host "[3/4] cargo check --workspace --all-targets"
cargo check --workspace --all-targets

Write-Host "[4/4] cargo test --workspace"
cargo test --workspace

Write-Host "Windows compatibility checks passed."
