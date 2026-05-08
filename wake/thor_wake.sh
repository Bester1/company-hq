#!/bin/bash
# Wake Protocol — THOR (Head of Product) on macOS
# Run at start of every session

COMPANY="$HOME/Documents/Company"
DB_USER="$HOME/.openclaw/workspace/shared-context/memory.db"  # synced copy

echo "=== THOR WAKE PROTOCOL ==="
echo ""

# Tier 3
cd "$COMPANY" && git pull origin main > /dev/null 2>&1 && echo "✅ Tier 3 (GitHub) synced"

# Tier 2 (if sync working)
if [ -f "$DB_USER" ]; then
    echo ""
    echo "--- Agent Status (from synced Tier 2) ---"
    sqlite3 "$DB_USER" "SELECT name || ' -> ' || status FROM agents ORDER BY last_seen DESC;" 2>/dev/null || echo "⚠️ Synced DB not available — check rsync"
else
    echo "⚠️ Tier 2 DB not synced locally — check file sync"
fi

echo ""
echo "=== THOR CHECKLIST ==="
echo "1. Dashboard panels go INSIDE <main> tag"
echo "2. JS token variable is 'token'"
echo "3. No server config changes (Frikkie's lane)"
echo ""
echo "=== READY ==="
