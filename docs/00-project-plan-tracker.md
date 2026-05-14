# AccessDenied Sec — IAM Lab Project Plan & Progress Tracker

> **Purpose:** Live reference. Check here to see where you are, what's done, and what's next. Update checkboxes as you go.

---

## 🎯 At-a-Glance Status

| Field | Value |
|---|---|
| Project Start Date | _______________ |
| Entra P2 Trial Activated | _______________ |
| Trial Expiry (Day 30) | _______________ |
| Cancel Reminder Date (Day 25) | _______________ |
| Current Phase | Phase 2 (in progress) |
| Days Used | ____ / 30 |

---

## 📋 Phase Status Overview

| Phase | Name | Est. Time | Status |
|---|---|---|---|
| 1 | Foundation Setup | 2 hrs | ✅ Complete |
| 2 | Identity Setup (Users, Groups, RBAC) | 3 hrs | 🔄 In Progress |
| 3 | Authentication Security (MFA, SSPR) | 1.5 hrs | ⏳ Pending |
| 4 | Conditional Access Policies | 3 hrs | ⏳ Pending |
| 5 | Privileged Identity Management (PIM) | 3 hrs | ⏳ Pending |
| 6 | Enterprise Application SSO | 2.5 hrs | ⏳ Pending |
| 7 | Azure Storage + RBAC | 2 hrs | ⏳ Pending |
| 8 | Joiner-Mover-Leaver Lifecycle | 2 hrs | ⏳ Pending |
| 9 | Log Analysis (Sign-in + Audit) | 1.5 hrs | ⏳ Pending |
| 10 | Automation (PowerShell + Graph) | 1.5 hrs | ⏳ Pending |
| 11 | Documentation & Polish | 3–4 hrs | ⏳ Pending |
| 12 | Shutdown & Preservation | 30 min | ⏳ Pending |

**Total estimated active work:** ~26 hours across ~3 weeks

---

## 🗂️ Detailed Phase Breakdowns

### ✅ Phase 1: Foundation Setup

**Goal:** Tenant active, Azure subscription with budget alert, GitHub repo initialized.

