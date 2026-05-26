# Phase 2: Identity Setup

**Status:** Complete  
**Date Completed:** May 15, 2026  

## Overview
Established the identity foundation for AccessDenied Sec tenant — 
users, groups, roles, and licensing required for all subsequent phases.

## Users Created (10 Total)

| Display Name | UPN | Department | Role |
|---|---|---|---|
| Aaron IT-Admin | aaron.itadmin@Sauravshindegmail.onmicrosoft.com | IT | PIM candidate (Phase 5) |
| Bella Helpdesk | bella.helpdesk@Sauravshindegmail.onmicrosoft.com | IT | Helpdesk Administrator |
| Carlos HR-Lead | carlos.hrlead@Sauravshindegmail.onmicrosoft.com | HR | — |
| Diana HR-Specialist | diana.hrspecialist@Sauravshindegmail.onmicrosoft.com | HR | — |
| Ethan Finance-Lead | ethan.financelead@Sauravshindegmail.onmicrosoft.com | Finance | — |
| Fiona Finance-Analyst | fiona.financeanalyst@Sauravshindegmail.onmicrosoft.com | Finance | — |
| Grace Employee | grace.employee@Sauravshindegmail.onmicrosoft.com | Sales | — |
| Henry Employee | henry.employee@Sauravshindegmail.onmicrosoft.com | Marketing | — |
| Ivy Contractor | ivy.contractor@Sauravshindegmail.onmicrosoft.com | External | Contractor |
| Jack Contractor | jack.contractor@Sauravshindegmail.onmicrosoft.com | External | JML demo subject (Phase 8) |

**Common properties for all users:**
- Company name: AccessDenied Sec
- Usage location: United States
- Password: Auto-generated, stored in local passwords.txt (not in repo)

## Security Groups Created (5 Total)

| Group Name | Type | Membership | Members |
|---|---|---|---|
| GRP-IT | Security | Assigned | Aaron, Bella |
| GRP-Finance | Security | Assigned | Ethan, Fiona |
| GRP-HR | Security | **Dynamic** | Carlos, Diana (auto-populated) |
| GRP-Contractors | Security | Assigned | Ivy, Jack |
| GRP-AllEmployees | Security | Assigned | All 8 internal users (no admins) |

## Key Design Decisions

### 1. Dynamic Group for HR (GRP-HR)
**Rule:** `(user.department -eq "HR")`  
**Why:** Demonstrates identity-driven governance — group membership 
automatically reflects organizational structure. Any future HR hire 
with department set to "HR" joins the group without manual action.  
**Requires:** Entra ID P2 license (activated for this tenant)

### 2. Admin Segregation
Admins (Saurav Admin, Break Glass Admin) are deliberately excluded 
from GRP-AllEmployees. Principle: privileged identities should not 
be members of standard user groups to avoid inheriting user-scoped 
permissions unintentionally.

### 3. Contractors Isolated
GRP-Contractors is separate from GRP-AllEmployees. This enables 
targeted CA policies for contractors (CA04 in Phase 4 — geo-restriction 
to US only) without affecting internal employees.

### 4. Helpdesk Admin Role (Bella)
Bella Helpdesk was assigned the Helpdesk Administrator directory role 
directly (Active, Permanent, Direct assignment). This demonstrates 
role-based access in standard Entra — contrasted with Phase 5 PIM 
which introduces just-in-time elevation for higher-privilege roles.

### 5. Jack Reserved for JML Demo
Jack Contractor is intentionally underused in early phases, preserved 
as the Joiner-Mover-Leaver lifecycle demo subject in Phase 8.

## P2 Trial Activation

- **Activated via:** M365 Admin Center (admin.microsoft.com)
- **Order:** d114b4aa-0419-4284-b44c-17516af2f1a5
- **Licenses:** 100 P2 trial licenses
- **Assigned to:** Saurav Admin, Aaron, Carlos, Diana
- **Required for:** Dynamic groups, PIM (Phase 5), Identity Protection

## Reference Screenshots

- Phase 2 screenshots in `screenshots/02-identity/`
- Key screenshot: Dynamic group GRP-HR showing auto-populated 
  members (Carlos, Diana) based on department rule

## What's Next

Phase 3 used these identities to configure authentication methods 
and SSPR. Phase 4 is using the group structure (GRP-Contractors, 
GRP-BreakGlass-Exclusion) for Conditional Access policy targeting.