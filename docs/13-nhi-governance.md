# Phase 13 — Non-Human Identity (NHI) Governance
**Project:** AccessDenied Sec — Entra ID IAM Lab
**Date:** July 2026
**Author:** Saurav Shinde

---

## Overview

Phases 1–12 covered the full human identity lifecycle — but explicitly scoped out app registrations, service principals, and managed identities. This phase closes that gap. Non-human identities (NHIs) now outnumber human identities by a wide margin in most enterprise environments, and governing them — who they are, what they can touch, and how access is revoked — is one of the fastest-growing areas of IAM work in 2026.

This phase extends the same governance discipline already applied to Aaron, Bella, Carlos, etc. to non-human principals: an app registration, a system-assigned managed identity, and a federated (secretless) GitHub Actions integration.

**Cost:** $0 — built entirely on Microsoft Entra ID Free tier plus a temporary Azure resource group (deleted at phase close). No Microsoft Entra ID P2, Copilot Studio, or Microsoft Agent 365 required.

**Scope note:** Phase 12 (Shutdown) had already deleted the original `rg-iam-lab` resource group and `stiamlabsaurav` storage account from Phases 1–12. This phase recreated minimal versions of both to serve as the RBAC target, then decommissioned them again at phase close — same resource hygiene discipline as Phase 12.

---

## Goal

By the end of this phase:
- An app registration exists as a non-human identity, secured with GitHub Actions OIDC federation — zero stored secrets
- A separate system-assigned managed identity (via an Automation Account) holds least-privilege RBAC access to a storage account
- Both identities are visible and inventoried in Microsoft Entra Workload ID
- The distinction between an *app registration* and its corresponding *service principal* is demonstrated concretely — not just conceptually
- All temporary Azure resources are cleanly decommissioned, while the app registration is deliberately preserved for Phase 14

---

## Sub-steps

### 13.1 — App registration

Registered a new app in Entra ID: **AccessDenied-Workload-Automation**, single-tenant, no redirect URI.

- Application (client) ID: `ff6e16fb-4b2e-4fae-9748-107da2095c60`
- Object ID (app registration object): `7c65f557-093d-4783-8540-d989e9902468`
- Directory (tenant) ID: `4af7eb5a-74c3-44a6-8dcd-757e8f2d9f49`

**Screenshot:** `01-app-registration-overview.png`

### 13.2 — Resource group + storage account (recreated)

Recreated `rg-iam-lab` (South Central US) and `stiamlabsaurav` (Standard, LRS) to serve as the RBAC target for this phase, since Phase 12 had deleted the originals. Same names reused for narrative continuity — Azure had not reserved them.

**Screenshot:** `02-resource-group-storage-created.png`

### 13.3 — Automation Account with system-assigned managed identity

Created `aa-iam-lab-automation` with **System assigned identity: On** at creation time — no secrets to store or rotate; Azure manages the credential lifecycle automatically.

- Managed identity Object (principal) ID: `4e2ce790-87fe-4cba-8883-0ff5f771b713`

**Screenshot:** `03-automation-account-created.png`, `04-automation-identity-enabled.png`

### 13.4 — RBAC assignment (managed identity → storage account)

Assigned the managed identity **Storage Blob Data Reader**, scoped to `stiamlabsaurav` only (not inherited from the resource group). Same RBAC mechanic as Phase 7 — the principal is non-human this time.

**Screenshot:** `05-managed-identity-rbac-assignment.png`

### 13.5 — GitHub Actions OIDC federation

Configured a federated credential on the app registration (not the automation account):

- Scenario: GitHub Actions deploying Azure resources
- Organization: `Sauravshinde01`
- Repository: `entra-iam-lab`
- Entity type: Branch — `main`
- Subject identifier (auto-generated): `repo:Sauravshinde01/entra-iam-lab:ref:refs/heads/main`
- Credential name: `github-actions-main-oidc`

Added `.github/workflows/azure-oidc-auth.yml` to the repo, using `azure/login@v2` with `client-id`, `tenant-id`, and `subscription-id` — no client secret anywhere in the workflow or GitHub Secrets.

**Screenshot:** `06-federated-credential-config.png`

**Troubleshooting — a key finding of this phase:**
The first two workflow runs failed with `No subscriptions found for ***`, even though the OIDC trust itself was correctly configured and the token exchange succeeded. Root cause: the **app registration object** and its corresponding **enterprise application (service principal)** are two distinct objects in Entra ID. Federation trust is configured on the app registration, but RBAC assignment for the login must go to the *service principal* — a completely separate Object ID (`2fde361d-d2e4-4f02-9285-eec06920523f`) from the app registration's own Object ID.

Fix: granted the service principal (`AccessDenied-Workload-Automation`, Type: App) the **Reader** role, scoped to `rg-iam-lab`. Workflow succeeded on the next run.

**Lesson for interviews:** OIDC federation proves *who you are* (authentication). RBAC assignment proves *what you're allowed to do* (authorization). They are independent layers, and both must be configured against the correct object — a distinction that's easy to get wrong on a first pass.

**Screenshot:** `07-github-actions-oidc-success.png`

### 13.6 — Workload ID inventory confirmation

Confirmed both non-human identities appear in **Entra ID → Workload identities**:
- 109 total workload identities tenant-wide (105 Microsoft first-party apps, 3 enterprise apps/service principals including this phase's app, 1 managed identity)
- Confirmed Conditional Access / Identity Protection / Access Reviews for workload identities are gated behind Microsoft Entra Workload ID Premium — intentionally not purchased for this phase (Free tier sufficient for the governance story being demonstrated)

**Screenshot:** `08-workload-id-inventory.png`

### 13.7 — Decommission

Deleted `rg-iam-lab` (cascading deletion removed `aa-iam-lab-automation`, its two auto-generated runbooks, and `stiamlabsaurav` in a single operation — same method as Phase 12).

**Deliberately preserved:** the `AccessDenied-Workload-Automation` app registration and its federated credential, as the foundation for Phase 14 (Agent-to-Tool Authorization / MCP Governance).

**Screenshot:** `09-resource-group-deletion-confirmed.png`, `10-azure-resources-empty.png`

---

## Verification

- ✅ Managed identity authenticated with zero stored credentials
- ✅ GitHub Actions authenticated via OIDC with zero stored secrets in the repo or GitHub Secrets
- ✅ Both identities correctly scoped (least privilege, not over-permissioned)
- ✅ Both identities visible in Workload ID inventory
- ✅ Temporary Azure resources fully decommissioned; app registration intentionally retained for Phase 14
- ✅ Total cost: $0

## Git workflow

```
git add .
git commit -m "Phase 13 complete: Non-Human Identity governance (Workload ID + GitHub OIDC federation)"
git push origin main
```

## Resume bullet (draft)

> Extended IAM lab to non-human identity governance: implemented Microsoft Entra Workload ID with a system-assigned managed identity for least-privilege Azure RBAC, and OIDC-based federated authentication for GitHub Actions CI/CD — eliminating stored credentials while correctly distinguishing app registration vs. service principal authorization boundaries.

---

*Phase 13 complete. See `docs/00-project-plan-tracker.md` for updated overall status.*
