---
name: generate-test-cases
description: Use to generate manual and automated test case scenarios from a user story. Do NOT use to write test execution code or CI/CD pipelines.
---

## Task
1. **Analyze Requirements**: Load and review the provided user story, feature specification, or acceptance criteria.
2. **Identify Scenarios**: Break down the requirements into distinct, testable scenarios. Ensure coverage for:
   - **Happy Path (Positive Testing)**: The primary, intended workflow.
   - **Negative Testing**: Invalid inputs, unauthorized access, and error conditions.
   - **Edge/Boundary Cases**: Maximum/minimum lengths, extreme values, timeouts.
   - **Non-Functional Testing**: Basic performance or layout checks if applicable.
3. **Format Test Cases**: Structure each test case clearly, providing prerequisite setup, step-by-step actions, and the expected result.

## Output Format
```markdown
# Test Cases: [Feature/Story Name]

## 🟢 Happy Path Scenarios

### TC-01: [Brief Scenario Name]
- **Pre-conditions**: [e.g., User is logged in, Database has 1 item]
- **Steps**:
  1. [Action 1]
  2. [Action 2]
- **Expected Result**: [What should happen]

## 🔴 Negative Scenarios

### TC-02: [Brief Scenario Name]
- **Pre-conditions**: [e.g., User is NOT logged in]
- **Steps**:
  1. [Action]
- **Expected Result**: [System prevents action and shows error X]

## 🟡 Edge Cases
### TC-03: [Brief Scenario Name]
...
```