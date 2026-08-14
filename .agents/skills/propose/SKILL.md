---
name: propose
description: "Plans the implementation of a task using a structured specification methodology. Integrates ADR, Assumption, UI Planning, and Security Assessment skills to generate a structured implementation proposal and task list. Do NOT use to execute implementation steps or modify source code."
---

# Propose Skill

**STRICT MANDATE: This skill is for PLANNING ONLY. Do NOT execute any implementation steps or modify source code under any circumstances during the execution of this skill.**

Use this skill to transform a feature request or bug report into a structured, actionable implementation plan. Do not execute any implementation steps; this skill is solely for planning and proposal generation.

## Workflow

### Phase 1: Environment & Context Check
1.  **Detect Existing Specifications**: Check `.memory/specs/{feature-name}/` (where `{feature-name}` is kebab-cased) for structured specification artifacts. Read the product-level feature specification (`feature.md` and any associated `*-spec.md` files) to understand the functional requirements, user scenarios, and business success criteria.
2.  **Architecture & Design**: Read `.memory/architecture.md`, `.memory/design-guidelines.md`, and `.memory/testing.md` to ensure the plan aligns with project and testing standards.

### Phase 2: Knowledge Extraction (Mandatory)
Before drafting the plan, you MUST capture all implicit decisions and bets, and leverage existing project knowledge:
1.  **Retrieve Design Assets**: If a design phase has already occurred, retrieve the `design-plan.md` and any associated mockups or Storybook references from `.memory/specs/{feature-name}/` or the design directory to ensure your technical plan aligns with the visual requirements.
2.  **Retrieve Historical Context**: Extract relevant knowledge by running the `skills/product/propose/scripts/extract_knowledge.sh` script with a comma-separated list of relevant tags/topics for the current task.
    *   Example: `skills/product/propose/scripts/extract_knowledge.sh "auth,api,security"`
    *   Review the content of the files returned by the script to guide your technical planning.
3.  **Record New Decisions**: Use the **`adr` skill** for any architectural choices, new libraries, or pattern changes.
4.  **Record New Assumptions**: Use the **`save-assumption` skill** for any technical or business assumptions (e.g., data format, API availability, user behavior).

### Phase 3: Technical Planning
1.  **UI Planning**: If the task involves frontend changes, new screens, or visual updates:
    *   **Exhaustive Identification**: Identify and list *all* required screens, views, states, and modals. Ensure no screen is left implied or undefined.
2.  **Backend/Logic Design**: Define the data models, database schema changes (tables, columns, indexes, constraints), code-level data structures (types/interfaces, DTOs), and API/integration contracts (endpoints, query parameters, headers, request/response payload schemas, error structures, webhooks/event schemas). **All defined data schemas, database changes, DTOs, and API/integration contracts MUST be explicitly captured and recorded in the `intent.md` artifact.**
3.  **Test Planning**: If the feature requires testing (e.g., new functionality, bug fixes with testable outcomes):
    *   Review the project testing strategy in `.memory/testing.md`.
    *   Invoke the **`generate-test-cases` skill** to produce detailed test case scenarios (unit, integration, and e2e) based on the requirements and strategy. Ensure the generated output is saved to `test-cases.md`.
4.  **Security Planning**: Invoke the **`assess-security` skill** to perform threat modeling and generate a security assessment based on the proposal and requirements.
5.  **PR & Deployment Strategy**: Divide the implementation tasks into distinct Pull Requests (PRs) where possible. Each PR MUST represent a collection of tasks that leads to an atomic, deployable, and functionally tested increment. This means there may be several distinct testing and validation phases across the overall implementation, with at least one per PR.

### Phase 4: Artifact Generation
All artifacts MUST be created in `.memory/specs/{feature-name}/` using kebab-case for the feature name.

Follow the structured specification conventions (defined in `.memory/specification-conventions.md` if available) within the feature directory. Typically, this involves creating or updating:
- `.memory/specs/{feature-name}/proposal.md`: Intent, Scope, and high-level Approach. Use the `assets/propose-template.md`.
- `.memory/specs/{feature-name}/intent.md`: Encoding of boundaries, constraints, validation rules, data schemas, DTOs, API/integration contracts, and measurable success criteria. Use the `assets/intent-template.md`.
- `.memory/specs/{feature-name}/security.md`: Threat modeling and security assessment generated in Phase 3.
- `.memory/specs/{feature-name}/test-cases.md`: Test case scenarios generated in Phase 3.
- `.memory/specs/{feature-name}/tasks.md`: A granular checklist of implementation steps. Use the `assets/tasks-template.md` for structuring tasks. You MUST explicitly include steps in this checklist to implement all test cases defined in `test-cases.md` using the **`write-tests` skill**. Organize these tasks clearly into the distinct PR phases identified in your PR & Deployment Strategy.

## Phase 5: Handoff & Approval (Strict)
1.  **STOP**: Once all artifacts (proposal, tasks, intent, security, test-cases) are generated, you MUST stop.
2.  **Present Results**: Summarize the created artifacts for the user.
3.  **Wait for Approval**: Do not perform any source code implementation. You must wait for explicit user approval of the plan or a separate directive to begin implementation.

## Assets
- `assets/propose-template.md`: Fallback template for unified implementation proposals.
- `assets/intent-template.md`: Template for capturing intent, boundaries, data schemas, API contracts, and success criteria.
- `assets/tasks-template.md`: Template for structured implementation task lists.
