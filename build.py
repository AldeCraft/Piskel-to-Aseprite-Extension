#!/usr/bin/env python3
"""Packages the extension into dist/piskel-to-aseprite-extension.aseprite-extension.

An Aseprite extension is just a ZIP file renamed to .aseprite-extension with
package.json and the Lua scripts at the root of the archive. There is nothing
to compile. Requires Python 3.6+ and no third-party packages.
"""
import json
import os
import zipfile

ROOT = os.path.dirname(os.path.abspath(__file__))
FILES = ["package.json", "piskel-to-aseprite-extension.lua"]


def main():
    for name in FILES:
        if not os.path.isfile(os.path.join(ROOT, name)):
            raise SystemExit("Missing file: " + name)

    with open(os.path.join(ROOT, "package.json"), encoding="utf-8") as f:
        meta = json.load(f)  # fails early if package.json is malformed

    dist = os.path.join(ROOT, "dist")
    os.makedirs(dist, exist_ok=True)
    out = os.path.join(dist, meta["name"] + ".aseprite-extension")

    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        for name in FILES:
            z.write(os.path.join(ROOT, name), arcname=name)

    print("Built %s (version %s)" % (out, meta.get("version", "?")))


if __name__ == "__main__":
    main()