- [x] Microsoft account created (`saurav.shinde@gmail.com`)
- [x] Primary Azure subscription reactivated as Pay-As-You-Go
- [x] Basic support plan confirmed (free)
- [x] $10 budget alert configured (50%, 80%, 100%)
- [x] Entra tenant renamed to "AccessDenied Sec"
- [x] Local project folder created (`D:\IAM project\`)
- [x] GitHub repo created (`Sauravshinde01/entra-iam-lab`)
- [x] Git installed and configured with noreply email
- [x] `.gitignore` configured (protects passwords.txt)
- [x] First commit pushed to GitHub

**Screenshots:**
- ✅ Active Azure subscription
- ✅ Budget alerts configuration
- ✅ Entra Overview
- ✅ IAM lab budget detail

---

### 🔄 Phase 2: Identity Setup

**Goal:** 10 users, 5 security groups (1 dynamic), 1 directly-assigned admin role.

#### Users (10 total) — ✅ Complete
- [x] Aaron IT-Admin (IT)
- [x] Bella Helpdesk (IT)
- [x] Carlos HR-Lead (HR)
- [x] Diana HR-Specialist (HR)
- [x] Ethan Finance-Lead (Finance)
- [x] Fiona Finance-Analyst (Finance)
- [x] Grace Employee (Sales)
- [x] Henry Employee (Marketing)
- [x] Ivy Contractor (External)
- [x] Jack Contractor (External — JML demo subject)

#### Entra ID P2 Trial Activation — 🔄 In Progress
- [ ] P2 trial activated (free, 30 days)
- [ ] Day 25 cancellation reminder set in calendar
- [ ] P2 license assigned to admin (Saurav Shinde)
- [ ] P2 license assigned to Aaron IT-Admin
- [ ] P2 license assigned to Carlos HR-Lead
- [ ] P2 license assigned to Diana HR-Specialist
- [ ] PIM blade verified accessible

#### Security Groups (5 total) — ⏳ Pending
- [ ] GRP-IT (Assigned — Aaron, Bella)
- [ ] GRP-Finance (Assigned — Ethan, Fiona)
- [ ] **GRP-HR (Dynamic — rule: `user.department -eq "HR"`)** ⭐
- [ ] GRP-Contractors (Assigned — Ivy, Jack)
- [ ] GRP-AllEmployees (Assigned — 8 internal users)

#### Role Assignment — ⏳ Pending
- [ ] Bella Helpdesk → Helpdesk Administrator (Active, Permanent)

#### Screenshots Pending
- [ ] P2 trial active in licenses page
- [ ] GRP-HR dynamic rule configuration
- [ ] GRP-HR auto-populated members (Carlos, Diana)
- [ ] All Groups list
- [ ] Helpdesk Admin role assignment

---

### ⏳ Phase 3: Authentication Security

**Goal:** MFA and SSPR configured at the tenant level.

- [ ] Enable Microsoft Authenticator
- [ ] Enable SMS as backup
- [ ] Configure SSPR (require 2 methods)

**Screenshots:**
- [ ] Authentication methods configuration
- [ ] SSPR settings

**Note:** Phase 3 configures *which methods are available*. Phase 4 enforces *when MFA is required* (Conditional Access). This is the modern split — not per-user MFA.

---

### ⏳ Phase 4: Conditional Access Policies (4 policies)

**Goal:** 4 production-grade CA policies, started in Report-only mode.

- [ ] Create break-glass account (excluded from all policies)
- [ ] **CA01:** Require MFA for all users
- [ ] **CA02:** Require MFA for admin directory roles
- [ ] **CA03:** Block legacy authentication
- [ ] **CA04:** Block sign-in from outside the US (named location)

For each policy:
- [ ] Started in Report-only mode
- [ ] Sign-in logs reviewed
- [ ] Switched to On after verification
- [ ] Screenshot captured
- [ ] Writeup added to `policies/` folder

---

### ⏳ Phase 5: Privileged Identity Management (PIM) ⭐ HEADLINE

**Goal:** PIM configured for Entra + Azure roles, full activation flow demonstrated.

#### Entra Role via PIM
- [ ] Convert Aaron to **Eligible** Global Administrator
- [ ] Role settings: 4hr max activation, MFA required, justification required
- [ ] Sign in as Aaron → activate the role
- [ ] Capture activation flow (3–4 screenshots)
- [ ] Run access review on the eligible role

#### Azure Role via PIM
- [ ] Eligible Storage Blob Data Reader on Resource Group

**Screenshots:**
- [ ] Eligible assignments page
- [ ] Role settings configuration
- [ ] Activation request screen
- [ ] MFA prompt during activation
- [ ] Active assignment confirmation
- [ ] Access review setup

---

### ⏳ Phase 6: Enterprise Application with SSO

**Goal:** One SaaS app integrated via SAML SSO, scoped to a group.

- [ ] Pick app from Entra Gallery (recommendation: GitHub)
- [ ] Configure SAML-based SSO
- [ ] Assign GRP-IT to application
- [ ] Test sign-in via myapps.microsoft.com as Bella (IT)
- [ ] Test denied access as Finance user

---

### ⏳ Phase 7: Azure Storage + RBAC

**Goal:** Demonstrate cloud RBAC using identity-bound roles on Azure resources.

- [ ] Create Resource Group: `rg-iam-lab`
- [ ] Create Storage Account (Standard LRS)
- [ ] Create blob container, upload sample file
- [ ] Assign GRP-Finance the `Storage Blob Data Reader` role
- [ ] Assign Aaron's PIM-eligible Storage role at RG scope
- [ ] Test: Fiona can read blob, Diana cannot

---

### ⏳ Phase 8: Joiner-Mover-Leaver Lifecycle

**Goal:** Full lifecycle simulation on one user (Jack Contractor).

- [ ] Joiner: onboarding steps documented
- [ ] Mover: Jack moved from Contractors to IT
- [ ] Leaver: Jack offboarded properly

---

### ⏳ Phase 9: Log Analysis

**Goal:** Demonstrate ability to investigate identity activity using logs.

- [ ] Sign-in log: successful MFA-protected sign-in
- [ ] Sign-in log: blocked sign-in
- [ ] Sign-in log: CA policy evaluation visible
- [ ] Audit log: PIM activation event
- [ ] Audit log: group membership change
- [ ] Write "Findings" section (SOC analyst perspective)

---

### ⏳ Phase 10: Light Automation

- [ ] Script 1: List all users + licenses → CSV export
- [ ] Script 2: List GRP-IT members → CSV export
- [ ] Scripts committed to `scripts/` folder

---

### ⏳ Phase 11: Documentation & Polish

- [ ] Architecture diagram (draw.io)
- [ ] Final polished README.md
- [ ] Per-phase markdown docs in `docs/`
- [ ] Resume bullets drafted
- [ ] Interview narrative (STAR format)

---

### ⏳ Phase 12: Shutdown & Preservation

- [ ] All commits pushed to GitHub
- [ ] CA policy JSON exported to `policies/` folder
- [ ] **CANCEL P2 TRIAL** before Day 30
- [ ] Storage account deleted (optional)
- [ ] Tenant kept active on Free tier

---

## 🔑 Key Reference Info

| Field | Value |
|---|---|
| Tenant | `Sauravshindegmail.onmicrosoft.com` |
| Tenant Display Name | AccessDenied Sec |
| Subscription | Azure subscription 1 (Pay-As-You-Go) |
| Support Plan | Basic (free) |
| GitHub Repo | `github.com/Sauravshinde01/entra-iam-lab` |
| Local Path | `D:\IAM project\` |
| Budget Alert | $10 monthly |

---

## 📅 Suggested Cadence (Mixed Pace)

- **Light day:** 1 hour → 1 small task
- **Medium day:** 2 hours → complete a small phase
- **Heavy day:** 3+ hours → big phase (e.g., PIM walkthrough)

**Target:** Finish core work by Day 21. Days 22–30 = polish + buffer.

---

## 🛠️ Troubleshooting Log

Use this section to note any issues you hit and how you solved them. This becomes valuable interview content.

| Date | Issue | Resolution |
|---|---|---|
| | | |
| | | |

---

*Last updated: [update each time you make progress]*