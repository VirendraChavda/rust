param(
    [string]$Package = ""
)

$ErrorActionPreference = "Stop"
$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
Push-Location $root
try {
    $manifests = Get-ChildItem -Path "crates" -Filter "Cargo.toml" -Recurse | Where-Object { $_.FullName -match "crates[\\/][^\\/]+[\\/]Cargo.toml$" }
    if ($manifests.Count -eq 0) {
        throw "No crate manifests found under crates/."
    }

    $failed = $false

    foreach ($manifest in $manifests) {
        $crateDir = Split-Path -Parent $manifest.FullName
        $crateName = Split-Path -Leaf $crateDir
        if ($Package -and $crateName -ne $Package) {
            continue
        }

        Write-Host "Checking release readiness for $crateName"

        $cargoText = Get-Content $manifest.FullName -Raw
        $versionMatch = [regex]::Match($cargoText, '(?m)^version\s*=\s*"([^"]+)"')
        $licenseMatch = [regex]::Match($cargoText, '(?m)^license\s*=')
        $licenseFileMatch = [regex]::Match($cargoText, '(?m)^license-file\s*=')

        if (-not $versionMatch.Success) {
            Write-Error "[$crateName] Missing version in Cargo.toml"
            $failed = $true
        }

        if (-not $licenseMatch.Success -and -not $licenseFileMatch.Success) {
            Write-Error "[$crateName] Missing license or license-file in Cargo.toml"
            $failed = $true
        }

        foreach ($required in @("README.md", "CHANGELOG.md")) {
            $p = Join-Path $crateDir $required
            if (-not (Test-Path $p)) {
                Write-Error "[$crateName] Missing $required"
                $failed = $true
            }
        }
    }

    if ($failed) {
        throw "Release readiness checks failed."
    }

    Write-Host "Release readiness checks passed."
}
finally {
    Pop-Location
}
