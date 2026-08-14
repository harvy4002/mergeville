---
name: accessibility-review
description: 'AI-powered accessibility auditor that applies WCAG 2.2 Level AA standards to detect barriers for users with disabilities. Scans for POUR principle violations, keyboard traps, contrast issues, and screen reader compatibility. Use for: "improve accessibility", "a11y audit", "WCAG compliance", "check for accessibility issues".'
---

# Accessibility Review

Perform a deep accessibility audit using WCAG 2.2 guidelines and project context.

## Workflow

### 1. Context & Baseline
- **Scope**: Identify target files/directories. If none provided, scan the entire project.
- **Project Context**: Search for `.memory/reports/accessibility-review-report.md` (previous audit). If found, use it as a baseline to verify fixed issues and identify remaining gaps.
- **Frameworks**: Apply **WCAG 2.2** (Level A, AA, and AAA) and the **POUR** principles (Perceivable, Operable, Understandable, Robust).

### 2. Accessibility Scan
Apply your internal expert knowledge of accessibility to detect:
- **Perceivable**: Missing alt text, low color contrast (4.5:1 min), non-text content without alternatives, complex images without descriptions, relying on color alone.
- **Operable**: Non-keyboard accessible functionality, keyboard traps, missing focus indicators, lack of skip links, insufficient target sizes (24x24px min), dragging movements without alternatives.
- **Understandable**: Missing page language, inconsistent navigation, complex forms without labels, non-descriptive error messages, redundant data entry.
- **Robust**: Incorrect ARIA roles/states, missing live regions for dynamic updates, non-semantic HTML structures.

### 3. Self-Verification & Severity
- For each finding, perform a second pass: "Is this a blocker (CRITICAL) or a serious barrier (HIGH) for a specific user group (e.g., screen reader users, keyboard-only users)?"
- Assign Severity: **CRITICAL** (Blocker, No alternative), **HIGH** (Serious barrier, major friction), **MEDIUM** (Minor barrier, legal risk), **LOW** (Best practice), **INFO** (Observation).
- Assign Confidence: **HIGH**, **MEDIUM**, or **LOW**.

### 4. Report Generation
- **Requirement**: Write the report to `.memory/reports/accessibility-review-report.md`. With YAML frontmatter:
```yaml
---
title: "Accessibility Review Report - [Project/Feature Name]"
date: YYYY-MM-DD
severity: [CRITICAL/HIGH/MEDIUM/LOW/INFO]
confidence: [HIGH/MEDIUM/LOW]
tags: [accessibility, audit, wcag]
---
- **Template**: Use the template in `assets/report-template.md`.
- **Output**: Propose targeted patches for all **CRITICAL** and **HIGH** findings.
- **Rule**: Do NOT auto-apply changes. Present findings and the generated report for review first.

## Goal
Enable an inclusive experience by default, ensuring digital products are usable by everyone, regardless of ability.
