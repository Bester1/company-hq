#!/bin/bash
# Wake Protocol -- THOR (Head of Product) on macOS
# Run at start of every session

COMPANY="$HOME/Documents/Company"

echo "=== THOR WAKE PROTOCOL ==="
echo ""

# Tier 3
cd "$COMPANY" && git pull origin main > /dev/null 2>&1 && echo "Tier 3 (GitHub) synced"

echo ""
echo "--- Tier 3: Project State ---"
if [ -f "$COMPANY/PROJECTS.md" ]; then
    echo "P0 items: $(grep -c 'P0' "$COMPANY/PROJECTS.md")"
    echo "P1 items: $(grep -c 'P1' "$COMPANY/PROJECTS.md")"
    echo "P2 items: $(grep -c 'P2' "$COMPANY/PROJECTS.md")"
fi

echo ""
echo "--- THOR LANES ---"
echo "1. Dashboard panels go INSIDE <main> tag"
echo "2. JS token variable is 'token'"
echo "3. No server config changes (Frikkie's lane)"
echo "4. Content pipeline: Composio YT Shorts"
echo "5. Mission Control at https://app.hansa.global"
echo ""
echo "=== READY ==="
