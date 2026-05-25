# Break-Glass Account Documentation

**Account:** breakglass@Sauravshindegmail.onmicrosoft.com  
**Display Name:** Break Glass Admin  
**Object ID:** d884a41e-120e-4d02-9d5d-e4adf4ec18ce  
**Created:** May 24, 2026  
**Purpose:** Emergency administrative access for tenant recovery

---

## ⚠️ SECURITY POLICY

Credentials and TOTP secret for this account are **NEVER** to be 
committed to source control, screenshotted into the repository, 
or stored in plain text files within the project folder. Any 
sensitive material lives only in personal credential storage 
outside the project directory.

This account must be treated as a fire extinguisher: present 
for emergencies, untouched during normal operations. Any sign-in 
event for this account is a security-significant event.

---

## Use Case

This account is the dedicated emergency recovery mechanism if 
Conditional Access policies, MFA configuration, or other identity 
controls accidentally block administrative access to the tenant. 
It **MUST be excluded from ALL Conditional Access policies** via 
the `GRP-BreakGlass-Exclusion` group.

### Common Lockout Scenarios This Protects Against

- A Conditional Access policy is misconfigured (e.g., 
  geo-restriction that blocks the admin's current location)
- All admins lose access to their MFA device simultaneously
- A change to authentication methods policy removes a required method
- An access token / session policy renders interactive sign-in impossible
- Compliant device requirements lock out admins after device drift

---

## Account Configuration

| Property | Value |
|---|---|
| User Principal Name | `breakglass@Sauravshindegmail.onmicrosoft.com` |
| Display Name | Break Glass Admin |
| First Name / Last Name | Break Glass / Admin |
| Job Title | Emergency Access Account |
| Company Name | AccessDenied Sec |
| Usage Location | United States |
| Department | (intentionally blank — not a real employee) |
| Account Type | Cloud-only Member |
| Account Status | Enabled |
| License | None (Free tier; sufficient for emergency Global Admin use) |
| Assigned Role | Global Administrator |
| Membership in Groups | `GRP-BreakGlass-Exclusion` only |

---

## Credentials Storage

- **Password:** Stored in dedicated credentials file outside the 
  project directory (`breakglass.txt` on local D: drive, separated 
  from all other project files and from `.gitignore` rules)
- **TOTP Secret:** Stored in the same file for device-independent 
  recovery — the secret can be re-imported into any compatible 
  authenticator app (Microsoft Authenticator, Bitwarden, Google 
  Authenticator, etc.) if the primary device is lost
- **NOT documented in repository, version control, screenshots, 
  or notes files inside the project folder**

### Future Improvement
Migrate credentials to a dedicated password manager (Bitwarden, 
1Password, or similar) for encrypted storage with backup capability.

---

## MFA Configuration

- **Primary Method:** Microsoft Authenticator (TOTP-based)
- **Setup Method:** Manual code entry (TOTP secret captured 
  during enrollment)
- **Recovery Capability:** TOTP secret stored alongside password 
  allows the same factor to be added to any compatible authenticator 
  app if primary device is lost or unavailable
- **No SMS/Voice backup:** Intentionally not configured — phone 
  number-based factors are weaker (SIM swap risk) and add 
  dependencies that complicate emergency recovery

### Production Hardening (Future Improvement)
In a production environment, this account would ideally use:
- A **FIDO2 hardware key** (e.g., YubiKey) for device-independent 
  recovery without depending on TOTP secrets in software stores
- Tenant Authentication Methods Policy would be expanded to enable 
  FIDO2 specifically for break-glass accounts
- A second break-glass account for redundancy (so a single account 
  compromise doesn't break the entire recovery path)

---

## Conditional Access Exclusion Strategy

This account is excluded from all Conditional Access policies via 
membership in the dedicated `GRP-BreakGlass-Exclusion` security 
group. This approach:

- **Simplifies policy management** — exclude one group instead of 
  remembering each break-glass account in every policy
- **Reduces human error** — new CA policies just exclude the group
- **Centralizes audit** — group membership is a single source of 
  truth for what's exempt from CA controls

When creating any new Conditional Access policy, the 
`GRP-BreakGlass-Exclusion` group MUST be added to the **Exclude 
users and groups** section under Assignments → Users.

---

## Sign-In Monitoring

Any successful sign-in by this account should be considered an 
emergency or audit event.

### Production Hardening (Future Improvement)
- SIEM / Microsoft Sentinel alert on any successful sign-in
- High-priority email + SMS notification to security team
- Automated sign-in log review within 24 hours of activity
- Documented incident review for every activation

For this lab, sign-in activity is reviewed manually via 
Entra → Identity → Sign-in logs.

---

## Initial Validation Testing

| Test | Date | Result |
|---|---|---|
| Account created with Global Admin role | 2026-05-24 | Success |
| Sign-in via incognito to Azure Portal | 2026-05-24 | Success — landed in tenant as Global Admin |
| MFA enrollment via Microsoft Authenticator (TOTP) | 2026-05-24 | Success — secret captured for backup |
| `GRP-BreakGlass-Exclusion` group created | 2026-05-24 | Success — break-glass account is sole member |

---

## Periodic Validation Schedule

**Recommended cadence:** Quarterly sign-in verification to 
confirm credentials still work and the account is excluded 
from any newly-added Conditional Access policies.

### Validation Log

| Date | Action | Result | Notes |
|---|---|---|---|
| 2026-05-24 | Initial sign-in test | Success | First validation post-creation |
| | | | |
| | | | |

---

## Recovery Procedure (If Tenant Lockout Occurs)

1. Retrieve `breakglass.txt` from secure storage location
2. Open private/incognito browser window (clean session)
3. Navigate to `portal.azure.com` or `entra.microsoft.com`
4. Sign in as `breakglass@Sauravshindegmail.onmicrosoft.com`
5. Complete MFA challenge using Microsoft Authenticator TOTP
6. Once authenticated, navigate to Conditional Access and:
   - Disable the policy that caused the lockout, OR
   - Temporarily disable all CA policies (extreme cases)
7. Restore normal admin sign-in
8. Re-enable CA policies once root cause is fixed
9. **Sign out of break-glass account immediately**
10. Update the Validation Log above with the recovery event
11. Conduct post-incident review of what caused the lockout

---

## Related Resources

- **Exclusion Group:** `GRP-BreakGlass-Exclusion` 
  (Object ID: `4d428821-65f5-40e5-a2f0-1d030fa69daa`)
- **Microsoft Documentation:** [Manage emergency access accounts in Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/identity/role-based-access-control/security-emergency-access)
- **Phase 4 Documentation:** See `docs/04-conditional-access-policies.md` 
  (to be created) for the policies this account is excluded from

---

*This account represents the most privileged identity in the tenant 
when activated. Treat all aspects of its management with corresponding 
care.*