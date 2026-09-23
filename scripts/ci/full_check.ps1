$ErrorActionPreference = "Stop"

Write-Host "[0/4] preflight environment checks"
& (Join-Path $PSScriptRoot "preflight_check.ps1")

Write-Host "[1/4] cargo fmt --all -- --check"
cargo fmt --all -- --check

Write-Host "[2/4] cargo clippy --workspace --all-targets --all-features -- -D warnings"
cargo clippy --workspace --all-targets --all-features -- -D warnings

Write-Host "[3/4] cargo test --workspace"
cargo test --workspace

Write-Host "All checks passed."
