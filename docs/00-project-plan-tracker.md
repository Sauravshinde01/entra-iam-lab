# Project Plan Tracker — AccessDenied Sec IAM Lab

**Current Phase:** Phase 13 Complete — Extension in progress (Phase 14 proposed) 🔄
**Last Updated:** July 2026
**Overall Status:** ✅ Core lab (Phases 1–12) complete | 🔄 Extension phases in progress

---

## Phase Status Overview

| Phase | Name | Status | Est. Time | Notes |
|---|---|---|---|---|
| 1 | Foundation | ✅ Complete | 1 hr | Tenant, Azure, Git, budget |
| 2 | Identity Setup | ✅ Complete | 1.5 hr | Users, groups, P2, roles |
| 3 | Authentication Security | ✅ Complete | 1.5 hr | Auth methods, SSPR, MFA |
| 4 | Conditional Access | ✅ Complete | 3 hr | 4 CA policies, break-glass |
| 5 | PIM | ✅ Complete | 2 hr | JIT elevation, access review |
| 6 | Enterprise App SSO | ✅ Complete | 1.5 hr | GitHub SAML SSO |
| 7 | Azure RBAC | ✅ Complete | 1.5 hr | Storage + group-based RBAC |
| 8 | JML Lifecycle | ✅ Complete | 1 hr | Jack as demo subject |
| 9 | Log Analysis | ✅ Complete | 1 hr | Sign-in + audit log review |
| 10 | Automation | ✅ Complete | 1.5 hr | PowerShell + Graph scripts |
| 11 | Documentation Polish | ✅ Complete | 1 hr | Architecture diagram, README |
| 12 | Shutdown | ✅ Complete | 30 min | Cancel P2, delete resources |
| 13 | NHI Governance | ✅ Complete | ~2.5 hr | Workload ID, managed identity, GitHub OIDC federation |
| 14 | Agent-to-Tool Authorization (MCP) | 🔲 Proposed | ~3 hr (est.) | Scoping pass required before starting |

---

## ✅ Phase 1: Foundation

- [x] Tenant created (AccessDenied Sec)
- [x] Azure subscription activated (Pay-As-You-Go)
- [x] Budget alert configured ($10/month, 50/80/100%)
- [x] GitHub repo created and initialized
- [x] Git configured with noreply email
- [x] .gitignore protecting sensitive files
- [x] README.md initialized

---

## ✅ Phase 2: Identity Setup

- [x] 10 users created across 6 departments
- [x] 5 security groups created
- [x] GRP-HR configured as Dynamic group (department rule)
- [x] Helpdesk Administrator role assigned to Bella
- [x] P2 trial activated (100 licenses)
- [x] P2 assigned to Saurav Admin, Aaron, Carlos, Diana
- [x] Documentation: 02-users-plan.md

---

## ✅ Phase 3: Authentication Security

- [x] Microsoft Authenticator enabled (number matching, geo, app name)
- [x] SMS enabled as backup
- [x] Voice call and Email OTP disabled
- [x] SSPR enabled for all users (2 methods required)
- [x] Forced registration policy active
- [x] Admin MFA registered (Authenticator + SMS backup)
- [x] Policy validated via Carlos test sign-in
- [x] Documentation: 03-authentication-security.md

---

## ✅ Phase 4: Conditional Access

- [x] Break-glass account created (breakglass@...)
- [x] GRP-BreakGlass-Exclusion group created
- [x] Break-glass sign-in tested and validated
- [x] Security Defaults disabled (CA migration)
- [x] Named Location created (United States)
- [x] CA01: Require MFA for All Users → On
- [x] CA02: Require MFA for Admin Roles → On
- [x] CA03: Block Legacy Authentication → On
- [x] CA04: Geo-Restrict Contractors → On
- [x] Report-only validation completed for CA01
- [x] MFA number matching confirmed via sign-in prompt
- [x] Documentation: 04-break-glass-account.md
- [x] Documentation: 05-conditional-access-policies.md

