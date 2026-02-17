#!/bin/bash
set -e

BRANCH=$(git rev-parse --abbrev-ref HEAD)

echo "🔄 Syncing $BRANCH with main..."
git fetch origin
git merge origin/main --no-edit

echo "🚀 Pushing merged changes..."
git push origin "$BRANCH"

echo "✅ Synced."
