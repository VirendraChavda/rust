param(
    [Parameter(Mandatory = $true)]
    [string]$Crate
)

$ErrorActionPreference = "Stop"
$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$crateDir = Join-Path $root "crates\$Crate"

if (-not (Test-Path $crateDir)) {
    throw "Crate not found: $Crate"
}

if (-not (Get-Command cargo-fuzz -ErrorAction SilentlyContinue)) {
    Write-Host "cargo-fuzz not found, installing..."
    cargo install cargo-fuzz --locked
}

Push-Location $crateDir
try {
    if (-not (Test-Path "fuzz")) {
        cargo fuzz init
    }

    $targetFile = "fuzz\fuzz_targets\fuzz_target_1.rs"
    if (Test-Path $targetFile) {
        Write-Host "fuzz target already exists: $targetFile"
    }
    else {
        New-Item -ItemType Directory -Path "fuzz\fuzz_targets" -Force | Out-Null
        $content = @"
#![no_main]
use libfuzzer_sys::fuzz_target;

fuzz_target!(|data: &[u8]| {
    let _ = data;
});
"@
        Set-Content -Path $targetFile -Value $content -NoNewline
    }
}
finally {
    Pop-Location
}

Write-Host "Fuzz scaffold ready for crate: $Crate"
