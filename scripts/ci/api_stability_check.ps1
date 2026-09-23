$ErrorActionPreference = "Stop"

Write-Host "Running API stability checks for published crates"

if (-not (Get-Command cargo-semver-checks -ErrorAction SilentlyContinue)) {
    throw "cargo-semver-checks is required. Install with: cargo install cargo-semver-checks --locked"
}

$manifests = Get-ChildItem -Path "crates" -Filter "Cargo.toml" -Recurse | Where-Object { $_.FullName -match "crates[\\/][^\\/]+[\\/]Cargo.toml$" }
if ($manifests.Count -eq 0) {
    throw "No crate manifests found under crates/."
}

$failed = $false

foreach ($manifest in $manifests) {
    $crateDir = Split-Path -Parent $manifest.FullName
    $crateName = Split-Path -Leaf $crateDir

    try {
        $response = Invoke-WebRequest -UseBasicParsing -Uri "https://crates.io/api/v1/crates/$crateName" -TimeoutSec 20
        if ($response.StatusCode -ne 200) {
            Write-Host "[$crateName] not published on crates.io, skipping semver check"
            continue
        }
    }
    catch {
        Write-Host "[$crateName] not published on crates.io, skipping semver check"
        continue
    }

    Write-Host "[$crateName] running cargo semver-checks"
    cargo semver-checks check-release --package $crateName
    if ($LASTEXITCODE -ne 0) {
        Write-Host "[$crateName] semver check failed"
        $failed = $true
    }
}

if ($failed) {
    throw "API stability checks failed."
}

Write-Host "API stability checks passed."
