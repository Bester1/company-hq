#!/usr/bin/env python3
"""
Knowledge Capture Stub — Fast, works anywhere

Usage:
    python save_url.py <url> [tags...]

Creates a lightweight stub in the inbox. Hermes agent processes it
later to extract full content and build the complete markdown.

This is the FAST path — no external dependencies, no web extraction.
"""

import sys
import os
import re
import hashlib
import json
from datetime import datetime
from pathlib import Path
from urllib.parse import urlparse

# --- Config ---
COMPANY_DIR = Path.home() / "Documents" / "Company"
INBOX_DIR = COMPANY_DIR / "knowledge" / "inbox"
PROCESSED_DIR = COMPANY_DIR / "knowledge" / "processed"
KNOWLEDGE_LOG = COMPANY_DIR / "knowledge" / "knowledge-log.jsonl"
STUB_QUEUE = COMPANY_DIR / "knowledge" / "stub-queue.jsonl"

# Ensure dirs exist
for d in [INBOX_DIR, PROCESSED_DIR, KNOWLEDGE_LOG.parent]:
    d.mkdir(parents=True, exist_ok=True)

def make_slug(url: str) -> str:
    """Generate a short unique slug from the URL."""
    parsed = urlparse(url)
    domain = parsed.netloc.replace('www.', '').replace('twitter.com', 'x').replace('x.com', 'x')
    path_stub = parsed.path.strip('/').split('/')[-1][:30] if parsed.path else ''
    url_hash = hashlib.md5(url.encode()).hexdigest()[:6]
    return f"{domain}-{path_stub}-{url_hash}".strip('-').replace('/', '-').lower()[:80]

def build_stub(url: str, tags: list) -> str:
    """Build a lightweight stub markdown."""
    date = datetime.now().strftime("%Y-%m-%d %H:%M")
    date_slug = datetime.now().strftime("%Y-%m-%d")
    tags_str = " ".join([f"#{t}" for t in tags]) if tags else "#unsorted"
    slug = make_slug(url)
    
    md = f"""---
captured: {date}
source: {url}
title: (pending extraction)
tags: {tags_str}
status: stub
---

# (Pending Extraction)

**Source:** [{url}]({url})  
**Captured:** {date}  
**Tags:** {tags_str}

> This is a stub. Hermes will process it to extract full content.
> Run: `process_stub("{date_slug}--{slug}.md")` to extract.

## Action Items

- [ ] Extract and enrich content
- [ ] Summarize key insights
- [ ] Connect to relevant project/decision
"""
    return md, f"{date_slug}--{slug}.md"

def save_to_log(entry: dict):
    """Append entry to the knowledge log (JSONL)."""
    with open(KNOWLEDGE_LOG, 'a') as f:
        f.write(json.dumps(entry) + '\n')

def add_to_queue(filename: str, url: str, tags: list):
    """Add to stub queue for batch processing."""
    with open(STUB_QUEUE, 'a') as f:
        f.write(json.dumps({
            "timestamp": datetime.now().isoformat(),
            "filename": filename,
            "url": url,
            "tags": tags,
            "status": "pending"
        }) + '\n')

def main():
    if len(sys.argv) < 2:
        print("Usage: save_url.py <url> [tag1 tag2 ...]")
        sys.exit(1)
    
    url = sys.argv[1]
    tags = sys.argv[2:] if len(sys.argv) > 2 else []
    
    print(f"💾 Saving stub for: {url}")
    
    # Build stub
    markdown, filename = build_stub(url, tags)
    filepath = INBOX_DIR / filename
    
    # Check for duplicates
    if filepath.exists():
        print(f"⚠️  Stub already exists: {filepath}")
        sys.exit(0)
    
    # Save stub
    with open(filepath, 'w') as f:
        f.write(markdown)
    
    # Log
    log_entry = {
        "timestamp": datetime.now().isoformat(),
        "url": url,
        "filename": str(filepath),
        "tags": tags,
        "status": "stub"
    }
    save_to_log(log_entry)
    add_to_queue(filename, url, tags)
    
    # Report
    print(f"✅ Stub saved: {filepath}")
    print(f"   Tags: {tags or '(none)'}")
    print(f"\n🤖 Next step: Hermes will extract content and enrich this stub.")
    print(f"   Or run the extraction manually when ready.")
    
    sys.exit(0)

if __name__ == "__main__":
    main()
