$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$codesDir = Join-Path $root 'codes'
$zipPath = Join-Path $codesDir 'codes.zip'

if (Test-Path $zipPath) {
  Remove-Item $zipPath -Force
}

$files = Get-ChildItem -Path $codesDir -File -Recurse |
  Where-Object { $_.FullName -ne $zipPath }

if ($files.Count -eq 0) {
  throw 'No files found in codes directory to zip.'
}

Compress-Archive -Path $files.FullName -DestinationPath $zipPath -Force
