---
name: finalise
description: Review a feature defined by 'propose' and built by 'implement' to reconcile assumptions, update documentation, and capture lessons learned. Use this skill when a feature implementation is complete and ready for final documentation and knowledge persistence.
---

# Finalise Feature

This skill provides a structured workflow to wrap up a feature implementation. It ensures that the project's long-term memory and documentation reflect the final state of the work and the lessons learned during development.

## Workflow

Follow these steps to finalise a feature:

### 1. Review Feature Implementation
Analyze the original feature definition `.memory/specs/[feature-name]/feature.md`, each of the generated specification files `.memory/specs/[feature-name]/[spec-name]-spec.md`, the intent `.memory/specs/[feature-name]/intent.md`, the final implementation (from the `implement` skill), and the planned test scenarios (`test-cases.md`). Compare the intended design and functionality with the actual outcome, ensuring that all test cases and edge cases were successfully addressed and verified.

### 2. Reconcile Assumptions
Identify any assumptions made during the proposal or implementation phases (check `propose-template.md` outputs or project logs). Update the status of each assumption to one of the following:
- **Validated**: The assumption was confirmed as true.
- **Invalidated**: The assumption was proven false.
- **Unresolved**: The assumption remains uncertain.

### 3. Update Core Documentation
Review and propose updates to the following files to align them with the final implementation:
- **.memory/architecture.md**: Update system-level architectural diagrams, component relationships, or data flows.
- **.memory/design-guidelines.md**: Update UI/UX patterns, component mappings, or styling guidelines.

### 4. Update Feature Status
Update the **Status** field in `.memory/specs/[feature-name]/feature.md` (e.g., from Draft to Completed) to reflect that the feature implementation and review have been finalised.

### 5. Capture Knowledge
Identify notable lessons learned, technical insights, or recurring patterns discovered during this feature's lifecycle, including any knowledge that may be captured in the `.memory/bugs` folder. Record this knowledge using the `save-knowledge` skill.

### 6. Compact and Rationalise Memory
Review the contents of the `.memory/knowledge/` and `.memory/assumptions/` folders. Compact and rationalise the information within these folders to ensure they do not contain any duplicated information. This ensures that the information in the context remains accurate and concise.
