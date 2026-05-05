# DECISIONS
## Log of every strategic call. Dated, signed, final.

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
