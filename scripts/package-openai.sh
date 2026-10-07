#!/bin/sh
# Build the ZIP for the OpenAI plugin portal from the committed tree.
# The Claude manifests are left out so the portal reads .codex-plugin/plugin.json.
set -eu
cd "$(dirname "$0")/.."
version=$(sed -n 's/^  "version": "\(.*\)",$/\1/p' .codex-plugin/plugin.json)
out="dist/sitefire-openai-${version}.zip"
mkdir -p dist
rm -f "$out"
git archive --format=zip --output="$out" HEAD \
  .codex-plugin/plugin.json .mcp.json skills assets README.md LICENSE
echo "$out"
