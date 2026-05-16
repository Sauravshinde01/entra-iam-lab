# Phase 3: Authentication Security

**Status:** Complete  
**Date Completed:** May 15, 2026  
**Time Invested:** ~1.5 hours

## Overview
Configured the authentication infrastructure for AccessDenied Sec tenant.
Phase 3 establishes WHICH authentication methods are available; Phase 4
will enforce WHEN MFA is required via Conditional Access.

## Authentication Methods Configured

### Enabled (Modern, Strong)
- **Microsoft Authenticator** (push + passwordless)
  - Number matching enabled (prevents push fatigue attacks)
  - Geographic location shown in notifications (anti-phishing context)
  - Application name shown in notifications
- **SMS** (backup method only)
- **Temporary Access Pass** (default — useful for onboarding scenarios)

### Explicitly Disabled
- **Voice call** — Susceptible to call forwarding and social engineering attacks
- **Email OTP for tenant users** — Email accounts typically have only password
  protection, reducing MFA back to single factor if mailbox is compromised
- **Security questions** — Information often researchable via social media;
  Microsoft retiring this method in March 2027

## Self-Service Password Reset (SSPR)

- **Enabled for:** All users
- **Methods required to reset:** 2 (multi-factor verification)
- **Approved methods:** Inherited from tenant authentication methods policy
  (Microsoft Authenticator + SMS); legacy Security Questions explicitly disabled
- **Forced registration:** Yes — users must register on next sign-in
- **Re-confirmation interval:** 180 days
- **Notifications:** Enabled to users on password reset, and to all admins
  when other admins reset their password (out-of-band alerting)

## Architecture Note: Unified Method Management

Microsoft has consolidated authentication method management. SSPR methods
are now inherited from the central Authentication Methods Policy rather
than maintaining a duplicate list. This is a cleaner architecture — one
source of truth for which methods are enabled, applied consistently for
both sign-in MFA and password recovery flows.

## Validation Testing

Tested forced-registration policy by signing in as a test user
(Carlos HR-Lead) with no registered authentication methods. Microsoft
presented the "Let's keep your account secure" prompt before allowing
further access — confirming the policy is correctly enforced at the
user experience level, not just configured in the backend.

## Key Design Decisions

1. **Modern methods over legacy:** Authenticator + SMS only;
   no voice call or security questions.
2. **Number matching enforced:** Prevents the most common push
   notification fatigue attack pattern.
3. **2 methods required for SSPR:** Ensures password reset itself
   can't be bypassed with a single compromised factor.
4. **Forced registration:** Prevents users from delaying security
   setup indefinitely, eliminating the gap where unregistered users
   would still need to call IT for password recovery.

## Reference Screenshots

- `01-auth-methods-policy-overview.png` — Initial state
- `02-microsoft-authenticator-config.png` — Strong auth configuration
- `05-auth-methods-final.png` — Final secured state
- `06-sspr-properties.png` through `09-sspr-notifications.png` — SSPR config
- `10-admin-mfa-registered.png` — Admin account MFA verified
- `12-carlos-mfa-enforcement.png` — Policy enforcement validation

## What's Next

Phase 4 will use Conditional Access to ENFORCE these methods when users
sign in. The methods configured here are the "menu" of what's available;
CA decides who must use them and when.