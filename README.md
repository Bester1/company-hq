# Company HQ
## Persistent shared memory for all agents

This repository is the **single source of truth** for our agent workforce.
It survives context compression, machine restarts, and everything else.

## Files

| File | Purpose |
|------|---------|
| `SOUL.md` | Ground truth: roles, rules, mission, infrastructure |
| `PROJECTS.md` | All projects with status, owner, next action |
| `DECISIONS.md` | Dated log of every strategic call |
| `AGENTS.md` | Agent specs, constraints, wake protocols |
| `SYNC.sh` | One-button push to GitHub + mirror to server |

## For Agents (Wake Protocol)

1. Read `SOUL.md`
2. Read `PROJECTS.md`
3. Read `DECISIONS.md` (last 5 entries)
4. Execute your assigned tasks

## For Chairman (Human)

Run `./SYNC.sh` after any significant change.
Or tell Hermes to sync for you.

## Locations

- **macOS Laptop:** `~/Documents/Company/`
- **Oracle VM:** `/home/ubuntu/company/`
- **GitHub:** `Bester1/company-hq`

---

*Built to survive. Updated continuously. Never lost again.*
