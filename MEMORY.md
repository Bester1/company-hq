# 3-TIER AGENT MEMORY SYSTEM
## Every agent knows what every other agent is doing. Nothing gets lost.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│  TIER 1 — EPHEMERAL (Session Memory)                            │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│  │   HERMES    │  │    THOR     │  │  FRIKKIE    │             │
│  │  (You + Me) │  │  (macOS)    │  │  (Oracle)   │             │
│  └──────┬──────┘  └──────┬──────┘  └──────┬──────┘             │
│         │                │                │                     │
│         └────────────────┴────────────────┘                     │
│                      │                                          │
│         Auto-snapshot every 10 min ──────┐                      │
│                                          ▼                      │
├───────────────────────────────────────────────────────────────┤
│  TIER 2 — WORKING (Unified Project Memory)                    │
│  SQLite @ /home/ubuntu/shared-context/memory.db               │
│  Auto-export to .md every 5 min                               │
│  ┌────────────────────────────────────────┐                   │
│  │  agents        │ active tasks            │                   │
│  │  projects      │ blockers                │                   │
│  │  decisions     │ heartbeats              │                   │
│  │  events        │ cross-agent pings       │                   │
│  └────────────────────────────────────────┘                   │
│         │                                                       │
│         └───── Git commit every 30 min ─────┐                 │
│                                             ▼                  │
├───────────────────────────────────────────────────────────────┤
│  TIER 3 — GROUND TRUTH (GitHub / Permanent)                     │
│  github.com/Bester1/company-hq                                 │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐         │
│  │   SOUL.md    │  │ PROJECTS.md  │  │ DECISIONS.md │         │
│  │   MEMORY.md  │  │  AGENTS.md   │  │   SYNC.sh    │         │
│  └──────────────┘  └──────────────┘  └──────────────┘         │
│                                                                 │
│  Every agent reads this on wake. Survives everything.          │
└─────────────────────────────────────────────────────────────────┘
```

---

## Tier 1 — Ephemeral (Session)

**What:** Active conversation context, scratchpad, temporary reasoning.
**Lifetime:** Current session only.
**Storage:** In-memory / context window.
**Who writes:** The agent in the active session.
**Backup:** Auto-snapshot to Tier 2 every 10 minutes or on key decisions.

**Content:**
- Current task being worked on
- Files currently open/edited
- Decisions made this session
- Errors encountered and fixes applied
- User corrections ("don't do that again")

---

## Tier 2 — Working (Unified Project Memory)

**What:** The shared state of the company right now.
**Lifetime:** Persistent (SQLite on disk).
**Storage:** `/home/ubuntu/shared-context/memory.db` (server) + auto-exported `.md` files.
**Who writes:** ALL agents write their own status. ALL agents read everyone else's.

### Tables

| Table | Purpose | Written By |
|-------|---------|-----------|
| `agents` | Who's active, what lane, last seen | Each agent on heartbeat |
| `tasks` | Active tasks, priorities, blockers | Agent who owns the task |
| `events` | What happened (deploys, fixes, decisions) | Any agent |
| `pings` | Cross-agent messages ("THOR review this PR") | Any agent |
| `project_state` | Current deploy status, health checks | Frikkie/Zeus |
| `memory_export` | Auto-generated markdown snapshots | Cron job |

### Auto-Export
Every 5 minutes, Tier 2 exports to:
- `/home/ubuntu/shared-context/agent_status_auto.md`
- `/home/ubuntu/shared-context/active_tasks_auto.md`
- `/home/ubuntu/shared-context/timeline_auto.md`

Every 30 minutes, these get committed to Tier 3 (GitHub) via cron.

---

## Tier 3 — Ground Truth (GitHub)

**What:** Immutable record of who we are, what we decided, what's in flight.
**Lifetime:** Forever. Git history.
**Storage:** `github.com/Bester1/company-hq`
**Who writes:** Hermes (CEO) for decisions. Frikkie for deploy records. Auto-sync from Tier 2.

**Files:**
| File | Purpose | Updated By |
|------|---------|-----------|
| `SOUL.md` | Board structure, rules, current mission | Hermes |
| `PROJECTS.md` | P0/P1/P2 project truth | Hermes |
| `DECISIONS.md` | Dated, signed decisions | Hermes |
| `AGENTS.md` | Agent specs, wake protocols | Hermes |
| `MEMORY.md` | This file — memory architecture | Hermes |
| `SYNC.sh` | Sync script to push to GitHub | Auto / Hermes |

---

## Agent Wake Protocol (Every Agent, Every Session)

```
1. Read SOUL.md     → Know the rules, know the mission
2. Read PROJECTS.md → Know what's P0/P1/P2
3. Read DECISIONS.md → Know what was decided (last 5)
4. Read MEMORY.md   → Know how memory works
5. Query Tier 2     → sqlite3 memory.db "SELECT * FROM agents;"
                     → See who's active, what they're doing
6. Query Tier 2     → sqlite3 memory.db "SELECT * FROM tasks WHERE status='in_progress';"
                     → See what's currently being worked on
7. Check pings      → sqlite3 memory.db "SELECT * FROM pings WHERE target='ME' AND read=0;"
                     → See if anyone needs me
8. DO THE WORK
9. Write heartbeat → sqlite3 memory.db "UPDATE agents SET last_seen=NOW(), current_task='...' WHERE name='ME';"
10. If key decision → Append to DECISIONS.md + git commit + push
```

---

## How Cross-Agent Communication Works

**Example: THOR needs Frikkie to deploy something**

1. THOR writes to Tier 2:
   ```sql
   INSERT INTO pings (from_agent, to_agent, message, urgency, created_at)
   VALUES ('thor', 'frikkie', 'Deploy content-studio v2.3 to production', 'urgent', datetime('now'));
   ```

2. Frikkie's next heartbeat (every 5 min) reads pings:
   ```sql
   SELECT * FROM pings WHERE to_agent='frikkie' AND read=0;
   ```

3. Frikkie acts, then marks read:
   ```sql
   UPDATE pings SET read=1, resolved_at=datetime('now') WHERE id=...;
   ```

4. Both agents' work is logged in `events` table.
5. Auto-export writes it to `.md`.
6. Git commit pushes to Tier 3.
7. Next agent wake sees the full chain.

---

## Implementation Status

| Component | Status | Path |
|-----------|--------|------|
| Schema | ✅ Done | `~/Documents/Company/memory-schema.sql` |
| SQLite DB | ✅ Done | `/home/ubuntu/shared-context/memory.db` |
| Auto-export | ✅ Done | Cron every 5 min |
| Git sync | ⬜ Next | Cron every 30 min to Company HQ |
| Agent wake scripts | ⬜ Next | Per-agent `.sh` in `~/company/wake/` |
| Hermes integration | ⬜ Next | Auto-write DECISIONS.md on key calls |

---

*Created: 2026-05-07*
*Authority: Hermes (CEO)*
*Next update: After deployment verification*
