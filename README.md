# Entra ID IAM Lab — AccessDenied Sec

A hands-on Microsoft Entra ID lab simulating enterprise Identity and Access Management (IAM) operations for a fictional company called **AccessDenied Sec**. Built to demonstrate SC-300 domain competencies to potential employers, then extended to cover non-human identity (NHI) governance.

> **Certification:** Microsoft SC-300 — Identity and Access Administrator Associate (March 2026)
> **Tenant:** `Sauravshindegmail.onmicrosoft.com`
> **Subscription:** Azure Pay-As-You-Go
> **Core Lab Period:** May–June 2026 (Phases 1–12) | **Extension:** July 2026 (Phase 13+)
> **Total Cost:** < $0.01
> **Instagram:** [@accessdeniedsec](https://instagram.com/accessdeniedsec)

---

## Architecture Overview

![IAM Lab Architecture](docs/architecture-diagram.png)

*Diagram covers Phases 1–12 (human identity lifecycle). Phase 13's non-human identity flow (app registration → federated credential → GitHub Actions OIDC → Azure RBAC; managed identity → Automation Account → RBAC) is described in `docs/13-nhi-governance.md` pending an architecture diagram update.*

---

## What This Lab Demonstrates

This project simulates the IAM responsibilities of an Identity Engineer or SOC Analyst in a real enterprise environment — from initial tenant setup through conditional access enforcement, privileged identity management, SSO integration, Azure RBAC, identity lifecycle governance, log-based security analysis, PowerShell automation via Microsoft Graph, controlled resource decommission, and — as of Phase 13 — non-human identity (NHI) governance for AI/automation workloads.

All configurations are hands-on in a live Entra ID tenant with real users, groups, policies, and audit evidence.

---

## Lab Phases

| # | Phase | Status |
|---|-------|--------|
| 1 | Tenant & Environment Setup | ✅ Complete |
| 2 | Users, Groups & RBAC | ✅ Complete |
| 3 | Authentication Security | ✅ Complete |
| 4 | Conditional Access Policies | ✅ Complete |
| 5 | Privileged Identity Management (PIM) | ✅ Complete |
| 6 | Enterprise SSO (GitHub SAML) | ✅ Complete |
| 7 | Azure RBAC & Resource Access | ✅ Complete |
| 8 | Joiner-Mover-Leaver Lifecycle | ✅ Complete |
| 9 | Log Analysis & SOC-Style Findings | ✅ Complete |
| 10 | Automation (PowerShell + Graph) | ✅ Complete |
| 11 | Documentation Polish | ✅ Complete |
| 12 | Shutdown & Decommission | ✅ Complete |
| 13 | Non-Human Identity (NHI) Governance | ✅ Complete |
| 14 | Agent-to-Tool Authorization (MCP Governance) | 🔲 Proposed |

---

## Phase Highlights

### Phase 1–3 — Foundation
Built the enterprise environment from scratch: tenant configuration, fictional company structure (AccessDenied Sec), user personas across Finance, IT, HR, and Helpdesk departments, dynamic security groups with membership rules, and admin role segregation.

### Phase 4 — Conditional Access
Disabled Security Defaults and implemented four enforced CA policies:
- **CA01** — Require MFA for all users
- **CA02** — Require MFA for admin roles
- **CA03** — Block legacy authentication
- **CA04** — Geo-restrict contractor accounts to U.S. only

Configured a break-glass account excluded via dedicated exclusion group, following Microsoft's emergency access best practices.

### Phase 5 — Privileged Identity Management (PIM)
Converted Global Administrator to an eligible Just-in-Time (JIT) role for Aaron IT-Admin — requiring Azure MFA, justification, and manager approval for activation (4-hour max window). Configured quarterly access reviews and demonstrated Eligible role assignment for Azure Storage Blob Data Reader.

### Phase 6 — Enterprise SSO
Configured SAML-based Single Sign-On for GitHub Enterprise Cloud. Assigned access via GRP-IT group. Validated app visibility differences between IT and Finance users — demonstrating group-based application access control.

### Phase 7 — Azure RBAC
Created resource group `rg-iam-lab`, storage account `stiamlabsaurav`, and blob container `iam-lab-data`. Assigned GRP-Finance both Reader (management plane) and Storage Blob Data Reader (data plane). Validated access with Fiona (Finance, granted) and Diana (HR, denied). Resolved the Entra Global Admin ≠ Azure RBAC access prerequisite issue.

### Phase 8 — Joiner-Mover-Leaver Lifecycle
Simulated a complete identity lifecycle using Jack Contractor as the subject:
- **Joiner:** Onboarded with appropriate department, title, and group (GRP-Contractors)
- **Mover:** Transitioned to IT Support Specialist — profile updated, removed from GRP-Contractors, added to GRP-IT, verified automatic GitHub SSO access inheritance
- **Leaver:** Account disabled, all sessions revoked, removed from all groups — full audit trail confirmed

### Phase 9 — Log Analysis & SOC-Style Findings
Reviewed sign-in and audit logs across the last 7 days and produced three structured SOC analyst findings:
- **Finding 1 (Medium):** MFA registration gap for Fiona Finance-Analyst — CA01 intercepted sign-in, user completed registration within 11 minutes, access restored
- **Finding 2 (Informational):** Ethan Finance-Lead authenticated successfully via My Apps portal — all four CA policies evaluated correctly
- **Finding 3 (Informational):** Jack Contractor leaver sequence confirmed in audit logs — account disable, session token invalidation, and group removal all recorded with timestamps

### Phase 10 — Automation (PowerShell + Microsoft Graph)
Connected to the Entra ID tenant via Microsoft Graph PowerShell SDK v2.37.0 and built two automation scripts:
- **Script 1:** Export all tenant users with IAM attributes to CSV (13 users — confirmed Jack's disabled account)
- **Script 2:** Export GRP-IT members to CSV (2 members — confirmed Jack's absence post-offboarding)

### Phase 11 — Documentation Polish
Created a professional architecture diagram covering all IAM layers. Updated README with full project narrative, fixed repository structure rendering, and polished all phase documentation for portfolio presentation.

### Phase 12 — Shutdown & Decommission
Performed controlled decommission of all lab resources:
- Microsoft Entra ID P2 Trial cancelled
- Azure resource group `rg-iam-lab` and storage account `stiamlabsaurav` deleted
- All resources confirmed empty
- Final cost: **< $0.01 USD** for the entire lab

### Phase 13 — Non-Human Identity (NHI) Governance
Extended the lab beyond human identity lifecycle to cover the fastest-growing category of enterprise identity risk — non-human identities (NHIs) — using an app registration and a system-assigned managed identity:
- **App registration** (`AccessDenied-Workload-Automation`) secured with **GitHub Actions OIDC federation** — zero secrets stored anywhere, authenticated via short-lived federated tokens
- **System-assigned managed identity** (via Azure Automation Account) granted least-privilege **Storage Blob Data Reader**, scoped to a single storage account
- Diagnosed and resolved a real-world RBAC gotcha: an app registration object and its corresponding service principal are distinct objects — federation trust and RBAC assignment must each target the correct one
- Confirmed both identities in **Microsoft Entra Workload ID**'s inventory (109 workload identities tenant-wide)
- Ran entirely on **Entra ID Free tier** — no premium licensing required
- Cleanly decommissioned all temporary Azure resources; app registration deliberately preserved as the foundation for Phase 14
- Total cost: **$0.00**

---

## Repository Structure

```
entra-iam-lab/
├── README.md
├── .github/
│   └── workflows/
│       └── azure-oidc-auth.yml
├── docs/
│   ├── 00-project-plan-tracker.md
│   ├── 01-project-overview.md
│   ├── 02-users-plan.md
│   ├── 03-authentication-security.md
│   ├── 04-break-glass-account.md
│   ├── 05-conditional-access-policies.md
│   ├── 06-pim-privileged-identity-management.md
│   ├── 07-enterprise-sso.md
│   ├── 08-azure-rbac.md
│   ├── 09-jml-lifecycle.md
│   ├── 10-log-analysis.md
│   ├── 11-automation-scripts.md
│   ├── 12-shutdown.md
│   ├── 13-nhi-governance.md
│   └── architecture-diagram.png
├── scripts/
│   ├── 01-export-users.ps1
│   ├── 02-export-grp-it-members.ps1
│   ├── users-export.csv
│   └── grp-it-members-export.csv
└── screenshots/
    ├── 01-foundation/
    ├── 02-identity/
    ├── 03-authentication/
    ├── 04-conditional-access/
    ├── 05-pim/
    ├── 06-enterprise-sso/
    ├── 07-azure-rbac/
    ├── 08-jml-lifecycle/
    ├── 09-log-analysis/
    ├── 10-automation/
    ├── 12-shutdown/
    └── 13-nhi-governance/
```
---

## Key Technical Concepts Demonstrated

- Microsoft Entra ID tenant configuration (P2 trial and Free tier)
- Conditional Access policy design and enforcement
- Just-in-Time privileged access via PIM
- SAML 2.0 SSO integration with third-party apps
- Azure RBAC — management plane vs. data plane access
- Identity lifecycle governance (Joiner-Mover-Leaver)
- Sign-in log analysis and CA policy validation
- Audit log review and SOC-style findings documentation
- Break-glass account design and emergency access hygiene
- Microsoft Graph PowerShell automation and CSV reporting
- Controlled cloud resource decommission and cost management
- **Non-human identity (NHI) governance** — app registrations, service principals, and managed identities
- **Secretless authentication** via OpenID Connect (OIDC) federation for CI/CD
- **Microsoft Entra Workload ID** inventory and governance
- App registration vs. service principal authorization boundaries

---

## Environment

| Setting | Value |
|---------|-------|
| Tenant | Sauravshindegmail.onmicrosoft.com |
| Tenant Name | AccessDenied Sec |
| Subscription | Azure Pay-As-You-Go |
| Entra ID License | Free tier (P2 trial cancelled after Phase 12; Phase 13 confirmed Free tier is sufficient for NHI/Workload ID governance) |
| Working Admin Account | Saurav.shinde@gmail.com (Global Administrator) |
| Resource Group | rg-iam-lab (recreated in Phase 13, deleted again in Phase 13 shutdown) |
| Preserved Non-Human Identity | AccessDenied-Workload-Automation (app registration, retained for Phase 14) |
| Total Lab Cost | < $0.01 USD |

---

*This lab is for educational and portfolio purposes. All users, groups, and scenarios are fictional.*
