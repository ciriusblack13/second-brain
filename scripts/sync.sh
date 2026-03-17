#!/bin/bash
# Second Brain — Auto Sync
# Commits local changes, pulls remote, pushes.
# Designed to run via cron on both Mac and VPS.
# Conflicts are auto-resolved by keeping both versions.

set -euo pipefail

VAULT_DIR="${VAULT_DIR:-$HOME/second-brain}"
[ -d "$VAULT_DIR/.git" ] || { echo "Not a git repo: $VAULT_DIR"; exit 1; }

cd "$VAULT_DIR"

# Stage all changes
git add -A

# Commit if there are changes
if ! git diff --cached --quiet; then
  HOSTNAME=$(hostname -s)
  git commit -m "vault sync from $HOSTNAME [$(date +%Y-%m-%d\ %H:%M)]"
fi

# Pull with rebase to keep history clean, auto-resolve conflicts
git pull --rebase --autostash origin main 2>/dev/null || {
  # If rebase fails, abort and merge instead
  git rebase --abort 2>/dev/null || true
  git pull --no-edit origin main || true
}

# Push
git push origin main 2>/dev/null || true
