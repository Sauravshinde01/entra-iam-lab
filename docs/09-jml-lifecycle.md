# Phase 8: Joiner-Mover-Leaver (JML) Lifecycle

## Objective

Simulate a complete identity lifecycle — onboarding, department 
transfer, and offboarding — using Jack Contractor as the demo subject. 
This demonstrates the operational IAM processes that underpin every 
enterprise identity program.

## Why JML Matters

The Joiner-Mover-Leaver lifecycle is the backbone of identity governance. 
Every user goes through at least two of these stages (join and leave), 
and many go through all three. Poorly managed lifecycle events create 
security gaps: orphaned accounts from incomplete offboarding, excessive 
permissions from undocumented role changes, and access creep from 
missing mover reviews. In enterprise environments, these processes are 
typically automated through IGA platforms (SailPoint, Saviynt, etc.) 
and provisioning tools (DRA, MIM, Lifecycle Workflows). This lab 
demonstrates the manual Entra ID process that those tools automate.

## Environment

- Tenant: AccessDenied Sec (Sauravshindegmail.onmicrosoft.com)
- Subject: Jack Contractor (jack.contractor@Sauravshindegmail.onmicrosoft.com)

---

## Scenario 1: Joiner (Baseline State)

Jack was onboarded as an external contractor during Phase 2. His 
initial state represents a completed joiner process.

**Baseline profile:**

| Field | Value |
|---|---|
| Display name | Jack Contractor |
| Job title | Contractor |
| Department | External |
| Company | AccessDenied Sec |
| Account status | Enabled |
| Group memberships | GRP-Contractors |
| Applications | 0 |
| Assigned roles | 0 |
| Assigned licenses | 0 |
| Sign-in history | Never signed in |

**Key joiner controls demonstrated:**
- User account created with appropriate department and job title
- Assigned to department-specific security group (GRP-Contractors)
- No unnecessary application access, roles, or licenses
- Account enabled and ready for first sign-in

**Screenshots:** `46-Jack-joiner-overview.png`, `47-Jack-joiner-properties.png`, 
`48-Jack-joiner-groups.png`

---

## Scenario 2: Mover (Contractor → IT Department)

**Scenario:** Jack's contract has been converted to a full-time IT 
support role. This requires updating his profile, changing group 
memberships, and verifying that access changes propagate correctly.

### Step 1: Update profile

**Path:** Entra admin center → Users → Jack Contractor → Edit properties 
→ Job Information

| Field | Before | After |
|---|---|---|
| Job title | Contractor | IT Support Specialist |
| Department | External | IT |

**Screenshot:** `49-Jack-mover-profile-updated.png`

### Step 2: Update group memberships

Two changes required:
1. **Remove** from GRP-Contractors (old department group)
2. **Add** to GRP-IT (new department group)

**Path:** Users → Jack Contractor → Groups → Remove/Add memberships

**Result after mover:**
- GRP-Contractors: Jack removed (only Ivy remains)
- GRP-IT: Jack added (now Aaron, Bella, Jack)

**Access impact:** Because GRP-IT is assigned to the GitHub Enterprise 
Cloud SSO application (configured in Phase 6), Jack automatically 
inherited access to that application through group membership. This 
demonstrates how group-based access control simplifies mover events — 
adding a user to the correct group automatically grants the right 
application access without manual per-app assignments.

**Screenshots:** `50-Jack-mover-remove-from-contractors.png`, 
`51-Jack-mover-contractors-after-removal.png`, 
`52-Jack-mover-added-to-GRP-IT.png`

---

## Scenario 3: Leaver (Offboarding)

**Scenario:** Jack is leaving the organization. The offboarding process 
must immediately secure the account and remove all access.

### Step 1: Disable the account

**Path:** Users → Jack Contractor → Edit properties → Settings → 
Account enabled → unchecked → Save

This prevents any new sign-in attempts. The account still exists in 
the directory for audit trail purposes but cannot authenticate.

**Screenshots:** `53-Jack-leaver-account-disabled-settings.png`, 
`54-Jack-leaver-account-disabled-overview.png`

### Step 2: Revoke all sessions

**Path:** Users → Jack Contractor → Revoke sessions (top toolbar)

This invalidates all active refresh tokens and session cookies across 
all devices. Even if Jack had an active browser session or cached token, 
it becomes immediately invalid.

**Screenshots:** `55-Jack-leaver-revoke-sessions-confirm.png`, 
`56-Jack-leaver-sessions-revoked.png`

### Step 3: Remove from all groups

**Path:** Users → Jack Contractor → Groups → select GRP-IT → 
Remove memberships

This strips all group-inherited access including application 
assignments (GitHub SSO) and any RBAC roles tied to group membership.

**Result:** "Not a member of any groups"

**Screenshots:** `57-Jack-leaver-remove-from-GRP-IT.png`, 
`58-Jack-leaver-no-groups-final.png`

### Final leaver state:

| Field | Value |
|---|---|
| Account status | Disabled |
| Sessions | Revoked |
| Group memberships | 0 |
| Applications | 0 (inherited access removed) |
| Assigned roles | 0 |
| Sign-in capability | Blocked |

---

## Offboarding Checklist (Production Reference)

In a production environment, a complete offboarding would also include:

- [ ] Disable account (block sign-in)
- [ ] Revoke all sessions
- [ ] Remove from all groups
- [ ] Remove direct role assignments
- [ ] Remove direct application assignments
- [ ] Revoke PIM eligible assignments
- [ ] Transfer mailbox/OneDrive ownership to manager
- [ ] Set auto-reply on mailbox (if applicable)
- [ ] Remove from distribution lists
- [ ] Revoke MFA registration
- [ ] Convert to shared mailbox or delete after retention period
- [ ] Document offboarding in ticketing system

## Key Takeaways

- JML lifecycle events are the most frequent IAM operations in any 
  organization — reliable processes prevent security gaps
- Group-based access control simplifies mover events by automatically 
  adjusting application and resource access through membership changes
- Offboarding requires multiple actions (disable, revoke, remove) — 
  missing any one leaves residual access
- In enterprise environments, these manual steps are automated through 
  IGA platforms (SailPoint, Saviynt) and provisioning tools, but 
  understanding the underlying Entra operations is essential for 
  troubleshooting and audit response