# Phase 7: Azure Storage + RBAC

## Objective

Demonstrate cloud RBAC by creating Azure resources and assigning 
identity-bound roles to security groups, validating that only 
authorized users can access protected data.

## Why Azure RBAC Matters

Azure RBAC controls who can do what with Azure resources. Unlike 
Entra ID roles (which govern directory operations), Azure RBAC 
governs access to cloud infrastructure — storage accounts, VMs, 
databases, and more. Group-based RBAC assignments scale efficiently 
and align with the principle of least privilege: users inherit 
permissions through group membership rather than individual assignments.

## Environment

- Tenant: AccessDenied Sec (Sauravshindegmail.onmicrosoft.com)
- Subscription: Azure subscription 1 (Pay-As-You-Go)
- Resource Group: rg-iam-lab (South Central US)
- Storage Account: stiamlabsaurav (Standard LRS)
- Blob Container: iam-lab-data (Private access level)

---

## Step 1: Create Resource Group

**Path:** Azure portal → Resource groups → + Create

| Setting | Value |
|---|---|
| Subscription | Azure subscription 1 |
| Resource group name | rg-iam-lab |
| Region | (US) South Central US |

**Prerequisite resolved:** The admin account (admin@Sauravshindegmail.onmicrosoft.com) 
initially could not create resources because Entra ID Global Administrator 
does not automatically grant Azure RBAC permissions. This was resolved by:
1. Enabling "Access management for Azure resources" in Entra ID Properties
2. Assigning the Owner role on the subscription to the admin account

This is an important distinction: Entra ID roles and Azure RBAC are 
separate permission systems. Global Administrator controls the directory; 
Azure RBAC controls cloud resources.

**Screenshot:** `36-rg-iam-lab-created.png`

---

## Step 2: Create Storage Account

**Path:** Azure portal → Storage accounts → + Create

| Setting | Value |
|---|---|
| Resource group | rg-iam-lab |
| Storage account name | stiamlabsaurav |
| Region | (US) South Central US |
| Primary service | Azure Blob Storage or Azure Data Lake Storage |
| Performance | Standard |
| Redundancy | Locally-redundant storage (LRS) |

**Screenshot:** `37-storage-account-created.png`

---

## Step 3: Create Blob Container and Upload Test File

**Path:** stiamlabsaurav → Containers → + Container

| Setting | Value |
|---|---|
| Container name | iam-lab-data |
| Access level | Private |

A sample file (sample-data.txt) was uploaded to the container for 
RBAC testing.

**Screenshots:** `38-storage-container-created.png`, `39-sample-file-uploaded.png`

---

## Step 4: Assign RBAC Roles to GRP-Finance

Two roles were assigned to GRP-Finance to enable both portal 
navigation and data access:

| Role | Scope | Purpose |
|---|---|---|
| Reader | rg-iam-lab (Resource Group) | Management plane — allows users to see resources in the Azure portal |
| Storage Blob Data Reader | iam-lab-data (Container) | Data plane — allows users to read blob data |

**Key learning — Management plane vs Data plane:**
Azure RBAC operates at two distinct levels. The Reader role grants 
management-plane access (ability to see and navigate to resources in 
the portal). Storage Blob Data Reader grants data-plane access (ability 
to read the actual blob contents). A user needs both to browse and 
read blobs through the portal. Assigning only the data-plane role 
resulted in the user being unable to find the storage account in the 
portal at all.

**Screenshot:** `40-GRP-Finance-blob-reader-assigned.png`

---

## Step 5: Validate Access — Fiona (Finance, Authorized)

Signed in as Fiona Finance-Analyst (GRP-Finance member) via incognito 
browser. Navigated to Storage accounts → stiamlabsaurav → Containers 
→ iam-lab-data.

**Authentication method:** Switched to "Microsoft Entra user account" 
to validate RBAC rather than access key authentication.

**Result:** sample-data.txt visible and accessible. RBAC working as 
intended.

**Screenshot:** `41-Fiona-blob-access-granted.png`

---

## Step 6: Validate Denied Access — Diana (HR, Unauthorized)

Signed in as Diana HR-Specialist (GRP-HR member, not in GRP-Finance) 
via incognito browser. Navigated to Storage accounts.

**Result:** Diana saw "Welcome to Azure! Don't have a subscription?" — 
she has zero Azure RBAC roles, so she cannot see any resources at all. 
Access denied at the management plane level before even reaching the 
data plane.

This demonstrates defense in depth: Diana is blocked at every layer, 
not just the data layer.

**Screenshot:** `42-Diana-blob-access-denied.png`

---

## Phase 5 Completion: Aaron PIM Eligible Storage Role

As the final Phase 5 item, Aaron IT-Admin was assigned an **Eligible** 
Storage Blob Data Reader role on rg-iam-lab via PIM. This means Aaron 
must activate the role through PIM (with MFA and justification) before 
he can read blob data — demonstrating JIT access for Azure resources 
in addition to Entra ID roles.

| Setting | Value |
|---|---|
| Resource | rg-iam-lab |
| Role | Storage Blob Data Reader |
| Member | Aaron IT-Admin |
| Assignment type | Eligible |
| Duration | 1 year |

**Screenshots:** `43-Aaron-PIM-storage-eligible-membership.png`, 
`44-Aaron-PIM-storage-eligible-setting.png`

---

## Key Takeaways

- Entra ID roles and Azure RBAC are separate systems — Global 
  Administrator does not automatically grant Azure resource permissions
- Azure RBAC has two planes: management plane (portal navigation) 
  and data plane (actual data access); users may need roles at both
- Group-based RBAC scales better than individual user assignments
- Storage Blob Data Reader is a data-plane role; Reader is a 
  management-plane role; both are needed for portal-based blob access
- PIM can govern Azure resource roles (not just Entra directory roles), 
  enabling JIT access to cloud infrastructure