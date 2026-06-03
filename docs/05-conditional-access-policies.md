# Phase 4: Conditional Access Policies

**Status:** Complete  
**Date Completed:** June 3, 2026  
**Time Invested:** ~3 hours  

## Overview

Implemented four Conditional Access policies establishing the 
enforcement layer for AccessDenied Sec tenant. Phase 3 defined 
WHICH authentication methods exist; Phase 4 defines WHEN and 
HOW they are enforced.

All policies follow the enterprise safe-deployment pattern:
created in Report-only mode for validation, then promoted to On.
All policies exclude GRP-BreakGlass-Exclusion to preserve 
emergency tenant recovery capability.

---

## Security Defaults Migration

Before CA policies could be created, Security Defaults was 
disabled with reason: "My organization is planning to use 
Conditional Access." This is the standard migration path from 
Microsoft's baseline protection to custom policy governance.

**Operational note:** In production, this transition would be 
scheduled during a maintenance window with CA policies 
pre-staged in Report-only mode, then promoted to On immediately 
to minimize the unprotected window.

---

## Named Locations

| Name | Type | Purpose |
|---|---|---|
| United States | Countries (IP) | Reference location for CA04 geo-restriction |

---

## Policy Inventory

| Policy | Target | Grant | State |
|---|---|---|---|
| CA01 - Require MFA for All Users | All users | Require MFA | On |
| CA02 - Require MFA for Admin Roles | 6 directory roles | Require MFA | On |
| CA03 - Block Legacy Authentication | All users | Block access | On |
| CA04 - Geo-Restrict Contractors | GRP-Contractors | Block access | On |

---

## CA01 - Require MFA for All Users

### Purpose
Baseline MFA enforcement for all interactive sign-ins. Single 
most impactful identity security control — blocks the majority 
of automated credential attacks.

### Configuration
- **Users include:** All users
- **Users exclude:** GRP-BreakGlass-Exclusion
- **Target resources:** All resources
- **Conditions:** None (universal)
- **Grant:** Require multifactor authentication
- **Deployment:** Report-only → validated via sign-in logs → On

### Design Rationale
Universal MFA with no app or location exceptions ensures no 
gaps in coverage. Break-glass exclusion via dedicated group 
rather than individual account exclusion — cleaner audit trail 
and easier to manage as tenant grows.

### Validation
- Report-only sign-in log showed: **Report-only: Success**
- After switching to On: MFA prompt appeared on admin sign-in
- Number matching (80) displayed — confirming Phase 3 
  anti-phishing configuration is active end-to-end
- Post-enforcement sign-in log showed: **Success** in 
  Conditional access tab (not Report only tab)

---

## CA02 - Require MFA for Admin Roles

### Purpose
Dedicated MFA enforcement for privileged directory roles, 
independent of CA01. Acts as backstop if CA01 is ever modified 
and provides a separate audit trail for admin sign-ins.

### Configuration
- **Users include:** Directory roles:
  - Global Administrator
  - Security Administrator
  - Helpdesk Administrator
  - User Administrator
  - Authentication Administrator
  - Global Reader
- **Users exclude:** GRP-BreakGlass-Exclusion
- **Target resources:** All resources
- **Conditions:** None
- **Grant:** Require multifactor authentication
- **Deployment:** Report-only → On (compressed — CA01 already 
  active as safety net)

### Design Rationale
Separating admin MFA into its own policy enables future 
tightening (e.g., require phishing-resistant MFA for Global 
Admins only) without touching the user baseline. Also provides 
cleaner sign-in log separation between user and admin events.

### Note on Role Selection
Two roles from initial planning (Conditional Access 
Administrator, Privileged Role Administrator) were not found 
under those exact names in this tenant's role picker. Six 
confirmed roles were selected covering the highest-impact 
administrative functions. Role naming varies by tenant 
configuration and Microsoft UI version.

---

## CA03 - Block Legacy Authentication

### Purpose
Block legacy authentication protocols (Exchange ActiveSync, 
SMTP basic auth, POP3, IMAP, other legacy clients) which 
cannot perform MFA challenges — closing a critical gap where 
attackers could bypass MFA entirely using older protocols.

