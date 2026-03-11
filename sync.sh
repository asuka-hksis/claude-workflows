#!/bin/bash
# Sync Claude Code memory workflow files to GitHub repository

MEMORY_DIR="/Users/asuka/.claude/projects/-Users-asuka/memory"
REPO_DIR="/Users/asuka/repos/claude-workflows"

# Copy all .md files from memory dir to repo (excluding sync script)
rsync -a --delete --include='*.md' --exclude='*' "$MEMORY_DIR/" "$REPO_DIR/"

cd "$REPO_DIR" || exit 1

# Check if there are any changes
if git diff --quiet && git diff --cached --quiet && [ -z "$(git ls-files --others --exclude-standard)" ]; then
    exit 0
fi

# Commit and push changes
git add -A
git commit -m "Auto-sync workflow files $(date '+%Y-%m-%d %H:%M')"
git push origin main
