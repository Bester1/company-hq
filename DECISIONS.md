# DECISIONS
## Log of every strategic call. Dated, signed, final.

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
