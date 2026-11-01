# Run stock benilla on Windows. Set WOW_DATA before calling if your Data folder is elsewhere.
param(
    [string]$Data = ""
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent (Split-Path -Parent $MyInvocation.MyCommand.Path)
Set-Location $Root

$CargoBin = Join-Path $env:USERPROFILE ".cargo\bin"
if (Test-Path $CargoBin) {
    $env:Path = "$CargoBin;$env:Path"
}

if (-not $Data) {
    $candidates = @(
        (Join-Path $Root "wow-data\Data"),
        (Join-Path $Root "..\azeroth-survivors-re\wow-data\Data")
    )
    foreach ($c in $candidates) {
        if ((Test-Path (Join-Path $c "terrain.MPQ")) -and (Test-Path (Join-Path $c "patch.MPQ"))) {
            $Data = $c
            break
        }
    }
}

if (-not $Data) {
    Write-Host "No 1.12.1 Data found. Pass -Data 'C:\path\to\Data' or extract MPQs (see upstream README)."
    exit 1
}

$env:WOW_DATA = (Resolve-Path $Data).Path
Write-Host "WOW_DATA=$($env:WOW_DATA)"
Write-Host "Starting benilla (vanilla 1.12.1 client) ..."
& cargo run --release -p benilla
