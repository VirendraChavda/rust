$ErrorActionPreference = "Stop"

Write-Host "[1/3] cargo fmt --all -- --check"
cargo fmt --all -- --check

Write-Host "[2/3] cargo clippy --workspace --all-targets --all-features -- -D warnings"
cargo clippy --workspace --all-targets --all-features -- -D warnings

Write-Host "[3/3] cargo test --workspace"
cargo test --workspace

Write-Host "All checks passed."
