#!/usr/bin/env python3
"""
Stub Enrichment Script — Process pending stubs in the queue

Usage:
    python enrich_stubs.py [specific_filename]

If no filename given, processes all pending stubs from the queue.
"""

import sys
import json
import re
from pathlib import Path
from datetime import datetime

COMPANY_DIR = Path.home() / "Documents" / "Company"
INBOX_DIR = COMPANY_DIR / "knowledge" / "inbox"
STUB_QUEUE = COMPANY_DIR / "knowledge" / "stub-queue.jsonl"

def extract_from_web(url: str) -> dict:
    """Use hermes_tools to extract content — only works when called from Hermes agent context."""
    # This is a placeholder — Hermes will replace this with actual web_extract call
    # When run standalone, it returns empty data
    return {"title": "", "content": ""}

def build_markdown(url: str, title: str, content: str, tags: list, captured_date: str) -> str:
    """Build the full enriched markdown."""
    tags_str = " ".join([f"#{t}" for t in tags]) if tags else "#unsorted"
    
    # Clean summary (first 400 chars)
    clean = re.sub(r'[#\*\>\|`\[\]\(\)]', ' ', content)
    summary = clean[:400].strip().replace('\n', ' ')
    
    md = f"""---
captured: {captured_date}
source: {url}
title: {title or 'Untitled'}
tags: {tags_str}
status: inbox
---

# {title or 'Untitled'}

**Source:** [{url}]({url})  
**Captured:** {captured_date}  
**Tags:** {tags_str}

## Summary

{summary}...

## Full Content

{content}

## Connections

- *Add connections here as you discover them*

## Action Items

- [ ] Review and categorize
- [ ] Connect to relevant project/decision
- [ ] Archive or delete if no longer relevant
"""
    return md

def process_stub(filename: str, url: str, tags: list):
    """Process a single stub — Hermes replaces the extraction."""
    filepath = INBOX_DIR / filename
    
    # Read existing stub for captured date
    captured_date = datetime.now().strftime("%Y-%m-%d %H:%M")
    if filepath.exists():
        with open(filepath) as f:
            for line in f:
                if line.startswith("captured:"):
                    captured_date = line.replace("captured:", "").strip()
                if line.startswith("source:"):
                    existing_url = line.replace("source:", "").strip()
                    if existing_url and existing_url != '(pending extraction)':
                        url = existing_url
                    break
    
    # Extract (placeholder — Hermes will do this)
    data = extract_from_web(url)
    title = data.get("title", "")
    content = data.get("content", "")
    
    if not content:
        print(f"⚠️  No content extracted for {filename}")
        return False
    
    # Build enriched markdown
    markdown = build_markdown(url, title, content, tags, captured_date)
    
    # Save
    with open(filepath, 'w') as f:
        f.write(markdown)
    
    print(f"✅ Enriched: {filepath}")
    print(f"   Title: {title or '(no title)'} ({len(content)} chars)")
    return True

def main():
    if len(sys.argv) > 1:
        # Process specific file
        filename = sys.argv[1]
        # Get URL from stub
        filepath = INBOX_DIR / filename
        url = ""
        tags = []
        if filepath.exists():
            with open(filepath) as f:
                for line in f:
                    if line.startswith("source:"):
                        url = line.replace("source:", "").strip()
                    if line.startswith("tags:"):
                        tag_line = line.replace("tags:", "").strip()
                        tags = [t.lstrip('#') for t in tag_line.split()]
        process_stub(filename, url, tags)
    else:
        # Process queue
        if not STUB_QUEUE.exists():
            print("No stub queue found.")
            sys.exit(0)
        
        with open(STUB_QUEUE) as f:
            for line in f:
                try:
                    entry = json.loads(line.strip())
                    if entry.get("status") == "pending":
                        process_stub(entry["filename"], entry["url"], entry.get("tags", []))
                except json.JSONDecodeError:
                    continue

if __name__ == "__main__":
    main()
