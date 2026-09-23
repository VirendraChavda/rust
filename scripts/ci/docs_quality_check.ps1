$ErrorActionPreference = "Stop"

Write-Host "Building workspace docs with warnings denied"
$env:RUSTDOCFLAGS = "-D warnings"
cargo doc --workspace --no-deps
Remove-Item Env:RUSTDOCFLAGS

Write-Host "Docs quality checks passed."
