# Phase 9 — Log Analysis & SOC-Style Findings
**Project:** AccessDenied Sec — Entra ID IAM Lab  
**Tenant:** Sauravshindegmail.onmicrosoft.com  
**Analyst:** Saurav Shinde  
**Log Review Period:** 2026-06-02 to 2026-06-09 (Last 7 Days)  
**Date of Analysis:** 2026-06-09  
**Tools Used:** Microsoft Entra Admin Center — Sign-in logs (Traffic logs Preview), Audit logs

---

## Overview

This document captures sign-in and audit log evidence collected from the AccessDenied Sec Entra ID tenant as part of Phase 9 of the IAM lab. Findings are written in a SOC analyst style — each finding includes an observation, supporting log evidence, risk assessment, and recommended or confirmed remediation action.

Log sources reviewed:
- User sign-ins (interactive) — Last 7 days
- Audit logs (Directory) — Last 7 days

---

## Sign-In Log Findings

### Finding 1 — MFA Registration Gap Triggered CA01 Enforcement for Finance User

**Severity:** Medium  
**Status:** Resolved (self-remediated)

**Observation:**  
On 2026-06-06 at 06:53:30 UTC, a sign-in attempt by fiona.financeanalyst@Sauravshindegmail.onmicrosoft.com to Azure Portal was intercepted by Conditional Access policy CA01 (Require MFA for All Users). The sign-in was recorded with a status of Interrupted and a CA01 result of Failure. The Additional Details field confirmed: "The user was presented options to provide contact options so that they can do MFA" — indicating that Fiona had not yet completed MFA method registration at the time of the attempt.

**Supporting Evidence:**

| Field | Value |
|---|---|
| Date/Time | 2026-06-06T06:53:30Z |
| User | fiona.financeanalyst@Sauravshindegmail.onmicrosoft.com |
| Application | Azure Portal |
| Status | Interrupted |
| CA01 Result | Failure |
| Auth Requirement | Multifactor authentication |
| IP Address | 170.203.111.66 |
| Screenshots | 59-fiona-signin-failure-basicinfo.png, 60-fiona-signin-failure-CAresult.png |

**Subsequent Resolution:**  
At 07:04:50 UTC on the same date (approximately 11 minutes later), Fiona successfully signed in to Azure Portal. CA01 result changed to Success. Additional Details confirmed: "MFA requirement satisfied by claim in the token" — indicating she completed MFA registration during the gap window.

| Field | Value |
|---|---|
| Date/Time | 2026-06-06T07:04:50Z |
| Status | Success |
| CA01 Result | Success |
| Screenshots | 61-fiona-signin-success-basicinfo.png, 62-fiona-signin-success-CAresult.png |

**Risk Assessment:**  
During the ~11-minute gap between the interrupted and successful sign-in, Fiona's account lacked MFA protection. If the sign-in had originated from a malicious actor, CA01 would have blocked access. However, the gap itself represents a window where the user had not registered a second factor — a coverage gap that could be closed with MFA registration enforcement at account creation (Joiner phase).

**Recommended Control:**  
Enforce MFA method registration as part of the Joiner lifecycle (e.g., via Temporary Access Pass issuance and forced registration policy) to eliminate post-provisioning gaps.

---

### Finding 2 — Finance-Lead User Authenticated Successfully via My Apps Portal

**Severity:** Informational  
**Status:** Normal — no action required

**Observation:**  
On 2026-06-06 at 04:27:47 UTC, ethan.financelead@Sauravshindegmail.onmicrosoft.com successfully signed in via the My Apps portal, authenticating against Microsoft Graph. CA01 (Require MFA for All Users) returned a result of Success, confirming MFA was satisfied by claim in the token. CA02, CA03, and CA04 were not applicable to this sign-in.

**Supporting Evidence:**

