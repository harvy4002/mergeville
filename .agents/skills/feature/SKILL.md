---
name: feature
description: "Creates high-level product feature specifications from a vision, including EARS requirements, user scenarios, and success criteria. Do NOT use to plan technical architecture, database schemas, APIs, test code, or implementation tasks, which belong to the 'propose' and 'implement' skills."
---

# Feature Skill

**STRICT MANDATE: This skill is for PRODUCT-LEVEL FUNCTIONAL SPECIFICATION ONLY. Do NOT plan technical architecture, database schemas, API contracts, code-level types, threat modeling, or specific unit/integration/e2e test cases (which belong to the `propose` skill). Do NOT write or modify application source code, or execute implementation steps (which belong to the `implement` skill).**

Use this skill to transform a raw product idea, vision, or feature request into a structured, customer-facing product specification. 

## Workflow

1. **Load Context**: Read `.memory/product-vision.md` and any high-level design or architectural guidelines to understand the product direction and overall technical landscape.
2. **Generate Name**: Create a concise 2-4 word short name for the feature in action-noun format (e.g., "add-user-auth"). Preserve well-known technical/business standards (e.g., "OAuth2", "API") if relevant to the product.
3. **Analyze Requirements**: Identify key business concepts, actors (user personas), core business data, and functional constraints from the user input.
4. **Address Uncertainty**: Make informed product-level assumptions for uncertain aspects based on industry standards. Mark critical functional, business, or UX ambiguities with `[CLARIFICATION NEEDED]` (maximum 5). Do NOT ask technical questions about database tables, frameworks, or code-level architecture.
5. **Define Scenarios**: Generate detailed user scenarios (user journeys) and high-level acceptance criteria (expected user-visible behavior). Do NOT generate technical test cases, test suites, or code-level testing assertions.
6. **Break Down Feature**: If the feature request is large, break it down into sub-features. Each sub-feature MUST represent a user-visible, independently deployable slice of functionality.
7. **Generate Requirements**: Produce testable, functional requirements using **EARS (Easy Approach to Requirements Syntax)**.
8. **Define Success Criteria**: Establish measurable, technology-agnostic outcomes (both quantitative and qualitative) focusing on user or business value (e.g., user completion rate, performance limits as a business requirement), rather than technical performance benchmarks.
9. **Map Entities**: Identify and define key business/domain entities involved in the feature (e.g., "Order", "Product", "Subscription") and their conceptual relationships. Do NOT define database tables, columns, data types, or database-specific constraints.
10. **Assess Value**: Invoke the `value` skill to evaluate the value of the feature against the product vision and business goals.
11. **Persist Backlog**: If available, invoke specialized tools to save the feature into external tracking systems (Jira, GitHub Issues, Azure Devops-ADO etc.).
12. **Format Output**: 
    *   Load `assets/feature-template.md` and `assets/spec-template.md`. 
    *   Write the feature overview to `.memory/specs/[feature-name]/feature.md` using `assets/feature-template.md`.
    *   For each sub-feature or logical requirement set, generate an individual specification at `.memory/specs/[feature-name]/[spec-name]-spec.md` using the `assets/spec-template.md`.
    *   Ensure the generated `feature.md` explicitly links to all generated specification files.
    *   Use kebab-case for all file and directory naming.
13. **Resolve Ambiguity**: Present up to 5 critical `[CLARIFICATION NEEDED]` items to the user in a table format. Wait for the user to answer, then update the specification with the provided answers and record the questions and answers in the "Decisions & Clarifications" section of the `feature.md` file.
