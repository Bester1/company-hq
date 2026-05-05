# PROJECTS
## Single source of project truth

---

### P0 — CRITICAL / BLOCKING

#### 1. Trading Agent Live Deploy
| Field | Value |
|-------|-------|
| Repo | `hyperliquid-trader` (PM2 on Oracle VM) |
| Owner | Frikkie (CTO) + Zeus |
| Status | **DEPLOYED** — fixed bot running (1 instance, PID locked) |
| Next Action | Monitor for 24h, verify no duplicate instances, check TP/SL fills |
| Blockers | None — but 10 old positions remain from pre-fix duplicate runs |
| Notes | **BUGS FIXED:** (1) Duplicate instances prevented by PID lockfile, (2) One-position-per-coin enforced, (3) RiskManager wired, (4) Daily loss circuit breaker active (5%), (5) Server-side position count used. Old positions from bot stacking will close naturally via TP/SL or can be closed manually. PM2 `restart:disabled` (no autorestart, no duplicates). Docker container removed.

#### 2. JobOS Tokenomics Fix
| Field | Value |
|-------|-------|
| Repo | `jobos-tokenomics` (local HTML model) |
| Owner | Hermes (CEO) |
| Status | **DONE** — Scenario 3 approved and modeled |
| Next Action | Hermes: push to Company HQ, update whitepaper |
| Blockers | None |
| Notes | **Final split (100%):** Ops 30%, Stakers 20%, Burn 10%, Referrals 15%, Marketing 15%, Team 10%. LP incentives funded from 950M treasury emissions (NOT revenue). Mandatory token utility required for premium features. Staking APR ~25.8% at 1K users. Annual burn 3.2M tokens (0.65% of circ at 1K users, scales to 32% at 5K). |

---

### P1 — REVENUE RUNWAY

#### 3. Content Studio YT Shorts
| Field | Value |
|-------|-------|
| Repo | `content-studio` (Mission Control server) |
| Owner | THOR (Head of Product) |
| Status | **OPERATIONAL** — needs polish |
| Next Action | THOR: streamline pipeline, test output quality |
| Blockers | None |
| Notes | Uses Composio YouTube toolkit. Auth config `ac_jMwMBkRGgdZ2`. |

#### 4. Mission Control Dashboard Stability
| Field | Value |
|-------|-------|
| Repo | `mission-control-server` |
| Owner | THOR (Head of Product) |
| Status | **OPERATIONAL** — fragile |
| Next Action | THOR: ensure all panels go inside `<main>`, not after `</body>` |
| Blockers | Template rebuilds wipe additions |
| Notes | Dashboard at `https://app.hansa.global`. Token var is `token`. |

---

### P2 — OPERATIONAL

#### 5. Server Auto-Deploy System
| Field | Value |
|-------|-------|
| Repo | `server-auto-deploy-system` |
| Owner | Frikkie (CTO) |
| Status | **OPERATIONAL** — needs hardening |
| Next Action | Frikkie: add health checks, rollback capability |
| Blockers | None |
| Notes | Deploy via base64 chunks over SSH when SCP hangs. Docker: stop→delete __pycache__→start. |

#### 6. Prowash Accounting Dashboard
| Field | Value |
|-------|-------|
| Repo | `prowash-accounting-dashboard` |
| Owner | Hermes (CEO) + THOR |
| Status | **IN DEVELOPMENT** |
| Next Action | Hermes: extract FNB statement data, build dashboard view |
| Blockers | FNB PDF parsing edge cases |
| Notes | Statements in `~/Documents/Prowash/FNB/`. Up to #37. |

---

### P3 — BACKLOG

#### 7. aibiz-cheatsheet
| Field | Value |
|-------|-------|
| Repo | `aibiz-cheatsheet` (NOT CREATED YET) |
| Owner | TBD |
| Status | **BACKLOG** |
| Next Action | Chairman: define purpose (lead magnet? internal reference?) |
| Blockers | Scope undefined |
| Notes | Previous attempt lost in context compression. |

#### 8. Composio Integration Polish
| Field | Value |
|-------|-------|
| Repo | Mission Control server |
| Owner | Frikkie/Zeus |
| Status | **OPERATIONAL** — needs cleanup |
| Next Action | Zeus: remove old INITIALIZING account `ca_xhU_X3edWXQF` |
| Blockers | None |
| Notes | Connected account `ca_ISxf7VkBU2Na` (ACTIVE). Auth config `ac_jMwMBkRGgdZ2`. |

---

*Last updated: Auto-sync.*
