# Cloud Identity & Access Management Implementation Using Microsoft Entra ID and Azure

**A hands-on, SC-300 aligned IAM lab project**

---

## 📌 At a Glance

| | |
|---|---|
| **Project Name** | AccessDenied Sec — Cloud IAM Implementation |
| **Author** | Saurav Shinde |
| **Project Type** | Personal portfolio / certification-aligned learning lab |
| **Alignment** | Microsoft SC-300: Identity and Access Administrator |
| **Cloud Platform** | Microsoft Entra ID (formerly Azure AD) + Microsoft Azure |
| **Duration** | ~3 weeks active build |
| **Repository** | github.com/Sauravshinde01/entra-iam-lab |
| **Related Content** | instagram.com/accessdeniedsec — IAM learning content |

---

## 🎯 Project Objective

Design and implement a secure, cloud-based Identity and Access Management environment using Microsoft Entra ID and Azure that demonstrates enterprise-grade identity controls including authentication, authorization, privileged access management, conditional access, identity lifecycle, and monitoring.

The lab simulates a fictional company — "AccessDenied Sec" — with realistic departmental structure (HR, Finance, IT, Sales, Marketing, Contractors) and produces documented, screenshot-backed evidence of every implemented control.

---

## 💡 Why This Project Exists

Modern organizations face significant identity-driven security challenges:

- **Identity-based attacks** — phishing, credential theft, and account takeover are the #1 attack vector
- **Excessive standing privileges** — admins with permanent elevated access create persistent risk
- **Weak authentication** — single-factor authentication is no longer sufficient
- **Lack of access visibility** — without proper logging and review, anomalies go undetected
- **Manual lifecycle gaps** — onboarding/offboarding errors leave access dangling

This project addresses each of these by implementing:

- ✅ **Strong authentication** via Multi-Factor Authentication (MFA)
- ✅ **Just-In-Time admin access** via Privileged Identity Management (PIM)
- ✅ **Context-aware enforcement** via Conditional Access policies
- ✅ **Least-privilege access** via Role-Based Access Control (RBAC)
- ✅ **Automated lifecycle** via dynamic group membership
- ✅ **Auditability** via sign-in and audit log review

---

## 🏗️ What Is Being Built

A complete simulated enterprise IAM environment, scoped tightly enough to finish in 3 weeks but deep enough to demonstrate every major Entra ID capability covered in SC-300.

### High-Level Components

1. **Identity Foundation** — 10 fictional users across 6 departments, 5 security groups including one dynamic group, and a custom-branded tenant ("AccessDenied Sec").
2. **Authentication Layer** — Modern authentication methods (Microsoft Authenticator + SMS), Self-Service Password Reset (SSPR), and a break-glass account for emergency access.
3. **Authorization Layer** — Both directly-assigned roles (Helpdesk Administrator) and PIM-managed eligible roles (Global Administrator), demonstrating when each pattern applies.
4. **Policy Layer** — Four Conditional Access policies covering MFA enforcement, admin protection, legacy authentication block, and geo-restriction. All deployed via Report-only mode first.
5. **Application Layer** — One enterprise SaaS application integrated via SAML SSO, with group-based access scoping.
6. **Cloud Resource Layer** — One Azure Storage Account demonstrating identity-bound RBAC on a real Azure resource, with both group-based and PIM-eligible role assignments.
7. **Governance Layer** — Full Joiner-Mover-Leaver lifecycle simulation, plus access reviews on PIM-eligible roles.
8. **Monitoring Layer** — Sign-in log and audit log analysis with documented findings from a SOC analyst's perspective.
9. **Automation Layer** — Two Microsoft Graph PowerShell scripts demonstrating programmatic identity management.

---

## 🛠️ Tools & Technologies

### Core Platform
- **Microsoft Entra ID** (Entra ID P2 trial — 30 days free)
- **Microsoft Azure** (Pay-As-You-Go subscription)
- **Azure Portal** + **Microsoft Entra admin center**

### Identity Features Implemented
- Conditional Access
- Multi-Factor Authentication (MFA)
- Self-Service Password Reset (SSPR)
- Role-Based Access Control (RBAC)
- Privileged Identity Management (PIM)
- Dynamic group membership
- Enterprise Applications with SAML SSO
- Access Reviews

### Monitoring & Automation
- Microsoft Entra Sign-in Logs
- Microsoft Entra Audit Logs
- Microsoft Graph PowerShell SDK
- Azure Cloud Shell

### Documentation & Version Control
- GitHub (public repository for portfolio visibility)
- Git (commit history demonstrates project discipline)
- VS Code (documentation editing)
- Markdown (all documentation)
- draw.io / diagrams.net (architecture diagrams)

---

## 🎯 Project Goals

By the end of this project, the following will be true:

### Technical Capability Goals
1. A fully configured Entra ID environment with structured users, groups, and policies enforcing real security controls.
2. PIM configured for both directory roles and Azure resource roles with documented activation flow.
3. Four production-quality Conditional Access policies in active enforcement.
4. One enterprise application integrated via SSO with group-scoped access.
5. Azure resource (Storage Account) demonstrating cloud RBAC tied to Entra identities.

