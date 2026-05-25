# DECISIONS
## Log of every strategic call. Dated, signed, final.

---

### 2026-05-25 | Chairman + Hermes
**Topic:** JobOS 1-Person Company restructuring, corrected marketing plan, and bug handoff
**Decision:**
1. **Company structure revised:** Hermes-only execution from macOS. THOR, Frikkie, Zeus remain archived. Single brain, multiple workstreams tracked in Multica.
2. **Marketing plan v2 approved:** Corrected from job-board positioning to trades-business-management positioning. Real competitors: Tradify, Jobber, Housecall Pro (not Indeed, SEEK, Monster).
3. **Tagline locked:** "Stop Losing Money to Admin"
4. **Pricing confirmed:** Free / Standard R249/mo / Premium R349/mo
5. **Budget approved:** R3,500/month for marketing (R2K Meta + R1.5K Google)
6. **Channel priority:** WhatsApp #1, TikTok/IG Reels #2, SEO #3, cold email #4, Facebook Groups #5, YouTube Shorts #6, referrals #7
7. **90-day plan approved:** Phase 1 Foundation (Days 1–30) → Phase 2 Launch (Days 31–60) → Phase 3 Scale (Days 61–90). Targets: 200 free signups Month 1, 10 Std + 2 Prem conversions.
8. **8 Multica issues created for Phase 1** (BES-11 through BES-18). Hermes will execute sequentially starting with BES-11 (WhatsApp) + BES-18 (bug report to Claude Code).
9. **Bug report delivered:** JOBOS-BUGS-FOR-CLAUDE.md with 6 confirmed bugs forwarded to Chairman for handoff to Claude Code team. Fix #1–#3 before new features.
10. **PROJECTS.md updated:** P0 = Product Stability + Marketing Launch. All THOR/Frikkie/Zeus projects archived. Single source of truth maintained.
**Signed:** Hermes (CEO)

---


### 2026-05-24 | Chairman + Hermes
**Topic:** Hermes workspace cleanup — old install purge, prompt bloat fix, streaming speed recovery
**Decision:**
1. Old install at `~/.hermes/hermes-agent-old` archived to `~/.hermes/hermes-agent-old.DEAD.20260524_125145`. Symlink `~/.hermes/hermes-agent` now points to `hermes-agent-new`.
2. All launchd auto-respawn plists unloaded: `ai.hermes.gateway.plist`, `ai.hermes.dashboard.plist`, `ai.hermes.workspace.plist`, `com.hansa.hermes-dashboard.plist`. No zombie restarts.
3. Root cause of 57s chat delay identified: `config.yaml` contained a ~5,000+ character system prompt (Company HQ board persona) plus `toolsets: [hermes-cli]`, inflating every request to ~16k prompt tokens. Ollama cloud proxy (`localhost:11434`) drops oversized streaming requests with `Connection reset by peer`, triggering exponential backoff retries.
4. Patches applied:
   - `hermes_state.py`: skip FTS5 initialization to prevent SQLite crashes under uv Python.
   - `web_server.py`: add `DELETE /api/sessions/{id}/messages` endpoint.
   - `claude-api.ts` line ~370: reverted incorrect `dashboardFetch()` back to `fetch(CLAUDE_API)` — `streamChat` is enhanced-fork-only; portable mode correctly routes via `openaiChat()` → gateway `/v1/chat/completions` on port 8642.
5. Config fix: trimmed `system_prompt` in `~/.hermes/config.yaml` to concise version, removed `hermes-cli` from active toolsets, added to `disabled_toolsets`. Also cleared bloated `personalities` map.
6. Active ports: gateway `localhost:8642`, dashboard `localhost:9119`, workspace dev `localhost:3000`.
7. THOR, Frikkie, Zeus remain offline per user directive (May 2026). Hermes operates solo from macOS workspace.
**Signed:** Hermes (CEO)

---

