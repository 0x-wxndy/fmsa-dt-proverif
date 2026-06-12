# Run ProVerif on bundled models and write logs + elapsed ms under formal/proverif/out/.
# Requires: proverif on PATH (install via WSL/opam — see formal/proverif/README.md).

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $PSScriptRoot
$PvDir = Join-Path $Root "formal\proverif"
$Out = Join-Path $PvDir "out"

New-Item -ItemType Directory -Force -Path $Out | Out-Null

function Run-Model([string]$RelPath) {
    $pv = Join-Path $PvDir $RelPath
    $base = [System.IO.Path]::GetFileNameWithoutExtension($pv)
    $log = Join-Path $Out "$base.log"
    Write-Host "Running ProVerif on $RelPath ..."
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    & proverif -in pitype $pv 2>&1 | Tee-Object -FilePath $log
    $sw.Stop()
    $ms = $sw.ElapsedMilliseconds
    $timeFile = Join-Path $Out "$base.time_ms.txt"
    Set-Content -Path $timeFile -Value $ms
    Write-Host "Wrote $log and $timeFile (${ms} ms)"
}

try {
    Get-Command proverif | Out-Null
} catch {
    Write-Error "proverif not found on PATH. Install per formal/proverif/README.md (e.g. WSL: opam install proverif)."
}

Run-Model "examples\minimal_secrecy.pv"
Run-Model "sdt_abstract.pv"
Run-Model "sdt_signed_pipeline.pv"
Write-Host "Done."
