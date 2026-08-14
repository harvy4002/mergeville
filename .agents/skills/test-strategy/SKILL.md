---
name: test-strategy
description: "Assists in defining, updating, and documenting the project's comprehensive test strategy. Use this skill when you need to create or update the system test strategy overview (.memory/testing.md) to ensure unit, integration, functional, end-to-end, performance (API and Web), security, and accessibility testing are rigorously planned and implemented."
---

# Test Strategy Skill

This skill guides the process of documenting the project's test strategy and ensuring all crucial testing levels—particularly Unit, Functional, End-to-End (E2E), Performance (API & Web), Security, and Accessibility—are properly defined, resourced, and systematically implemented.

## Workflows

### Defining Project Test Strategy

When asked to define or document the project test strategy for the first time:

1.  **Research & Discovery**: Proactively analyze the codebase (e.g., package managers, dependency files, directory structure, existing tests) to identify currently used testing frameworks, tools, and test coverage gaps.
2.  **Gather Information**: Present findings to the user and ask for:
    *   Specific testing goals or regulatory requirements.
    *   Target environments, CI/CD integration, and path to live details.
    *   Mocking strategies and access requirements for different testing levels.
3.  **Generate `.memory/testing.md`**:
    *   Use `assets/test-strategy-template.md` as a base.
    *   Populate the **Testing Approach** matrix with specific technologies, success criteria, and responsibilities tailored to the project.
    *   Ensure both **Performance (API)** and **Performance (Web)** are addressed.
    *   Save the final strategy to `.memory/testing.md`.
4.  **Record Risks & Assumptions**:
    *   Use the `save-assumption` skill to record any technical assumptions (e.g., availability of staging environments). Link these in `.memory/testing.md`.
    *   Document risks in the "Risk & Mitigation" section, specifically focusing on test flakiness (e.g., race conditions, async state) and data contamination.

### Updating Project Test Strategy

When the system evolves, new features are added, or testing tools change:

1.  **Surgical Update**: Edit `.memory/testing.md` to reflect changes in testing levels, tools, or success criteria.
2.  **Update Pipeline**: Ensure any changes in the release process or CI/CD pipeline are reflected in the strategy.
3.  **Risk & Assumption Reference**: Update the risks table and reference any new or resolved assumptions using the `save-assumption` skill.

### Guiding Test Implementation

To ensure tests are implemented correctly and reliably:

1.  **Task Generation Checklist**: When collaborating with the `propose` or `implement` skills, enforce that every feature proposal includes explicit tasks for writing tests at the relevant levels defined in the strategy.
2.  **Reliability & State Management**: Remind implementing agents to prioritize test isolation, robust data seeding, and UI/application state synchronization (e.g., state-based waits instead of hardcoded sleeps) to prevent flakiness.
3.  **Performance & Security Guards**: Explicitly require implementing agents to define and verify performance benchmarks (e.g., response times, Web Vitals) and security boundaries (e.g., authorization checks) within their test suites.

## Assets

*   `assets/test-strategy-template.md`: Streamlined template for the main test strategy document using a tabular matrix format.
