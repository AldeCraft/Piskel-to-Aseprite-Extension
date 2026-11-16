#!/usr/bin/env sh
# Packages the extension into dist/piskel-importer.aseprite-extension (Linux / macOS)
set -e
cd "$(dirname "$0")"
mkdir -p dist
rm -f dist/piskel-importer.aseprite-extension dist/piskel-importer.zip
zip -j dist/piskel-importer.zip package.json piskel-importer.lua
mv dist/piskel-importer.zip dist/piskel-importer.aseprite-extension
echo "Built dist/piskel-importer.aseprite-extension"
