---
name: fix-bug
description: Use to perform root cause analysis and implement a bug fix with regression tests. Do NOT use to add new features or plan user stories.
---

## Workflow
1. **Load Context**: Parse the `[bug reference]`. Load the bug report, related documentation, source code, and previous fix attempts.
2. **Reproduce**: Attempt to reproduce the bug in the local environment.
3. **Analyze Root Cause**: Perform a formal "5 Whys" analysis to identify the fundamental origin of the bug.
4. **Perform Impact Analysis**: Conduct a horizontal impact analysis to identify similar patterns or vulnerabilities in other components.
5. **Plan Resolution**: Outline fix steps, tests, and potential impacts. Consolidate the root cause analysis, impact analysis, and resolution plan into a single file at `.memory/bugs/[bug reference]/plan.md`. Ensure this file includes YAML frontmatter similar to proposals:
   ```yaml
   ---
   title: "[Bug title or description]"
   component: ""       # narrow area, e.g., "API/auth", "iOS/SwiftUI"
   domain: ""          # broad area, e.g., "auth", "testing", "adlc"
   status: "pending"   # pending or fixed
   tags: ["bug"]       # free-form keywords
   created: YYYY-MM-DD
   updated: YYYY-MM-DD
   ---
   ```
6. **Generate Tasks**: For complex fixes, invoke `propose` skill to create a plan to fix the bug.
7. **Create Regression Test**: Implement an automated regression test (unit test and end-to-end tests where applicable) tagged with the bug reference (e.g., `// regression-test: bug #123`) before implementing the code fix.
8. **Implement Fix**: Apply code changes to address the root cause following best practices.
9. **Verify Fix**: Run all unit and integration tests covering the fix to prevent regressions.
10. **Document Change**: Update relevant documentation and add code comments.
11. **Report Status**: Prepare a concise summary of the analysis, fix, and verification for stakeholders.
