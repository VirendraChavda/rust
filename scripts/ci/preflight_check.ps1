$ErrorActionPreference = "Stop"

if (-not (Get-Command cargo -ErrorAction SilentlyContinue)) {
    throw "cargo is not available in PATH. Install Rustup and ensure cargo is on PATH."
}

if ($IsWindows) {
    if (-not (Get-Command link.exe -ErrorAction SilentlyContinue)) {
        throw "link.exe is not available. Install Visual Studio Build Tools with C++ toolchain and use a Developer PowerShell session, or run scripts/ci/run_windows_compat_with_msvc.ps1."
    }
}

Write-Host "Preflight checks passed."
