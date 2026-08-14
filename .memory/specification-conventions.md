# Structured Specification Conventions

These conventions define the workflow and artifact structure for planning and implementing features or bug fixes within this repository.

## Directory Structure
All specification artifacts for a given feature or bug fix must be contained within a dedicated directory:
`.memory/specs/{feature-name}/`
where `{feature-name}` is the kebab-cased name of the feature or bug.

## Required Artifacts
The following artifacts are typically generated during the planning phase (using the `propose` skill):

- `proposal.md`: (Required) A high-level overview of the intent, scope, and technical approach.
- `intent.md`: (Required) A formal definition of the rigid boundaries, technical constraints, validation rules, and measurable success criteria.
- `tasks.md`: (Required) A granular, actionable checklist of implementation steps.
- `test-cases.md`: (Required) Detailed manual and automated test case scenarios.
- `security.md`: (Required) Threat modeling and security assessment results.
- `design-plan.md`: (Optional) UI component blueprint or design specifications.

## Workflow
1.  **Planning**: Use the `propose` skill to gather context, extract knowledge, and generate the required artifacts in the feature directory.
2.  **Review & Approval**: The implementation plan (proposal and tasks) should be reviewed and approved before any code changes are made.
3.  **Implementation**: Use the `implement` skill to systematically execute the tasks defined in `tasks.md`, strictly adhering to the constraints in `intent.md`.
4.  **Validation**: Verify the implementation against the success criteria and validation rules defined in `intent.md` and the test cases in `test-cases.md`.
