#!/bin/bash

# -----------------------------
#  GitHub Auto Push Script
#  Author: Murat
#  Purpose: Fully automated add → commit → push flow
# -----------------------------

# Fail on any error
set -e

# Colors
GREEN="\033[0;32m"
CYAN="\033[0;36m"
RED="\033[0;31m"
NC="\033[0m"

echo -e "${CYAN}"
echo "──────────────────────────────────────────────"
echo "     🚀 GitHub Auto Push Script Running"
echo "──────────────────────────────────────────────"
echo -e "${NC}"

# Check if inside a git repo
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo -e "${RED}Error: This directory is not a Git repository.${NC}"
  exit 1
fi

# Fetch latest
echo -e "${CYAN}🔄 Pulling latest changes...${NC}"
git pull --rebase

# Stage all changes
echo -e "${CYAN}📦 Staging changes...${NC}"
git add .

# Default commit message with timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
DEFAULT_MSG="Auto-update: $TIMESTAMP"

# Custom commit message?
if [ -z "$1" ]; then
  COMMIT_MSG="$DEFAULT_MSG"
else
  COMMIT_MSG="$1"
fi

echo -e "${CYAN}📝 Committing with message:${NC} $COMMIT_MSG"
git commit -m "$COMMIT_MSG" || {
  echo -e "${RED}No changes to commit.${NC}"
  exit 0
}

# Push
echo -e "${CYAN}🚀 Pushing to GitHub...${NC}"
git push

echo -e "${GREEN}"
echo "──────────────────────────────────────────────"
echo "     ✅ Push Completed Successfully"
echo "──────────────────────────────────────────────"
echo -e "${NC}"
