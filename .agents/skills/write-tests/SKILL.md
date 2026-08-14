---
name: write-tests
description: Use to generate unit, integration, and e2e tests with edge cases. Do NOT use to implement product features or refactor existing tests.
---

## Task
1. **Context Retrieval**: Review `.memory/testing.md` and `.memory/specs/{feature-name}/test-cases.md` (if available) to ensure alignment with the project testing strategy and feature requirements.
2. **Analyze Source**: Review the provided source code file(s) and identify the core functions, classes, and their dependencies.
3. **Determine Test Scope**: Identify the framework used in the project (e.g., Jest, Pytest, Go Test, JUnit). Ask the user if the framework is unclear.
4. **Generate Tests**: Draft unit, integration, and e2e test cases that cover:
   - **Happy Path**: Expected inputs producing expected outputs.
   - **Edge Cases**: Empty arrays, null values, maximum/minimum bounds.
   - **Error Handling**: Invalid inputs, expected exceptions, and timeout scenarios.
5. **Mock Dependencies**: Implement necessary mocks or stubs for external services, databases, or file system operations to ensure tests run in isolation.
6. **Output**: Output the complete, runnable test file code.

## Guidelines
- Follow the Arrange-Act-Assert (AAA) pattern.
- Ensure test names clearly describe the scenario and expected outcome (e.g., `test_calculate_total_with_empty_cart_returns_zero`).
- Ensure test names follow the same convention as other tests in the code 
- Aim for high branch and statement coverage.