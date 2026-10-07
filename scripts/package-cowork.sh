#!/bin/sh
# Build the Microsoft 365 app package for Copilot Cowork from the committed tree.
# Cowork rejects SKILL.md front matter beyond name and description, so the
# Claude-only allowed-tools line is removed from the packaged copies.
set -eu
cd "$(dirname "$0")/.."
version=$(sed -n 's/^  "version": "\(.*\)",$/\1/p' cowork/manifest.json)
plugin_version=$(sed -n 's/^  "version": "\(.*\)",$/\1/p' .claude-plugin/plugin.json)
if [ "$version" != "$plugin_version" ]; then
  echo "cowork/manifest.json version $version does not match plugin.json $plugin_version" >&2
  exit 1
fi
stage=$(mktemp -d)
trap 'rm -rf "$stage"' EXIT
git archive HEAD skills | tar -x -C "$stage"
for f in "$stage"/skills/*/SKILL.md; do
  awk 'NR==1 && /^---$/ {fm=1; print; next} fm && /^---$/ {fm=0} fm && /^allowed-tools:/ {next} {print}' "$f" > "$f.tmp"
  mv "$f.tmp" "$f"
done
git show HEAD:cowork/manifest.json > "$stage/manifest.json"
git show HEAD:cowork/color.png > "$stage/color.png"
git show HEAD:cowork/outline.png > "$stage/outline.png"
mkdir -p dist
out="$PWD/dist/sitefire-cowork-${version}.zip"
rm -f "$out"
(cd "$stage" && zip -q -r -X "$out" manifest.json color.png outline.png skills)
echo "dist/sitefire-cowork-${version}.zip"