### Portfolio & Career Goals
1. A public GitHub repository with clean commit history, comprehensive documentation, and 25+ annotated screenshots.
2. A professional README with architecture diagram, SC-300 topic mapping, and key learnings.
3. Resume-ready bullet points showcasing specific implemented controls.
4. Interview-ready STAR-format narrative covering the full project.
5. Demonstrable understanding of why each control exists, not just how to configure it.

### Learning Goals
1. Internalize the difference between authentication methods (Phase 3) and access policies (Phase 4).
2. Understand the contrast between standing role assignments and just-in-time elevation via PIM.
3. Develop muscle memory for the Entra admin center navigation and configuration patterns.
4. Build confidence to discuss identity controls in SOC Analyst, IAM Engineer, or Security Engineer interviews.

---

## 🔐 Security Design Principles Applied

This lab is built on widely-recognized identity security principles:

| Principle | How It's Applied |
|---|---|
| **Least Privilege** | RBAC roles scoped tightly; no permanent Global Admin |
| **Zero Trust** | Verify explicitly via Conditional Access on every sign-in |
| **Just-In-Time Access** | PIM activation for elevated roles |
| **Defense in Depth** | MFA + CA + geo-restriction + audit logging layered |
| **Strong Authentication** | MFA enforced via CA, not optional |
| **Context-Aware Access** | Location, role, device factors evaluated |
| **Identity Governance** | Lifecycle controls and access reviews |
| **Auditability** | Every action logged and reviewable |

---

## 📐 Scope

### In Scope
- Entra ID tenant configuration end-to-end
- 10 fictional users across 6 departments
- 5 security groups (1 dynamic, 4 assigned)
- MFA, SSPR, and Conditional Access
- PIM for both Entra and Azure roles
- One SaaS application via SAML SSO
- Joiner-Mover-Leaver lifecycle simulation
- One Azure Storage Account demonstrating cloud RBAC
- Sign-in and audit log analysis
- Two Graph PowerShell automation scripts
- Full GitHub documentation with architecture diagram

### Out of Scope (intentional to keep tight)
- Hybrid identity (Entra Connect / on-prem AD sync)
- Multiple enterprise applications
- Microsoft Sentinel / Defender for Cloud integration
- Production-scale deployment
- Identity Protection deep dive (referenced conceptually)
- Custom application registration / OAuth scopes
- API access reviews

---

## 📊 SC-300 Exam Domain Coverage

This project aligns with all four SC-300 exam domains:

| SC-300 Domain | Project Phases |
|---|---|
| Implement identities in Entra ID | Phase 2 |
| Implement authentication and access management | Phases 3, 4 |
| Implement access management for applications | Phase 6 |
| Plan and implement identity governance | Phases 5, 8 |

(Plus supporting work in Phases 7, 9, 10 for Azure RBAC, monitoring, and automation.)

---

## 💰 Cost Estimate

| Item | Cost |
|---|---|
| Entra ID P2 trial (30 days) | $0 |
| Azure Pay-As-You-Go subscription | $0 base |
| Azure Storage Account (minimal usage) | < $1 |
| GitHub (public repository) | $0 |
| draw.io, VS Code, Git | $0 |
| **Total** | **< $1** |

Budget alert configured at $10 to catch unexpected charges. P2 trial canceled before Day 30 to avoid auto-billing.

---

## 📅 Timeline

- **Week 1:** Foundation, identity setup, authentication, Conditional Access
- **Week 2:** PIM, SSO, Azure RBAC
- **Week 3:** Lifecycle, log analysis, automation, documentation

Pace is flexible (mixed-availability schedule) but bounded by the 30-day P2 trial window.

---

## 🚀 Deliverables

When complete, this project produces:

1. **GitHub repository** — public, well-documented, with clean commit history
2. **Architecture diagram** — visual overview of the IAM design
3. **25+ annotated screenshots** — proof of every implemented control
4. **Per-phase documentation** — markdown docs explaining the *why* behind each implementation choice
5. **Conditional Access policy library** — exported JSON for all 4 policies
6. **PowerShell automation scripts** — committed and documented
7. **Resume bullets** — 4–5 concise statements ready to paste into a resume
8. **Interview narrative** — STAR-format walkthrough usable in technical interviews
9. **SC-300 topic mapping** — table showing which exam domain each phase covers

---

## 🙋 About the Author

Saurav Shinde — actively building IAM and cybersecurity skills toward SOC Analyst and IAM Engineer roles. This lab is part of a broader "building in public" approach, also documented on Instagram @accessdeniedsec.

**Why this project?** Theoretical SC-300 knowledge from study guides is useful, but hands-on implementation experience is what hiring managers actually look for. This project bridges that gap by combining real configuration work with thorough documentation of decisions and trade-offs.

---

*This document is a living overview. See `00-project-plan-tracker.md` for live progress tracking, and the main README.md for the project's quick-pitch summary.*