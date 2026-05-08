#!/bin/bash
# Wake Protocol — Frikkie (CTO) on Oracle VM
# Run at start of every session or SSH login

COMPANY="$HOME/company"
SOUL="$COMPANY/SOUL.md"
PROJECTS="$COMPANY/PROJECTS.md"
DECISIONS="$COMPANY/DECISIONS.md"
MEMORY="$COMPANY/MEMORY.md"
DB="/home/ubuntu/shared-context/memory.db"

echo "=== FRIKKIE WAKE PROTOCOL ==="
echo ""

# Tier 3: Git ground truth
cd "$COMPANY" && git pull origin main > /dev/null 2>&1 && echo "✅ Tier 3 (GitHub) synced"

if [ -f "$SOUL" ]; then echo "✅ SOUL.md loaded"; fi
if [ -f "$PROJECTS" ]; then echo "✅ PROJECTS.md loaded ($(grep -c 'P0' "$PROJECTS") P0 items)"; fi
if [ -f "$DECISIONS" ]; then echo "✅ DECISIONS.md loaded"; fi
if [ -f "$MEMORY" ]; then echo "✅ MEMORY.md loaded"; fi

# Tier 2: Query unified memory
echo ""
echo "--- Tier 2: Agent Status ---"
sqlite3 "$DB" "SELECT name || ' -> ' || status || ': ' || COALESCE(current_task,'idle') FROM agents ORDER BY last_seen DESC;"

echo ""
echo "--- Tier 2: Active Tasks ---"
sqlite3 "$DB" "SELECT priority || ' ' || title || ' (' || owner || ')' FROM tasks WHERE status IN ('in_progress','pending','blocked') ORDER BY CASE priority WHEN 'P0' THEN 1 WHEN 'P1' THEN 2 WHEN 'P2' THEN 3 ELSE 4 END;"

echo ""
echo "--- Tier 2: Unread Pings ---"
PINGS=$(sqlite3 "$DB" "SELECT COUNT(*) FROM pings WHERE to_agent='frikkie' AND read=0;")
if [ "$PINGS" -gt 0 ]; then
    echo "⚠️ $PINGS unread pings:"
    sqlite3 "$DB" "SELECT from_agent || ': ' || message || ' (' || urgency || ')' FROM pings WHERE to_agent='frikkie' AND read=0 ORDER BY urgency DESC;"
else
    echo "No unread pings."
fi

# Write heartbeat
sqlite3 "$DB" "UPDATE agents SET status='working', last_seen=datetime('now'), current_task='Waking up and checking memory' WHERE name='frikkie';"

echo ""
echo "=== READY ==="
