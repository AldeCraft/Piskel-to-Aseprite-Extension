#!/usr/bin/env sh
# Packages the extension into dist/piskel-to-aseprite-extension.aseprite-extension (Linux / macOS)
set -e
cd "$(dirname "$0")"
mkdir -p dist
rm -f dist/piskel-to-aseprite-extension.aseprite-extension dist/piskel-to-aseprite-extension.zip
zip -j dist/piskel-to-aseprite-extension.zip package.json piskel-to-aseprite-extension.lua
mv dist/piskel-to-aseprite-extension.zip dist/piskel-to-aseprite-extension.aseprite-extension
echo "Built dist/piskel-to-aseprite-extension.aseprite-extension"
