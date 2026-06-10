# Phase 10 — Automation Scripts (Microsoft Graph + PowerShell)
**Project:** AccessDenied Sec — Entra ID IAM Lab  
**Tenant:** Sauravshindegmail.onmicrosoft.com  
**Author:** Saurav Shinde  
**Date:** 2026-06-09  
**Tools:** Microsoft Graph PowerShell SDK v2.37.0, Windows PowerShell 5.1

---

## Overview

This phase demonstrates automation of common IAM reporting tasks using 
Microsoft Graph PowerShell SDK. Both scripts connect to the AccessDenied 
Sec Entra ID tenant via delegated authentication and export structured 
data to CSV for audit and governance purposes.

These scripts represent the automation layer that enterprise IAM teams 
build on top of Entra ID — replacing manual portal exports with 
repeatable, auditable, and schedulable operations.

---

## Environment Setup

### Prerequisites Installed

| Component | Version | Install Command |
|---|---|---|
| NuGet Provider | 2.8.5.208 | Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force |
| Microsoft.Graph.Authentication | 2.37.0 | Install-Module Microsoft.Graph.Authentication -Scope AllUsers -Force |
| Microsoft.Graph.Users | 2.37.0 | Install-Module Microsoft.Graph.Users -Scope AllUsers -Force |
| Microsoft.Graph.Groups | 2.37.0 | Install-Module Microsoft.Graph.Groups -Scope AllUsers -Force |

Modules installed to: C:\Program Files\WindowsPowerShell\Modules

### Authentication Method
- Type: Delegated (Interactive Browser)
- Account: admin@Sauravshindegmail.onmicrosoft.com
- Tenant: Sauravshindegmail.onmicrosoft.com
- Scopes granted: User.Read.All, Directory.Read.All, Group.Read.All

**Screenshots:** 70-graph-sdk-install.png, 71-graph-sdk-verify.png, 
72-graph-connected.png

---

## Script 1 — Export All Users to CSV

**File:** scripts/01-export-users.ps1  
**Purpose:** Export all tenant users with key IAM attributes for 
audit and governance review  
**Scopes Required:** User.Read.All, Directory.Read.All

### Fields Exported

| Field | Description |
|---|---|
| DisplayName | User's full display name |
| UserPrincipalName | UPN / login identity |
| Department | Assigned department |
| JobTitle | Job title / role |
| AccountEnabled | Whether account can authenticate |
| LicensesAssigned | Whether user has any assigned licenses |
| CreatedDateTime | Account creation timestamp |

### Output

- File: scripts/users-export.csv
- Total records: 13 users
- Format: UTF-8 CSV, no type information header

### Key Observations from Output

| User | AccountEnabled | Note |
|---|---|---|
| Jack Contractor | FALSE | Leaver offboarding confirmed — account disabled |
| Break Glass Admin | TRUE | No department/title — correct for emergency account |
| Aaron IT-Admin | TRUE | Licensed — Global Admin eligible via PIM |
| Saurav Admin | TRUE | Licensed — tenant admin |

**Screenshots:** 73-users-export-output.png, 74-users-export-csv.png

---

## Script 2 — Export GRP-IT Members to CSV

**File:** scripts/02-export-grp-it-members.ps1  
**Purpose:** Export current members of the GRP-IT security group 
for access review and audit purposes  
**Scopes Required:** Group.Read.All, User.Read.All, Directory.Read.All

### Fields Exported

| Field | Description |
|---|---|
| DisplayName | Member's full display name |
| UserPrincipalName | UPN / login identity |
| Department | Assigned department |
| JobTitle | Job title / role |
| AccountEnabled | Whether account can authenticate |
| GroupName | Source group (GRP-IT) |

### Output

- File: scripts/grp-it-members-export.csv
- Total records: 2 members
- Format: UTF-8 CSV, no type information header

### Key Observations from Output

| User | Department | JobTitle | Note |
|---|---|---|---|
| Aaron IT-Admin | IT | IT Administrator | Active IT admin |
| Bella Helpdesk | IT | Help Desk Technician | Active helpdesk |

Jack Contractor is NOT present in GRP-IT — confirming successful 
leaver offboarding (group removal executed in Phase 8, audit trail 
verified in Phase 9).

**Screenshots:** 75-grp-it-export-output.png, 76-grp-it-export-csv.png

---

## IAM Value Demonstrated

These scripts demonstrate skills directly relevant to enterprise IAM roles:

- Connecting to Microsoft Graph via PowerShell with delegated auth
- Querying user and group data programmatically via Graph API
- Exporting structured CSV reports for audit and access review purposes
- Correlating script output with manual configurations (Jack's 
  disabled account, group membership changes) to validate lifecycle 
  operations

In production environments these scripts would be scheduled via 
Azure Automation or Task Scheduler and integrated into access 
certification workflows.

---

*Scripts located in: D:\IAM project\scripts\*  
*Phase 10 complete. Next: Phase 11 — Documentation Polish.*