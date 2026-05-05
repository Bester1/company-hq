#!/bin/bash
# COMPANY HQ SYNC
# One-button push to GitHub + mirror to Oracle VM

set -e

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_NAME="company-hq"
GITHUB_USER="Bester1"
SERVER="ubuntu@84.8.142.118"
SERVER_DIR="/home/ubuntu/company"
SSH_KEY="/Users/user/Documents/ORACLE VM/ssh-key-2025-10-11.key"

echo "=== Company HQ Sync ==="
echo "Dir: $DIR"
echo ""

# 1. Git add/commit/push
cd "$DIR"
if [ ! -d ".git" ]; then
    echo "ERROR: Not a git repo. Run setup first."
    exit 1
fi

git add -A
if git diff --cached --quiet; then
    echo "No changes to commit."
else
    git commit -m "auto-sync: $(date '+%Y-%m-%d %H:%M:%S')"
    git push origin main
    echo "Pushed to GitHub."
fi

# 2. Mirror to Oracle VM via SSH
echo ""
echo "Mirroring to Oracle VM..."
ssh -i "$SSH_KEY" "$SERVER" "mkdir -p $SERVER_DIR && cd $SERVER_DIR && git pull origin main 2>/dev/null || (rm -rf $SERVER_DIR/.git && git clone https://github.com/$GITHUB_USER/$REPO_NAME.git $SERVER_DIR/tmp && mv $SERVER_DIR/tmp/* $SERVER_DIR/ && rm -rf $SERVER_DIR/tmp)" || {
    echo "WARNING: Git pull failed. Falling back to rsync..."
    rsync -avz -e "ssh -i '$SSH_KEY'" --exclude='.git' "$DIR/" "$SERVER:$SERVER_DIR/"
}

echo ""
echo "=== Sync Complete ==="
echo "GitHub: https://github.com/$GITHUB_USER/$REPO_NAME"
echo "Server: $SERVER:$SERVER_DIR"
echo "All agents should read SOUL.md on next wake."
