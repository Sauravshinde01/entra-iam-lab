# Phase 12 — Shutdown & Decommission
**Project:** AccessDenied Sec — Entra ID IAM Lab  
**Date:** 2026-06-10  
**Author:** Saurav Shinde

---

## Overview

This phase documents the controlled decommission of all lab resources 
following completion of Phases 1–11. Proper shutdown demonstrates 
responsible cloud hygiene — a real skill expected of IAM engineers 
and cloud administrators.

---

## Shutdown Checklist

| Task | Status | Date |
|---|---|---|
| Microsoft Entra ID P2 Trial cancelled | ✅ Complete | 2026-06-10 |
| Azure resource group rg-iam-lab deleted | ✅ Complete | 2026-06-10 |
| Azure storage account stiamlabsaurav deleted | ✅ Complete | 2026-06-10 |
| Azure All Resources confirmed empty | ✅ Complete | 2026-06-10 |
| Final cost check completed | ✅ Complete | 2026-06-10 |

---

## P2 Trial Cancellation

**Location:** Microsoft 365 Admin Center → Billing → Your products  
**Action:** Cancelled Microsoft Entra ID P2 Trial  
**Result:** Subscription status changed to Disabled immediately  
**Expiry date:** 15/6/2026 (features remain active until expiry)  
**Billing impact:** None — trial subscriptions do not auto-renew into 
paid subscriptions  

**Screenshots:** 78-p2-trial-cancelled.png, 79-p2-trial-disabled-confirmed.png

---

## Azure Resource Deletion

**Resource group deleted:** rg-iam-lab (South Central US)  
**Resources deleted with it:**
- Storage account: stiamlabsaurav
- Blob container: iam-lab-data (and all contents)

**Method:** Deleted entire resource group — cascading deletion 
removes all child resources in a single operation.

**Screenshots:** 80-azure-rg-deleted.png, 82-azure-all-resources-empty.png

---

## Final Cost Check

**Tool:** Azure Cost Management → Cost Analysis → Accumulated Costs  
**Scope:** Azure subscription 1  
**Period:** May 12 – June 10, 2026  
**Actual cost:** < $0.01 USD  
**Breakdown:**
- Storage (stiamlabsaurav): < $0.01
- Bandwidth: $0.00

Total lab cost for the entire project: **less than one cent.**

**Screenshot:** 81-azure-cost-check.png

---

## Post-Shutdown State

| Component | Status |
|---|---|
| Entra ID tenant | Active (free tier) — Entra ID Free |
| Azure subscription | Active — Pay-As-You-Go (no resources running) |
| P2 features | Disabled (cancelled) |
| Azure resources | Zero — all deleted |
| GitHub repo | Preserved — full lab documentation and evidence |
| Monthly cost going forward | $0.00 |

---

## Key Takeaway

Proper decommissioning is as important as provisioning. In enterprise 
environments, failure to clean up resources leads to shadow IT, 
unexpected billing, and security gaps from orphaned accounts and 
exposed storage. This shutdown demonstrates the full lifecycle of 
responsible cloud resource management.

---

*Phase 12 complete. All 12 phases of the AccessDenied Sec IAM Lab are now complete.*