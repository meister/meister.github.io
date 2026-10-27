#!/usr/bin/env bash
set -euo pipefail
workdir=${GITHUB_WORKSPACE:-$(cd "$(dirname "$0")/.." && pwd)}
version=${1:-latest}
output=$(mktemp)
trap 'rm -f "$output"' EXIT
if [[ -n "${MEISTER_CLI:-}" ]]; then
  node "$MEISTER_CLI" > "$output"
else
  npm exec --yes --package="meister@$version" -- meister > "$output"
fi
node "$workdir/scripts/render-card.js" "$output" "$workdir"