---

## ✅ Phase 5: Privileged Identity Management (PIM)

- [x] PIM blade verified accessible (P2 license active)
- [x] Aaron IT-Admin configured as Eligible Global Administrator
- [x] Role settings: 4hr max activation, Azure MFA required, justification required
- [x] Aaron MFA registered (Microsoft Authenticator)
- [x] JIT elevation tested — Aaron activated Global Admin via PIM
- [x] Activation confirmed on Active assignments tab (4hr window)
- [x] Access review created (AR-GlobalAdmin-Quarterly-Review, status: Active)
- [x] Troubleshooting documented: "Unknown error" on activation (backend succeeded despite UI error)
- [x] Azure RBAC via PIM: Aaron assigned Eligible Storage Blob Data Reader on rg-iam-lab
- [x] Documentation: 06-pim-privileged-identity-management.md

---

## ✅ Phase 6: Enterprise App SSO

- [x] GitHub Enterprise Cloud - Organization added from Entra gallery
- [x] SAML SSO configured (Entity ID, ACS URL, Sign-on URL)
- [x] GRP-IT assigned to the application
- [x] Bella (IT) validated — GitHub tile visible in My Apps
- [x] Ethan (Finance) validated — GitHub tile not visible in My Apps
- [x] Documentation: 07-enterprise-sso.md

---

## ✅ Phase 7: Azure RBAC

- [x] Resource group created (rg-iam-lab, South Central US)
- [x] Admin subscription permissions resolved (Owner role assigned)
- [x] Storage account created (stiamlabsaurav, Standard LRS)
- [x] Blob container created (iam-lab-data, Private)
- [x] Sample file uploaded (sample-data.txt)
- [x] GRP-Finance assigned Reader on rg-iam-lab (management plane)
- [x] GRP-Finance assigned Storage Blob Data Reader on iam-lab-data (data plane)
- [x] Fiona (Finance) validated — blob access confirmed via Entra auth
- [x] Diana (HR) validated — access denied at management plane
- [x] Documentation: 08-azure-rbac.md

---

## ✅ Phase 8: JML Lifecycle

- [x] Joiner: Jack's onboarded baseline documented (External, GRP-Contractors)
- [x] Mover: Profile updated (IT Support Specialist, IT department)
- [x] Mover: Removed from GRP-Contractors, added to GRP-IT
- [x] Mover: Verified automatic app inheritance (GitHub SSO via GRP-IT)
- [x] Leaver: Account disabled (block sign-in)
- [x] Leaver: All sessions revoked
- [x] Leaver: Removed from all groups (zero memberships)
- [x] Documentation: 09-jml-lifecycle.md
---

## ✅ Phase 9: Log Analysis & SOC-Style Findings
- [x] Sign-in logs reviewed — Last 7 days, interactive user sign-ins
- [x] Finding 1: Fiona MFA registration gap — CA01 Failure → Success (11-min gap documented)
- [x] Finding 2: Ethan normal MFA-compliant sign-in via My Apps — verified
- [x] Audit logs reviewed — Last 7 days, Directory category
- [x] Finding 3: Jack leaver sequence confirmed in audit trail (disable → revoke → remove)
- [x] Documentation: 10-log-analysis.md
---

## ✅ Phase 10: Automation

- [x] Installed Microsoft Graph PowerShell SDK (Authentication, Users, Groups modules v2.37.0)
- [x] Connected to Entra tenant via delegated auth (admin@Sauravshindegmail.onmicrosoft.com)
- [x] PowerShell script: Export all users to CSV (13 users, all fields verified)
- [x] PowerShell script: Export GRP-IT members to CSV (2 members, Jack absence confirmed)
- [x] Scripts tested and output verified in Excel
- [x] Documentation: 11-automation-scripts.md
---

## ✅ Phase 11: Documentation Polish

