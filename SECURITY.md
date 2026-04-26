# Security Policy

## Supported Versions

Only the latest release of BudgetBuddy receives security updates.

| Version | Supported |
|---------|-----------|
| 1.0.0   | ✅ Active  |
| < 1.0.0 | ❌ Not supported |

---

## Reporting a Vulnerability

If you discover a security vulnerability in BudgetBuddy, **please do not open a public GitHub issue.**

Report it privately via email:

**📧 security@rsmk.me**

Include the following in your report:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Any suggested fix (optional)

You can expect an acknowledgement within **48 hours** and a status update within **7 days**.

---

## Scope

The following are considered in scope for security reports:

- Firebase Realtime Database misconfigurations (unintended data exposure)
- Data leakage between user sessions
- Insecure storage of sensitive financial data on-device
- Improper handling of Firebase API keys or credentials in the APK

The following are **out of scope**:

- Vulnerabilities in third-party dependencies (report to the respective maintainer)
- Issues on devices that are rooted or have developer mode misuse
- Social engineering attacks

---

## Security Practices in This App

- Firebase API keys are scoped and restricted via Firebase Security Rules
- No plaintext passwords are stored — authentication is handled entirely by Firebase Auth
- All financial data is tied to authenticated user sessions
- The APK does not request unnecessary Android permissions

---

## Disclosure Policy

Once a fix is released, the vulnerability will be disclosed publicly in the GitHub release notes with credit to the reporter (unless anonymity is requested).

---

*RSMK Technologies · [rsmk.me](https://rsmk.me)*
