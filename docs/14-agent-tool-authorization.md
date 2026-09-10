# Phase 14 — Agent-to-Tool Authorization (Governance Layer)
**Project:** AccessDenied Sec — Entra ID IAM Lab
**Date:** September 2026
**Author:** Saurav Shinde

---

## Overview

Phase 13 gave a non-human identity its own credentials and proved *who* an agent is (authentication). Phase 14 addresses the next layer: governing *what* an agent is allowed to do once it has authenticated (authorization), recording every action it takes, and being able to revoke its access on demand.

This is the core problem of AI agent governance in 2026: agents increasingly call external tools and APIs to take real actions, and each of those calls is an authorization boundary that must be controlled, logged, and revocable — especially in regulated environments like healthcare (HIPAA), where you must be able to prove after the fact exactly which identity did what.

This phase builds a working governance layer that sits in front of a tool and enforces four properties: scoped authorization, policy-as-code, immutable audit logging, and immediate revocation.

**Cost:** $0 — built and run entirely locally in Python.

## Scope and honest framing

This phase implements the **agent-to-tool authorization pattern that MCP (Model Context Protocol) uses**, against a purpose-built tool endpoint rather than a full production MCP server. The governance layer — scoped access, policy-as-code, immutable logging, revocation — is the substance of the phase and is fully real. The tool it governs is intentionally simple so the focus stays on the governance, not the plumbing.

A commercial MCP governance platform (DVARA) was evaluated during scoping. Its MCP-governance and policy-as-code capabilities sit behind an enterprise license aimed at company deployments, so a self-built governance layer was chosen instead — keeping the project fully owned, $0, and focused on demonstrating the concepts directly.

**Note on agent identity:** in this lab the calling agent identifies itself via an `x-agent-id` header, to keep the focus on the *authorization* logic. In a production system this identity would be carried by a verified, signed token (the OIDC federation pattern built in Phase 13), so the authentication and authorization layers would connect end to end.

---

## Goal

By the end of this phase, the governance layer demonstrably enforces:
1. **Scoped access** — an agent can perform only its explicitly allowed actions, nothing else
2. **Policy-as-code** — the authorization rules live in a separate, readable, version-controlled file, not buried in application logic
3. **Immutable audit logging** — every decision (allowed and denied) is recorded append-only, tied to the agent, action, and timestamp
4. **Immediate revocation** — pulling an agent's access takes effect on the very next request, with no restart or redeploy

---

## What was built

A small **FastAPI** application (`main.py`) acting as an "inventory tool" with two actions:
- `read_inventory` (GET) — a read action
- `write_inventory` (POST) — a write action

A **policy-as-code file** (`policy.yaml`) defining what each agent may do. A **governance check** in the application reads this policy on every request and allows or blocks the call. Every decision is written to an **append-only audit log** (`audit.log`).

**Tech stack:** Python 3.12, FastAPI, uvicorn, PyYAML. Dependencies pinned in `requirements.txt`.

---

## Sub-steps

### 14.1 — Build the tool endpoint
Built a FastAPI app exposing `read_inventory` (GET) and `write_inventory` (POST) against an in-memory inventory list. At this stage both actions were open — no restrictions — establishing the "before governance" baseline.
**Screenshot:** `01-tool-endpoint-docs.png`

### 14.2 — Write the policy-as-code file
Created `policy.yaml` defining one agent, `inventory-reader-agent`, with `read_inventory` in its `allowed_actions` and `write_inventory` denied. The rules live in a readable file, separate from the enforcement code — anyone can see what the agent may do without reading application logic.

### 14.3 — Add the governance check
Added a `check_authorization` function that reads the policy and, on each call: allows the action if it is in the agent's `allowed_actions`, denies with **403 Forbidden** if not, and denies any agent not listed in the policy. Enforcement was verified with three tests:
- Allowed read (`inventory-reader-agent` → read) → **200**
- Denied write (`inventory-reader-agent` → write) → **403**
- Unknown agent (`random-hacker-agent` → read) → **403**

**Screenshots:** `02` through `07`

### 14.4 — Add immutable logging
Added `write_audit_log`, which appends one structured JSON line per decision to `audit.log` — capturing UTC timestamp, agent, action, decision, and reason. Written in append-only mode so entries can never be silently edited or deleted. Both allowed and denied calls are logged; denied attempts are especially valuable, as they record an agent trying to do something it should not.
**Screenshot:** `08-audit-log-entries.png`

### 14.5 — Immediate revocation test
Changed the governance check to re-read `policy.yaml` on every request, so policy changes take effect instantly. Then ran the revocation proof:
1. `inventory-reader-agent` → read → **200** (access working)
2. Edited `policy.yaml` to `allowed_actions: []` (revoked), saved — no server restart
3. Same agent, same request → **403 Forbidden** (access pulled immediately)

The audit log captured the full lifecycle in one trail — the same agent ALLOWED then DENIED for the identical action, with the policy change in between.
**Screenshots:** `09-revocation-before-200.png`, `10-policy-revoked.png`, `11-revocation-after-403.png`, `12-audit-log-full-lifecycle.png`

*(Note: re-reading the policy file on every request is done for clarity of the immediate-revocation demonstration. At production scale this would be cached and refreshed on change for performance; the concept demonstrated is identical.)*

### 14.6 — Documentation and commit
After the test, `policy.yaml` was restored to its normal working state (agent allowed to read) so the committed repo shows the policy in a sensible default; the revocation is evidenced through the screenshots and this document.

---

## Verification

- ✅ Scoped: agent can read, cannot write, unknown agents get nothing
- ✅ Policy-as-code: rules in a separate, readable, version-controlled `policy.yaml`
- ✅ Immutable logging: every decision recorded append-only with timestamp and identity
- ✅ Immediate revocation: access pulled took effect on the very next request, no restart
- ✅ Total cost: $0

## Files in this phase

```
phase14-agent-governance/
├── main.py            # FastAPI tool + governance check + audit logging
├── policy.yaml        # policy-as-code: what each agent may do
├── audit.log          # sample immutable audit trail (evidence)
└── requirements.txt   # pinned dependencies
```

## Git workflow

```
git add .
git commit -m "Phase 14 complete: agent-to-tool authorization governance layer (policy-as-code, immutable audit, immediate revocation)"
git push origin main
```

## Resume bullet (draft)

> Built an agent-to-tool authorization governance layer in Python/FastAPI implementing the MCP authorization pattern: scoped least-privilege access driven by policy-as-code, append-only immutable audit logging of every allow/deny decision, and verified immediate credential revocation — the controls required to govern AI agents in regulated (e.g. HIPAA) environments.

---

## What this phase demonstrates for interviews

- The distinction between **authentication** (Phase 13 — proving identity) and **authorization** (Phase 14 — controlling what an identity may do), and why both are needed
- **Policy-as-code** as a reviewable, version-controlled alternative to permissions hardcoded in application logic
- **Immutable audit logging** as both a compliance requirement and a detection mechanism (denied attempts are recorded, not just successful actions)
- **On-demand revocation** and why immediacy matters — the ability to answer "can you kill an agent's access right now" with a working demonstration

---

*Phase 14 complete. See `docs/00-project-plan-tracker.md` for overall status.*
