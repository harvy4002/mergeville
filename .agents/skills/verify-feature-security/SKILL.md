---
name: verify-feature-security
description: Use to verify code against a security assessment, check for secrets, and validate test integrity. Do NOT use to generate the initial security plan.
---

## Task
1. **Load Context**: Parse `[feature]` (or from `--input`). Load `.memory/specs/[feature]/security.md` and `.memory/specs/[feature]/tasks.md`. Dynamically load matching source files (e.g., `.ts`, `.py`, `.go`) from the source directory based on the project language.
2. **Execute Scan**:
   - **Tracing**: Verify every task in `security.md` Section 7 ("Remediation Tasks") is implemented in code (e.g., Zod schemas for validation, RBAC checks for Auth).
   - **Secrets**: Scan for hardcoded keys, tokens, and `BEGIN PRIVATE KEY`.
   - **Config**: Flag insecure defaults (e.g., `debug=true`) and commented-out security code. Verify the principle of least privilege in infrastructure-as-code files, Dockerfiles, or cloud IAM roles.
   - **Dependency Audit**: Run native dependency vulnerability scanners (e.g., `npm audit`, `cargo audit`, `pip-audit`) to ensure no new vulnerable packages were introduced.
   - **Framework Checks**: Add specific validation rules tailored to the frameworks in use (e.g., verifying CSRF tokens in Express, ORM SQL injection, or XSS escaping).
   - **Test Audit (CRITICAL)**:
     - *WARN*: `jest.mock` on `*auth*`/`*security*` in Unit Tests.
     - *FAIL*: `jest.mock` on `*auth*`/`*security*` in Integration Tests (real barriers must be tested).
     - *FAIL*: Test files with zero assertions (`expect` statements).
     - Ensure negative testing exists (e.g., `403 Forbidden` checks).
3. **Generate Report**: Output to `.memory/specs/[feature]/security-verification-report.md` using the template below.

## Output Template
```markdown
# Security Verification Report: [Feature Name]

**Date:** [Date] | **Status:** [PASS / FAIL / WARN]

## 1. Requirement Verification
| Security Requirement | Evidence | Status |
|---|---|---|
| *[Task]* | *[Evidence]* | *[PASS/FAIL]* |

## 2. Code Hygiene
* **Secrets / Insecure Defaults / Comments:** [Findings]

## 3. Test Coverage Audit
| Check | Status | Notes |
|---|---|---|
| Security Tests Exist / Insecure Mocks / Negative Testing | [Pass/Fail] | *[Notes]* |

## 4. Final Verdict
* [ ] **Release Approved** (All Criticals Passed) / **Remediation Required**
```
