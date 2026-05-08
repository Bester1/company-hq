#!/bin/bash
# Wake Protocol — Hermes (CEO) on macOS
# Run at start of every session

SOUL="$HOME/Documents/Company/SOUL.md"
PROJECTS="$HOME/Documents/Company/PROJECTS.md"
DECISIONS="$HOME/Documents/Company/DECISIONS.md"
MEMORY="$HOME/Documents/Company/MEMORY.md"

echo "=== HERMES WAKE PROTOCOL ==="
echo ""

if [ -f "$SOUL" ]; then
    echo "✅ SOUL.md — $(head -5 "$SOUL" | tail -1)"
fi

if [ -f "$PROJECTS" ]; then
    echo "✅ PROJECTS.md — $(grep -c 'P0' "$PROJECTS") P0 items, $(grep -c 'P1' "$PROJECTS") P1 items"
fi

if [ -f "$DECISIONS" ]; then
    echo "✅ DECISIONS.md — last decision: $(head -10 "$DECISIONS" | grep -E '^###' | head -1)"
fi

if [ -f "$MEMORY" ]; then
    echo "✅ MEMORY.md — 3-tier system reference loaded"
fi

# Pull latest from GitHub
cd "$HOME/Documents/Company" && git pull origin main > /dev/null 2>&1 && echo "✅ Company HQ synced from GitHub"

echo ""
echo "=== READY ==="
