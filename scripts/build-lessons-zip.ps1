$ErrorActionPreference = 'Stop'

$root = Split-Path -Parent $PSScriptRoot
$lessonsDir = Join-Path $root 'lessons'
$zipPath = Join-Path $lessonsDir 'lessons.zip'

if (Test-Path $zipPath) {
  Remove-Item $zipPath -Force
}

$files = Get-ChildItem -Path $lessonsDir -File -Recurse |
  Where-Object { $_.FullName -ne $zipPath }

if ($files.Count -eq 0) {
  throw 'No files found in lessons directory to zip.'
}

Compress-Archive -Path $files.FullName -DestinationPath $zipPath -Force
