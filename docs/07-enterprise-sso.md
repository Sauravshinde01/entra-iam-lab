# Phase 6: Enterprise Application SSO

## Objective

Integrate a SaaS application via SAML-based Single Sign-On in Microsoft 
Entra ID, scope access to a specific security group, and validate that 
only authorized users can see and access the application.

## Why Enterprise SSO Matters

Enterprise SSO eliminates password sprawl by letting users authenticate 
to SaaS applications using their corporate identity. From an IAM 
perspective, it centralizes access control — onboarding and offboarding 
a user's access to applications happens in one place (Entra ID) rather 
than managing separate credentials per application. Group-scoped 
assignment ensures only authorized teams can access specific applications, 
enforcing least privilege at the application layer.

## Environment

- Tenant: AccessDenied Sec (Sauravshindegmail.onmicrosoft.com)
- Application: GitHub Enterprise Cloud - Organization (Entra Gallery)
- Assigned group: GRP-IT (members: Aaron IT-Admin, Bella Helpdesk)
- SSO method: SAML 2.0

---

## Step 1: Add Enterprise Application from Gallery

GitHub Enterprise Cloud - Organization was added from the Microsoft 
Entra App Gallery. This is a pre-integrated gallery application with 
SAML SSO and automatic provisioning support.

**Path:**
Entra admin center → Enterprise apps → + New application → Search 
"GitHub Enterprise Cloud" → Select "GitHub Enterprise Cloud - Organization" 
→ Create

**Screenshot:** `30-GitHub-enterprise-app-created.png`

---

## Step 2: Configure SAML-Based SSO

SAML configuration requires setting up the trust relationship between 
the Identity Provider (Entra ID) and the Service Provider (GitHub).

**Path:**
Enterprise apps → GitHub Enterprise Cloud - Organization → Single sign-on 
→ SAML

**Basic SAML Configuration:**

| Field | Value |
|---|---|
| Identifier (Entity ID) | https://github.com/orgs/Sauravshinde01 |
| Reply URL (ACS) | https://github.com/orgs/Sauravshinde01/saml/consume |
| Sign on URL | https://github.com/orgs/Sauravshinde01/sso |
| Relay State | Not configured |
| Logout URL | Not configured |

**Attributes & Claims** were left at gallery defaults:
- givenname → user.givenname
- surname → user.surname
- emailaddress → user.mail
- name → user.userprincipalname
- Unique User Identifier → user.userprincipalname

**SAML Certificates:**
- Token signing certificate auto-generated (Status: Active)
- Certificate (Base64), Certificate (Raw), and Federation Metadata XML 
  available for download

**Note:** The Service Provider side (GitHub) was not configured because 
GitHub SAML SSO requires a GitHub Enterprise Cloud subscription (paid). 
The Identity Provider configuration in Entra ID is fully functional and 
demonstrates the complete IdP-side setup. In a production environment, 
the Service Provider would be configured with the Login URL, Microsoft 
Entra Identifier, and Logout URL from Section 4 of the SAML configuration.

**Screenshots:** `31-GitHub-SAML-config-top.png`, `32-GitHub-SAML-config-bottom.png`

---

## Step 3: Assign GRP-IT to the Application

Access was scoped to GRP-IT, meaning only IT department members (Aaron 
and Bella) can see and access the application through the My Apps portal.

**Path:**
Enterprise apps → GitHub Enterprise Cloud - Organization → Users and 
groups → + Add user/group → Select GRP-IT → Assign

**Screenshot:** `33-GitHub-GRP-IT-assigned.png`

---

## Step 4: Validate Access — Bella (IT, Authorized)

Signed in as Bella Helpdesk (GRP-IT member) via an incognito browser 
session. Navigated to myapps.microsoft.com.

**Result:** GitHub Enterprise Cloud - Organization tile visible on the 
My Apps dashboard. Access granted as expected.

**Screenshot:** `34-Bella-myapps-GitHub-visible.png`

---

## Step 5: Validate Denied Access — Ethan (Finance, Unauthorized)

Signed in as Ethan Finance-Lead (GRP-Finance member, not in GRP-IT) 
via an incognito browser session. Navigated to myapps.microsoft.com.

**Result:** GitHub Enterprise Cloud - Organization tile NOT visible on 
the My Apps dashboard. Only default apps (Add-Ins, Learning Activities) 
appeared. Access correctly denied.

**Screenshot:** `35-Ethan-myapps-no-GitHub.png`

---

## Key Takeaways

- Gallery applications provide pre-built SAML templates that simplify 
  SSO configuration on the IdP side
- Group-scoped assignment enforces application-level least privilege 
  without managing individual user assignments
- The My Apps portal (myapps.microsoft.com) serves as the end-user 
  launchpad for SSO-enabled applications
- SAML SSO has two sides: IdP configuration (Entra) and SP configuration 
  (the SaaS app); both must be completed for end-to-end SSO to function
- Testing with both authorized and unauthorized users validates that 
  access controls are working as intended