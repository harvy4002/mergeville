---
name: security-review
description: 'AI-powered security auditor that applies NCSC, NIST, GDS, Microsoft STRIDE, and MITRE ATT&CK frameworks to detect vulnerabilities. Scans for injection, auth flaws, secrets, and insecure dependencies. Integrates with existing security assessments and verification reports. Use for: "is my code secure?", "check for vulnerabilities", "security audit", "XSS/SQLi check".'
---

# Security Review

Perform a deep security audit using global standards and existing project context.

## Workflow

### 1. Context & Baseline
- **Scope**: Identify target files/directories. If none provided, scan the entire project.
- **Project Context**: Search for `.memory/specs/[feature]/security.md` (Threat Model) and `.memory/reports/security-verification-report.md` (previous audit). If found, use them as a baseline to verify implemented mitigations and identify remaining gaps.
- **Frameworks**: Apply guidance from **NCSC** (Zero Trust, Secure by Design), **NIST** (Cybersecurity Framework), **GDS** (Service Standard), **Microsoft STRIDE** (Threat Modeling), and **MITRE ATT&CK** (TTPs).

### 2. Dependency & Secrets Scan
- **Dependencies**: Use native tools (e.g., `npm audit`, `pip-audit`, `cargo audit`) or inspect lock files for known CVEs.
- **Secrets**: Scan all files (config, `.env`, source, Docker, IaC) for hardcoded keys, tokens, and high-entropy strings.

### 3. Vulnerability Deep Scan
Apply your internal expert knowledge of security vulnerabilities to detect:
- **Injection Flaws**: SQLi, XSS, Command Injection, SSRF, Template Injection.
- **Broken Auth/Access**: IDOR/BOLA, JWT weaknesses, missing auth, privilege escalation.
- **Data Handling**: Sensitive data in logs, insecure crypto, weak randomness, path traversal.
- **Business Logic**: Race conditions (TOCTOU), rate limiting gaps, unhandled edge cases.
- **Framework specific**: Next.js Server Actions, Express middleware, React `dangerouslySetInnerHTML`, etc.

### 4. Self-Verification & Severity
- For each finding, perform a second pass: "Is this exploitable given the project's sanitizers/framework defaults?"
- Assign Severity: **CRITICAL** (RCE, Auth Bypass), **HIGH** (XSS, IDOR), **MEDIUM** (CSRF, Weak Crypto), **LOW** (Headers), **INFO** (Best Practice).
- Assign Confidence: **HIGH**, **MEDIUM**, or **LOW**.

### 5. Report Generation
- Generate the report using the template in `assets/report-template.md`.
- Propose targeted patches for all **CRITICAL** and **HIGH** findings.
- **Rule**: Do NOT auto-apply changes. Present findings for review first.
- Save the report to `.memory/reports/security-verification-report.md` with YAML frontmatter:
```yaml
---
title: "Security Verification Report - [Project/Feature Name]"
date: YYYY-MM-DD
severity: [CRITICAL/HIGH/MEDIUM/LOW/INFO]
confidence: [HIGH/MEDIUM/LOW]
tags: [security, audit, vulnerability]
---
```

## Framework Alignment
- **NCSC/GDS**: Focus on "Secure by Design" and "Default to Secure".
- **STRIDE**: Classify threats (Spoofing, Tampering, Repudiation, Information Disclosure, Denial of Service, Elevation of Privilege).
- **MITRE ATT&CK**: Map vulnerabilities to potential attacker techniques (e.g., T1190 Exploit Public-Facing Application).
- **NIST**: Align with Identify, Protect, Detect, Respond, Recover functions.