### 2026-05-06 | Chairman + Hermes
**Topic:** Hyperliquid Trading Analytics Dashboard + Bot Health Check
**Decision:**
1. Built standalone HTML trading dashboard from `trade_history (3).csv` (95 trades, 11 coins, May 4-6). Total PnL +$64.02, Volume $11,797, Win rate 12.6%.
2. Top performers: SUI (+$32.15), OP (+$18.64), WIF (+$16.30). Worst: ARB (-$28.14), TIA (-$8.20), ETH (-$0.45).
3. Dashboard features: KPI cards, balance history line chart, coin PnL bars, daily PnL bars, volume by direction, win rate ring, recent trades table, coin breakdown.
4. Deployed to Mission Control as new Analytics sub-tab via DOM patching (button after Config, iframe panel after hl-sub-config).
5. Bot health verified: `AgentSignal` imports correctly, spot USDC included in balance, RiskManager uses `getattr()` fallbacks, funding rate blocker active, one-position-per-coin enforced, daily loss circuit at 5%. No errors in logs.
6. Dashboard file: `/home/ubuntu/mission-control/app/static/trading_dashboard.html` + copy in `/app/templates/`. Static mount: `/static/` serves from `app/templates/`.
**Signed:** Hermes (CEO)

---

### 2026-05-05 | Chairman + Hermes
**Topic:** Company HQ & persistent memory system
**Decision:** Build shared filesystem + GitHub repo for ground truth. Every agent reads SOUL.md on wake.
**Signed:** Hermes (CEO)

---

### 2026-05-05 | Chairman + Hermes
**Topic:** Board structure
**Decision:** 
- You = Chairman
- Hermes = CEO (strategy, orchestration)
- THOR = Head of Product (dashboard, UI, content)
- Frikkie = CTO (server, deployments)
- Zeus = Senior Engineer (sub-agent under Frikkie)
**Signed:** Hermes (CEO)

---

### 2026-05-05 | Chairman + Hermes
**Topic:** JobOS tokenomics allocation — FINAL
**Decision:** **Scenario 3 approved.** 30% Ops, 20% Stakers, 10% Burn, 15% Referrals, 15% Marketing, 10% Team = 100%. LP incentives funded from 950M treasury token emissions (NOT revenue). Mandatory token utility required for premium features. Staking APR ~25.8% at 1K users, scales attractively. Annual burn 3.2M tokens at 1K users (0.65% circ), 16.1M at 5K users (32% circ). 15% MoM growth model. Source: `/Users/user/jobos-tokenomics/index.html`
**Signed:** Hermes (CEO)

---

### 2026-05-05 | Chairman + Hermes
**Topic:** Priority stack
**Decision:** P0 = Trading agent deploy + tokenomics fix. P1 = Content + dashboard. P2 = Server hardening + Prowash. P3 = Backlog.
**Signed:** Hermes (CEO)

---

### 2026-04-XX | Chairman + Hermes (approximate date)
**Topic:** Server safety protocols
**Decision:** Never rapid-fire SSH (fail2ban risk). Batch commands with &&. Never touch sshd_config, firewall, or system users without permission.
**Signed:** Hermes (CEO)

---

### 2026-04-XX | Chairman + Hermes (approximate date)
**Topic:** THOR/Frikkie lane boundaries
**Decision:** THOR stays in dashboard/UI. Frikkie stays in server/backend. Panels MUST go inside `<main>` tag. JS token var is `token`.
**Signed:** Hermes (CEO)

---

### 2026-04-XX | Chairman + Hermes (approximate date)
**Topic:** Composio YouTube setup
**Decision:** API key `ak_TDwqV_Cc9hXh-Eq3sVEd`. Project `faith4woman` workspace. User_id `faith4woman`. SDK env `COMPOSIO_TOOLKIT_VERSION_YOUTUBE=20260413_01`.
**Signed:** Hermes (CEO)

---

*Add new decisions at the TOP. Do not delete old ones.*
