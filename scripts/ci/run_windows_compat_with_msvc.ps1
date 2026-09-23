$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
$vswhere = "C:\Program Files (x86)\Microsoft Visual Studio\Installer\vswhere.exe"

if (-not (Test-Path $vswhere)) {
    throw "vswhere.exe not found at '$vswhere'. Install Visual Studio Build Tools first."
}

$installPath = & $vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath
if (-not $installPath) {
    throw "No Visual Studio Build Tools installation with C++ tools was found."
}

$vcvars = Join-Path $installPath "VC\Auxiliary\Build\vcvars64.bat"
if (-not (Test-Path $vcvars)) {
    throw "vcvars64.bat not found at '$vcvars'."
}

$compatScript = Join-Path $repoRoot "scripts\ci\windows_compat_check.ps1"
$command = '"' + $vcvars + '" && cd /d "' + $repoRoot + '" && powershell -NoProfile -ExecutionPolicy Bypass -File "' + $compatScript + '"'

Write-Host "Launching Windows compatibility checks in MSVC environment..."
cmd /c $command

if ($LASTEXITCODE -ne 0) {
    throw "Windows compatibility checks failed with exit code $LASTEXITCODE."
}

Write-Host "Windows compatibility checks completed successfully."
