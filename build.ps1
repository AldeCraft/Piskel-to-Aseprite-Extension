# Packages the extension into dist\piskel-importer.aseprite-extension (Windows PowerShell)
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $MyInvocation.MyCommand.Path
$dist = Join-Path $root "dist"
New-Item -ItemType Directory -Force -Path $dist | Out-Null

$zip = Join-Path $dist "piskel-importer.zip"
$out = Join-Path $dist "piskel-importer.aseprite-extension"
Remove-Item $zip, $out -ErrorAction SilentlyContinue

Compress-Archive -Path (Join-Path $root "package.json"), (Join-Path $root "piskel-importer.lua") -DestinationPath $zip
Move-Item $zip $out
Write-Host "Built $out"
