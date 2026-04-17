#!/bin/bash

set -euo pipefail

cd "$(dirname "$0")"

echo "=== Installing Claude Code Skills ==="

while IFS=' ' read -r repo skills || [ -n "${repo:-}" ]; do
    [[ -z "${repo:-}" || "$repo" =~ ^# ]] && continue
    echo "Installing $repo ($skills)..."
    npx skills add "$repo" --global --skill "$skills" --yes
done < skills.txt

echo ""
echo "=== Skills installed ==="
echo "Verify with: npx skills list"
