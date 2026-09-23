param(
    [Parameter(Mandatory = $true)]
    [string]$Name,
    [string]$Description = "Rust AI backend crate",
    [switch]$SkipTests
)

$ErrorActionPreference = "Stop"

if ($Name -notmatch "^[a-z][a-z0-9-]*$") {
    throw "Crate name must be kebab-case and start with a letter."
}

$root = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$crateDir = Join-Path $root "crates\$Name"
if (Test-Path $crateDir) {
    throw "Crate directory already exists: $crateDir"
}

Push-Location $root
try {
    cargo new "crates/$Name" --lib

    $cargoToml = @"
[package]
name = "$Name"
version = "0.1.0"
edition = "2024"
license = "MIT OR Apache-2.0"
description = "$Description"
repository = "https://github.com/VirendraChavda/rust"
readme = "README.md"
keywords = ["ai", "backend", "rust"]
categories = ["development-tools"]

[dependencies]
"@
    Set-Content -Path (Join-Path $crateDir "Cargo.toml") -Value $cargoToml -NoNewline

    $readme = @"
# $Name

$Description

## Maturity

experimental

## Development

```bash
cargo test -p $Name
```

## License

Dual-licensed under MIT OR Apache-2.0.
"@
    Set-Content -Path (Join-Path $crateDir "README.md") -Value $readme -NoNewline

    $changelog = @"
# Changelog

All notable changes to this crate will be documented in this file.

## [0.1.0] - TBD

- Initial scaffold.
"@
    Set-Content -Path (Join-Path $crateDir "CHANGELOG.md") -Value $changelog -NoNewline

    New-Item -ItemType Directory -Path (Join-Path $crateDir "tests") -Force | Out-Null

    $libRs = @"
/// Returns a static crate health string.
pub fn health() -> &'static str {
    "ok"
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn health_is_ok() {
        assert_eq!(health(), "ok");
    }
}
"@
    Set-Content -Path (Join-Path $crateDir "src\lib.rs") -Value $libRs -NoNewline

    $smoke = @"
use $($Name -replace '-', '_')::health;

#[test]
fn smoke_health() {
    assert_eq!(health(), "ok");
}
"@
    Set-Content -Path (Join-Path $crateDir "tests\smoke.rs") -Value $smoke -NoNewline

    if (-not $SkipTests) {
        cargo test -p $Name
    }
    Write-Host "Created crate: $Name"
}
finally {
    Pop-Location
}
