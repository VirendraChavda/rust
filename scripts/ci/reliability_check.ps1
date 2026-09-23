$ErrorActionPreference = "Stop"

Write-Host "[1/3] cargo test --workspace"
cargo test --workspace

Write-Host "[2/3] cargo test --workspace --release"
cargo test --workspace --release

Write-Host "[3/3] benchmark compile check (if benches exist)"
$benchFiles = Get-ChildItem -Path "crates" -Recurse -File | Where-Object { $_.FullName -match "[\\/]benches[\\/]" }
if ($benchFiles.Count -gt 0) {
    cargo bench --workspace --no-run
}
else {
    Write-Host "No benches found, skipping bench compile check."
}

Write-Host "Reliability checks passed."
