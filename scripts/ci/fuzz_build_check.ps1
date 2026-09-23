$ErrorActionPreference = "Stop"

if (-not (Get-Command cargo-fuzz -ErrorAction SilentlyContinue)) {
    throw "cargo-fuzz is required. Install with: cargo install cargo-fuzz --locked"
}

$fuzzManifests = Get-ChildItem -Path "crates" -Filter "Cargo.toml" -Recurse | Where-Object {
    $_.FullName -match "crates[\\/][^\\/]+[\\/]fuzz[\\/]Cargo.toml$"
}

if ($fuzzManifests.Count -eq 0) {
    Write-Host "No fuzz targets found under crates/*/fuzz, skipping."
    exit 0
}

foreach ($manifest in $fuzzManifests) {
    $fuzzDir = Split-Path -Parent $manifest.FullName
    $crateDir = Split-Path -Parent $fuzzDir
    $crateName = Split-Path -Leaf $crateDir
    Write-Host "Building fuzz targets for $crateName"

    Push-Location $crateDir
    try {
        cargo fuzz build
    }
    finally {
        Pop-Location
    }
}

Write-Host "Fuzz build checks completed."
