#!/bin/bash
set -e

BRANCH=${1:-"main"}

if git show-ref --verify --quiet refs/heads/$BRANCH; then
  echo "✔ Branch exists: $BRANCH"
else
  echo "➕ Creating branch: $BRANCH"
  git checkout -b $BRANCH
  git push -u origin $BRANCH
fi