| Field | Value |
|---|---|
| Date/Time | 2026-06-06T04:27:47Z |
| User | ethan.financelead@Sauravshindegmail.onmicrosoft.com |
| Application | My Apps |
| Resource | Microsoft Graph |
| Status | Success |
| CA01 Result | Success |
| IP Address | 170.203.111.66 |
| Screenshots | 63-ethan-signin-success-basicinfo.png, 64-ethan-signin-success-CAresult.png |

**Analysis:**  
This is expected behavior. Ethan is a member of GRP-Finance and has access to the My Apps portal. All four CA policies evaluated correctly — CA01 enforced and satisfied, CA02 not applicable (non-admin role), CA03 not applicable (modern auth client), CA04 not applicable (not a contractor account).

---

## Audit Log Findings

### Finding 3 — Leaver Lifecycle Executed for Contractor Account (Jack)

**Severity:** Informational  
**Status:** Completed — leaver process verified

**Observation:**  
Audit logs captured a sequence of directory events on 2026-06-09 between 01:13 and 01:22 UTC, consistent with a structured leaver offboarding process executed for jack.contractor@Sauravshindegmail.onmicrosoft.com. All actions were initiated by admin@Sauravshindegmail.onmicrosoft.com from IP address 170.203.111.66.

**Leaver Event Timeline:**

| Time (Local) | Category | Activity | Target | Status |
|---|---|---|---|---|
| 09/06/26, 1:13 am | UserManagement | Disable account | jack.contractor@... | Success |
| 09/06/26, 1:13 am | UserManagement | Update user | jack.contractor@... | Success |
| 09/06/26, 1:16 am | UserManagement | Update StsRefreshTokenValidFrom Timestamp | jack.contractor@... | Success |
| 09/06/26, 1:16 am | UserManagement | Update user | jack.contractor@... | Success |
| 09/06/26, 1:18 am | GroupManagement | GroupsODataV4_Get (x3) | — | Success |
| 09/06/26, 1:22 am | GroupManagement | Remove member from group | jack.contractor@... / Group ID: 6bf3818e-... | Success |

**Screenshots:** 65-audit-logs-overview.png, 66-audit-log-jack-leaver-removegroup-detail.png, 67-audit-log-jack-leaver-removegroup-targets.png, 68-audit-log-jack-leaver-disableaccount-detail.png, 69-audit-log-jack-leaver-disableaccount-targets.png

**Analysis:**  
The audit trail confirms a complete and correctly sequenced leaver execution:

1. **Account disabled** — prevents any new authentication attempts immediately
2. **StsRefreshTokenValidFrom Timestamp updated** — invalidates all existing active sessions; Jack cannot remain logged in using cached tokens
3. **Removed from group** — access to resources provisioned via group membership is revoked
4. **Dynamic group evaluation** — GroupsODataV4_Get calls confirm dynamic group membership was re-evaluated following the attribute change

**Recommended Enhancement:**  
For production environments, consider automating the leaver workflow via Lifecycle Workflows (Entra ID Governance) to enforce consistent sequencing and reduce time-to-revoke.

---

## Summary Table

| # | Finding | Severity | Status |
|---|---------|----------|--------|
| 1 | MFA registration gap — Fiona Finance-Analyst | Medium | Resolved |
| 2 | Successful MFA-compliant sign-in — Ethan Finance-Lead | Informational | Normal |
| 3 | Leaver lifecycle executed — Jack Contractor | Informational | Completed |

---

## Log Coverage Map

| Phase | Log Type | Evidence Captured |
|---|---|---|
| Phase 4 — Conditional Access | Sign-in logs (CA tab) | CA01 Failure → CA01 Success for Fiona |
| Phase 6 — Enterprise SSO | Sign-in logs | Ethan My Apps / Microsoft Graph access |
| Phase 8 — JML Lifecycle | Audit logs | Jack disable, session invalidation, group removal |

---

*All screenshots saved in: D:\IAM project\screenshots\09-log-analysis\*  
*Phase 9 complete. Next: Phase 10 — Reporting & Portfolio Wrap-Up.*