# Phase 5: Privileged Identity Management (PIM)

## Objective

Configure Privileged Identity Management for Entra ID roles to enforce 
just-in-time (JIT) access, demonstrate the full activation flow, and 
establish an access review cadence for privileged role assignments.

## Why PIM Matters

Standing access to privileged roles like Global Administrator creates 
persistent attack surface. If an account is compromised, the attacker 
immediately has full tenant control. PIM eliminates standing access by 
making privileged roles eligible rather than permanently active — users 
must explicitly request activation, complete MFA, and provide a 
justification before elevated access is granted. This aligns with the 
principle of least privilege and is a core control in modern IAM programs.

## Environment

- Tenant: AccessDenied Sec (Sauravshindegmail.onmicrosoft.com)
- License required: Microsoft Entra ID P2 (trial active)
- User configured: Aaron IT-Admin (aaron.itadmin@Sauravshindegmail.onmicrosoft.com)

---

## Step 1: Convert Aaron to Eligible Global Administrator

Previously, Aaron had no active or eligible role assignments in PIM. 
The Global Administrator role was assigned as an **Eligible** assignment 
with **Permanent** eligibility at tenant scope.

**Path:**
PIM → Entra roles → Roles → Global Administrator → Assignments → Add assignments

**Result:**
- Assignment type: Eligible
- Scope: AccessDenied Sec (tenant-wide)
- Membership: Direct
- End time: Permanent

**Screenshot:** `19-Aaron-eligible-global-admin.png`

---

## Step 2: Configure Role Settings

Role settings govern how activation works for everyone assigned to 
the Global Administrator role via PIM.

**Path:**
PIM → Entra roles → Roles → Global Administrator → Settings → Edit

**Settings configured:**

| Setting | Value | Reason |
|---|---|---|
| Activation maximum duration | 4 hours | Limits exposure window; forces re-activation for extended sessions |
| On activation, require | Azure MFA | Ensures identity verification at every elevation |
| Require justification on activation | Enabled | Creates audit trail for every privilege use |
| Require ticket information | Disabled | Not applicable for lab environment |
| Require approval to activate | Disabled | No approver available in single-admin lab |

**Screenshot:** `25-Aaron-PIM-activation-form.png`

---

## Step 3: PIM Activation Flow (as Aaron)

To demonstrate the end-user activation experience, signed in as Aaron 
in a separate browser session and activated the eligible role.

**Path:**
portal.azure.com (as Aaron) → PIM → My roles → Eligible assignments → 
Global Administrator → Activate

**Activation details:**
- Duration requested: 4 hours (maximum allowed)
- Justification provided: "Performing tenant-wide IAM lab configuration 
  and user provisioning tasks requiring Global Administrator access."
- MFA: Completed via Microsoft Authenticator

**Troubleshooting note:**
The portal returned an "Unknown error" after the first activation attempt. 
However, checking the Active assignments tab immediately confirmed the 
role was successfully activated on the backend. A second activation 
attempt returned "The Role assignment already exists" — confirming the 
first attempt succeeded despite the misleading UI error. This is a known 
Azure portal behavior where status polling can time out before the backend 
confirms success. Always verify actual state via the Active assignments 
tab rather than relying solely on portal notifications.

**Result:**
- State: Activated
- End time: 4 hours from activation
- Deactivate option visible confirming active elevation

**Screenshots:** `26-Aaron-PIM-activation-reason-filled.png`, 
`27-Aaron-PIM-role-activated.png`

---

## Step 4: Access Review

An access review was created to periodically validate whether Aaron's 
eligible Global Administrator assignment is still justified.

**Path:**
PIM → Entra roles → Access reviews → New access review

**Configuration:**

| Setting | Value |
|---|---|
| Review name | AR-GlobalAdmin-Quarterly-Review |
| Description | Quarterly review of eligible Global Administrator assignments to enforce least privilege |
| Start date | 05/06/2026 |
| Frequency | One time |
| Duration | 1 day |
| Role | Global Administrator |
| Assignment type | Eligible assignments only |
| Reviewers | Selected user — Saurav Admin |
| Auto apply results | Disabled |
| If reviewers don't respond | No change |

**Why access reviews matter:**
Even with JIT activation, eligible role assignments should be reviewed 
periodically to ensure they remain justified. Access reviews enforce 
accountability and support audit requirements in regulated environments 
(HIPAA, SOX, ISO 27001).

**Result:** Review created successfully, Status: Active

**Screenshots:** `28-Aaron-access-review-created.png`, 
`29-Aaron-access-review-active.png`

---

## Pending (Phase 7 dependency)

- Eligible Storage Blob Data Reader role assignment via PIM on 
  Resource Group (rg-iam-lab) — to be completed at end of Phase 7 
  once the Resource Group and Storage Account are provisioned.

---

## Key Takeaways

- PIM converts standing privileged access into auditable, 
  time-bound, MFA-verified activations
- Role settings are configured at the role level, not the user level — 
  changes apply to all future activations of that role
- Portal UI errors do not always reflect backend state — always verify 
  via the assignments tab
- Access reviews close the loop on privilege lifecycle by ensuring 
  assignments are periodically revalidated