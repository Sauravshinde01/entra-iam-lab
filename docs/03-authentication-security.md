# Phase 3: Authentication Security

## Overview
Configured the authentication infrastructure for AccessDenied Sec tenant.
Phase 3 establishes WHICH authentication methods are available; Phase 4
will enforce WHEN MFA is required via Conditional Access.

## Authentication Methods Configured

### Enabled (Modern, Strong)
- Microsoft Authenticator (push + passwordless)
  - Number matching enabled (prevents push fatigue attacks)
  - Geographic location shown in notifications (anti-phishing context)
  - Application name shown in notifications
- SMS (backup method only)

### Disabled (Legacy, Weak)
- Voice call (susceptible to call forwarding attacks)
- Email OTP for tenant users (kept for guest scenarios only)

## Self-Service Password Reset (SSPR)
- Enabled for: All users
- Methods required: 2 (multi-factor verification)
- Approved methods: Mobile app notification, mobile app code, SMS
- Registration: Forced on next sign-in
- Notifications: Enabled to users and admins

## Key Design Decisions
1. **Modern methods over legacy:** Authenticator + SMS only,
   no voice call or security questions.
2. **Number matching enforced:** Prevents the most common
   push notification fatigue attack pattern.
3. **2 methods required for SSPR:** Ensures the reset
   itself can't be bypassed with a single compromised factor.
4. **Forced registration:** Prevents users from delaying
   security setup indefinitely.

## What's Next
Phase 4 will use Conditional Access to ENFORCE these methods
when users sign in. The methods configured here are the "menu"
of what's available; CA decides who must use them and when.