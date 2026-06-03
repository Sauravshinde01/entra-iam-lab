# Project Plan Tracker — AccessDenied Sec IAM Lab

**Last Updated:** June 3, 2026  
**Current Phase:** Phase 5 — Privileged Identity Management (PIM)  
**Overall Status:** 🔄 In Progress

---

## Phase Status Overview

| Phase | Name | Status | Est. Time | Notes |
|---|---|---|---|---|
| 1 | Foundation | ✅ Complete | 1 hr | Tenant, Azure, Git, budget |
| 2 | Identity Setup | ✅ Complete | 1.5 hr | Users, groups, P2, roles |
| 3 | Authentication Security | ✅ Complete | 1.5 hr | Auth methods, SSPR, MFA |
| 4 | Conditional Access | ✅ Complete | 3 hr | 4 CA policies, break-glass |
| 5 | PIM | 🔄 In Progress | 2 hr | JIT elevation for Aaron |
| 6 | Enterprise App SSO | ⏳ Pending | 1.5 hr | GitHub SAML SSO |
| 7 | Azure RBAC | ⏳ Pending | 1.5 hr | Storage + group-based RBAC |
| 8 | JML Lifecycle | ⏳ Pending | 1 hr | Jack as demo subject |
| 9 | Log Analysis | ⏳ Pending | 1 hr | Sign-in + audit log review |
| 10 | Automation | ⏳ Pending | 1.5 hr | PowerShell + Graph scripts |
| 11 | Documentation Polish | ⏳ Pending | 1 hr | Architecture diagram, README |
| 12 | Shutdown | ⏳ Pending | 30 min | Cancel P2, delete resources |

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

## 🔄 Phase 5: Privileged Identity Management (PIM)

- [ ] PIM enabled for the tenant
- [ ] Aaron IT-Admin configured as eligible Global Administrator
- [ ] Activation settings configured (justification, MFA, time limit)
- [ ] JIT elevation tested (Aaron activates Global Admin role)
- [ ] Activation request and approval workflow documented
- [ ] PIM audit log reviewed
- [ ] Documentation: 06-pim-configuration.md

---

## ⏳ Phase 6: Enterprise App SSO

- [ ] GitHub registered as enterprise application
- [ ] SAML SSO configured
- [ ] Test user SSO sign-in validated
- [ ] Documentation: 07-enterprise-sso.md

---

## ⏳ Phase 7: Azure RBAC

- [ ] Resource group created (rg-iam-lab)
- [ ] Storage account created
- [ ] GRP-Finance assigned Storage Blob Data Reader role
- [ ] RBAC tested with Finance user
- [ ] Documentation: 08-azure-rbac.md

---

## ⏳ Phase 8: JML Lifecycle

- [ ] Joiner scenario demonstrated (new hire onboarding)
- [ ] Mover scenario demonstrated (Jack moves department)
- [ ] Leaver scenario demonstrated (Jack offboarded)
- [ ] Documentation: 09-jml-lifecycle.md

---

## ⏳ Phase 9: Log Analysis

- [ ] Sign-in logs reviewed and documented
- [ ] Audit logs reviewed and documented
- [ ] SOC-style findings written up
- [ ] Documentation: 10-log-analysis.md

---

## ⏳ Phase 10: Automation

- [ ] PowerShell script: Export users + licenses to CSV
- [ ] PowerShell script: Export GRP-IT members to CSV
- [ ] Scripts tested and output verified
- [ ] Documentation: 11-automation-scripts.md

---

## ⏳ Phase 11: Documentation Polish

- [ ] Architecture diagram created (draw.io)
- [ ] README updated with final project summary
- [ ] All docs reviewed for consistency
- [ ] GitHub repo polished for portfolio presentation

---

## ⏳ Phase 12: Shutdown

- [ ] P2 trial cancelled before Day 30
- [ ] Azure storage resources deleted
- [ ] Tenant left on free tier
- [ ] Final cost check ($0 remaining)

---

## Key Reference Info

| Item | Value |
|---|---|
| Tenant | Sauravshindegmail.onmicrosoft.com |
| Tenant display name | AccessDenied Sec |
| Native admin | admin@Sauravshindegmail.onmicrosoft.com |
| GitHub repo | github.com/Sauravshinde01/entra-iam-lab |
| Local path | D:\IAM project\ |
| P2 trial activated | ~May 15, 2026 (expires ~June 14, 2026) |
| Azure subscription | Pay-As-You-Go |
| Budget alert | $10/month |

---

## P2 Trial Deadline ⚠️

**Cancel before:** ~June 14, 2026  
Cancel via M365 Admin Center → Billing → Your products  
Failure to cancel = $9/user/month charge on payment card