### Configuration
- **Users include:** All users
- **Users exclude:** GRP-BreakGlass-Exclusion
- **Target resources:** All resources
- **Conditions — Client apps:**
  - ✅ Exchange ActiveSync clients (legacy)
  - ✅ Other clients (legacy)
  - ❌ Browser (modern — not blocked)
  - ❌ Mobile apps and desktop clients (modern — not blocked)
- **Grant:** Block access
- **Deployment:** Report-only → On

### Design Rationale
Targeting only legacy protocol client types ensures modern 
authentication (browser, Outlook with modern auth, Teams) is 
unaffected. Block access rather than Require MFA because legacy 
protocols cannot complete MFA challenges — requiring MFA would 
simply cause those sign-ins to fail anyway, so Block is cleaner.

### Production Note
In a production environment with existing legacy mail clients, 
this policy would be left in Report-only for 1-2 weeks to 
identify affected users before enforcement. For this lab with 
no legacy clients configured, Report-only validation was 
compressed.

---

## CA04 - Geo-Restrict Contractors

### Purpose
Block sign-ins from outside the United States for contractor 
accounts specifically. Demonstrates context-aware, 
group-targeted access policy — different rules for different 
user populations based on trust level and business need.

### Configuration
- **Users include:** GRP-Contractors (Ivy Contractor, 
  Jack Contractor)
- **Users exclude:** GRP-BreakGlass-Exclusion
- **Target resources:** All resources
- **Network/Location:**
  - Include: Any network or location
  - Exclude: United States (Named Location)
- **Grant:** Block access
- **Deployment:** Report-only → On

### Design Rationale
Contractors represent higher-risk identities — external, 
project-based, potentially accessing from varied locations. 
Geo-restriction to US aligns with AccessDenied Sec's fictional 
operational scope. Group targeting (GRP-Contractors) keeps 
this restriction isolated from internal employees.

### Operational Note
No lockout warning appeared during creation — confirming the 
group targeting is correctly scoped. Admin account is not a 
member of GRP-Contractors, so the policy correctly identified 
zero admin impact.

---

## Deployment Pattern Summary

All four policies followed the enterprise safe-deployment 
lifecycle:
Create in Report-only
↓
Validate via sign-in logs
↓
Promote to On
↓
Monitor for unexpected impact
CA01 received full report-only validation via sign-in log 
review. CA02-CA04 were promoted faster due to CA01 already 
serving as the active safety net and/or limited lab sign-in 
volume for meaningful report-only data.

---

## Break-Glass Exclusion Pattern

All four policies exclude GRP-BreakGlass-Exclusion. This group 
contains a single dedicated break-glass account 
(breakglass@Sauravshindegmail.onmicrosoft.com) with Global 
Administrator role. Excluding via group rather than individual 
account ensures new break-glass accounts can be added without 
modifying each policy individually.

See docs/04-break-glass-account.md for full break-glass 
documentation.

---

## Reference Screenshots

| File | Content |
|---|---|
| 04-ca-overview-before.png | CA overview before any policies |
| 04a-security-defaults-disabled.png | Security defaults migration |
| 05-ca01-users-exclude-config.png | CA01 exclude configuration |
| 06-ca01-created-report-only.png | CA01 in report-only state |
| 07-ca01-report-only-success.png | Report-only validation |
| 08-ca01-enabled-on.png | CA01 promoted to On |
| 09-ca01-mfa-prompt.png | MFA enforcement proof |
| 10-ca01-enforced-signin-log.png | Post-enforcement sign-in log |
| 11-ca02-both-policies-on.png | CA01 + CA02 enforcing |
| 12-ca03-client-apps-condition.png | Legacy auth targeting config |
| 14-named-location-us.png | United States named location |
| 17-all-four-policies-mixed.png | All policies pre-final state |
| 18-all-four-policies-on.png | All four policies enforcing |

## What's Next

Phase 5: Privileged Identity Management (PIM) — just-in-time 
admin elevation with approval workflows for Aaron IT-Admin.