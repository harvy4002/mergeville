---
name: assess-security
description: Use to perform threat modeling and security assessment on a feature proposal. Do NOT use to audit existing code or implement security fixes.
---

## Task
1. **Load Context**: Parse `[feature]` from user input. Load `.memory/specs/[feature]/proposal.md` and `.memory/specs/[feature]/spec.md` (or path from `--input`). Load `data-model.md`, `contracts/`, and `adrs/` if they exist. Parse the "Security Context" table in `proposal.md`.
2. **Validate Context**: Ensure declared "Data Sensitivity" matches data models (e.g., `user_email` is PII, not Public).
3. **Threat Modeling**: 
   - Analyze Data Flow (Ingress/Egress, Data at Rest) for CIA (Confidentiality, Integrity, Availability) preservation.
   - **PII/GDPR Scan**: Flag PII fields. Fail compliance if PII exists but sensitivity is "Public" or "Low".
   - Identify threat exploitation paths and gaps (auth, encryption, logging).
4. **Evaluate Standards**: Check against NCSC Zero Trust, Secure by Design (Secure Defaults, Data Minimization), and avoid NCSC Anti-Patterns (Browse-Up, Management Bypass, Implicit Trust).
5. **Generate Report**: Output to `.memory/specs/[feature]/security.md` using the exact template below. Reference specific principles for recommendations.

## Output Template
```markdown
# Security Assessment: [Feature]

**Target Plan:** `.memory/specs/[feature]/proposal.md` | **Context:** *[Summary]*

## 1. Context Validation
| Attribute | Declared | Assessment | Match? |
|---|---|---|---|
| Sensitivity | *[Val]* | *[Val]* | *[✅/❌]* |

## 2. CIA Triad
| Pillar | Status | Notes | Controls |
|---|---|---|---|
| Confidentiality/Integrity/Availability | *[Pass/Fail]* | *[Notes]* | *[Checks]* |

## 3. Data Flow
| Flow | Source | Dest | Type | Trust Boundary? | Protocol | Controls |
|---|---|---|---|---|---|---|

## 4. Threat Assessment
* **Critical Risk / Vulnerability:** [Description]

## 5. Compliance
* **Zero Trust / Secure by Design / Anti-Patterns:** [Status/Notes]

## 6. Required Remediation
### A. Architecture / B. Requirements / C. Anti-Patterns
* [ ] **[Action]:** [Instruction] (*Rationale:* [Principle])

## 7. Remediation Tasks
*Use exact format:* `- [ ] [Security] [Context] Description` *(Context: `[Global]` or `[US#]`)*
- [ ] [Security] [Global] Enforce TLS 1.3
```
