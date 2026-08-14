---
name: init-project
description: Initialises the repository. Do NOT use if a `.memory` folder already exists
---

## 1. Context Discovery & Inference

If this skill is being run in an existing project (e.g., files or directories already exist), proactively analyze the codebase (like `package.json`, `README.md`, infrastructure files, existing code, or UI components) to infer as much information as possible about the items listed in the "Gather Project Context" section.

Replay your inferred findings back to the user for their review and feedback.

## 2. Gather Project Context

Conduct an interview with the user to gather any missing information that could not be inferred or needs clarification. Group your questions coherently into the following categories. Do not ask for information you have already confidently inferred and the user has confirmed.

### General & Product Context
* **Project Name**
* **Product Vision / Aim** - A short description of the product vision and what the project is trying to achieve.
* **Project Scope** - What is in and out of scope.
* **Intended Audience** - Who is the primary audience for the project documentation (e.g., internal stakeholders, cross-functional teams, leadership)?
* **Current Maturity Stage** - E.g., concept, discovery, alpha, beta, live.
* **Target Users & Devices** - Who is the target user base and what is the primary device focus (e.g., mobile-first, desktop)?

### Technical & Architecture
* **Technology Stack** - Languages, Frameworks, Databases, APIs, Cloud Providers, Infrastructure as code, etc.
* **Architecture Patterns** - Applied patterns (e.g., Modular Monolith, Microservices, Layered) and high-level system components and their interactions.
* **Target Environments & CI/CD** - Details on the deployment environments, CI/CD pipeline, and path to live.
* **Future Goals** - Any specific technical or architectural future goals.

### Design & User Experience
* **Aesthetic Goals** - Desired "vibe" or visual style (e.g., modern, professional, playful).
* **Tone of Voice** - Content tone of voice preferences.
* **Branding, Tooling & Accessibility** - Specific brand requirements, accessibility targets (e.g., WCAG 2.1 AA), and confirmation of UI tooling/design systems (e.g., Storybook, Material UI, Tailwind, or if it is based on the GDS Design System).

### Quality & Constraints
* **Constraints** - Any technical, legal, policy, or resourcing constraints the service must comply with.
* **Testing Goals & Regulations** - Specific testing goals, compliance, or regulatory requirements.
* **Mocking & Test Access** - Mocking strategies and access requirements for different testing levels.

## 3. Execute Documentation Skills

Once you have gathered and confirmed all the necessary context from the user, execute the following skills to generate the foundational documentation:

1. Run the `vision` skill to define/document the product vision.
2. Run the `architecture` skill to define/document the systems architecture.
3. Run the `design-guidelines` skill to define/document the design guidelines.
4. Run the `test-strategy` skill to define/document the testing strategy.

## 4. Final Setup

* Create `.memory/specification-conventions.md` using the `assets/specification-conventions.md` template to document the structured specification workflow.