- [x] Architecture diagram created (draw.io) and exported as PNG
- [x] Architecture diagram added to docs/ and embedded in README
- [x] README updated with architecture overview, Phase 10 highlights, correct repository structure
- [x] Duplicate 02-users-plan.md removed from repo root
- [x] Repository structure section fixed (code block rendering on GitHub)
- [x] All docs reviewed for consistency
- [x] GitHub repo polished for portfolio presentation
---

## ✅ Phase 12: Shutdown

- [x] Microsoft Entra ID P2 Trial cancelled (status: Disabled)
- [x] Azure resource group rg-iam-lab deleted
- [x] Azure storage account stiamlabsaurav deleted
- [x] Azure All Resources confirmed empty
- [x] Final cost confirmed: < $0.01 USD
- [x] Documentation: 12-shutdown.md
---

## ✅ Phase 13: Non-Human Identity (NHI) Governance

- [x] App registration created: AccessDenied-Workload-Automation
- [x] Resource group + storage account recreated (rg-iam-lab, stiamlabsaurav) — originals deleted in Phase 12
- [x] Automation Account created with system-assigned managed identity (aa-iam-lab-automation)
- [x] Managed identity assigned Storage Blob Data Reader, scoped to storage account only
- [x] GitHub Actions OIDC federated credential configured (Sauravshinde01/entra-iam-lab, branch: main)
- [x] `.github/workflows/azure-oidc-auth.yml` added — secretless Azure login from CI/CD
- [x] Troubleshot and resolved: app registration object vs. service principal RBAC distinction
- [x] Service principal granted Reader role on rg-iam-lab — workflow succeeded
- [x] Workload ID inventory confirmed (109 total identities tenant-wide)
- [x] Resource group deleted (cascading) — automation account, storage account, runbooks all removed
- [x] App registration deliberately preserved for Phase 14
- [x] Total cost: $0.00
- [x] Documentation: 13-nhi-governance.md

---

## 🔲 Phase 14: Agent-to-Tool Authorization (MCP Governance) — Proposed

- [ ] Scoping pass: verify current free/self-hosted MCP server options compatible with Entra ID OIDC auth
- [ ] Stand up tool endpoint (MCP server or mock API)
- [ ] Authenticate Phase 13 agent identity to the tool endpoint (reuse federated credential — no new secrets)
- [ ] Define and document scoped, least-privilege tool permissions
- [ ] Route agent-to-tool access logs into a reviewable log/SIEM view
- [ ] Test revocation — confirm tool access fails immediately after credential pulled
- [ ] Cost verification required before starting (target: $0)
- [ ] Documentation: 14-agent-tool-authorization.md (not yet created)

---

## Key Reference Info

| Item | Value |
|---|---|
| Tenant | Sauravshindegmail.onmicrosoft.com |
| Tenant display name | AccessDenied Sec |
| Working admin account | Saurav.shinde@gmail.com (Global Administrator — confirmed working, Phase 13) |
| Native admin (legacy reference) | admin@Sauravshindegmail.onmicrosoft.com |
| GitHub repo | github.com/Sauravshinde01/entra-iam-lab |
| Local path | D:\IAM project\ |
| Entra ID license (current) | Free tier — P2 trial expired/cancelled after Phase 12 |
| Azure subscription | Pay-As-You-Go |
| Budget alert | $10/month |
| Phase 13 app registration (preserved) | AccessDenied-Workload-Automation — client ID `ff6e16fb-4b2e-4fae-9748-107da2095c60` |

---

## Notes on Licensing (Phase 13+)

The original Entra ID P2 trial (Phase 2) was cancelled as part of Phase 12 shutdown. Phase 13 confirmed that Microsoft Entra Agent ID and Workload ID's core discovery/inventory features work on the **Free tier** — no reactivation needed. A second P2 trial was evaluated (would require payment details and auto-converts to paid after 1 month) and deliberately **not activated** — not required for the governance story being demonstrated. Conditional Access and Identity Protection for workload identities/agents remain P1/P2-gated and are out of scope unless a future phase specifically requires them.
