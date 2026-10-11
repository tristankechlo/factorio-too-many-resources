$ErrorActionPreference = "Stop"

$repoRoot = git rev-parse --show-toplevel
if ($LASTEXITCODE -ne 0) {
    throw "Could not find the Git repository root."
}

Set-Location $repoRoot
$info = Get-Content -Raw -Path "info.json" | ConvertFrom-Json
if ([string]::IsNullOrWhiteSpace($info.name) -or [string]::IsNullOrWhiteSpace($info.version)) {
    throw "Could not read the mod name and version from info.json."
}

$prefix = "$($info.name)_$($info.version)/"
$archive = "$($info.name)_$($info.version).zip"
git archive "--prefix=$prefix" "--output=$archive" HEAD
if ($LASTEXITCODE -ne 0) {
    throw "Failed to create $archive."
}

Write-Output "Created $archive"
