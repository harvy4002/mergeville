# mergeville

This workspace is equipped with specialized AI agent skills located in `.agents/skills/` to manage a full end-to-end Software Development Life Cycle (SDLC).

## The `.memory` Directory
The `.memory` folder is the central repository for project context, decisions, and knowledge. All skills interact with this directory to maintain continuity.
- `.memory/assumptions/`: Tracked via the `assumption` skill.
- `.memory/decisions/`: Tracked via the `adr` skill.
- `.memory/specs/{feature-name}/`: Feature-specific specifications, implementation plans, and mockups.
- `.memory/knowledge/`: General project knowledge and insights.
- `.memory/reports/`: Generated reports, security assessments, performance reviews.

## SDLC Skills Workflow

1. **Phase 1: Initialization & Discovery**
   - **`setup`**: Initializes the `.memory` directory and orchestrates the creation of core project artifacts.
   - **`vision`**: Defines the product vision (`.memory/product-vision.md`) and records business assumptions.
   - **`architecture`**: Documents the system design (`.memory/architecture.md`) and records technical decisions (ADRs).
   - **`design-guidelines`**: Establishes visual and UI constraints (`.memory/design-guidelines.md`).
   - **`test-strategy`**: Outlines the testing approach and strategy (`.memory/test-strategy.md`).

2. **Phase 2: Design & Planning**
   - **`feature`**: For each feature, generates detailed specifications and task breakdowns in `.memory/specs/{feature-name}/`.
   - **`propose`**: Use this skill to propose system changes and feature developments.
   - **`design`**: Generates static HTML/CSS mockups or Storybook screens based on vision and guidelines, producing a `design-plan.md
3. **Phase 3: Implementation**
   - **`implement`**: Systematically executes the task list and specifications generated in Phase 2, adhering unified plan conventions.

4. **Continuous Tracking Skills**
   - **`finalise`**: Use this skill to finalise an implementation to update the `.memory` contents. It calls the following skills.
   - **`save-assumption`**: ALWAYS use this skill to record new business or technical assumptions in `.memory/assumptions/`.
   - **`adr`**: ALWAYS use this skill to formalize architectural choices in `.memory/decisions/`.
   - **`save-knowledge`**: Use this skill to document any relevant project knowledge or insights in `.memory/knowledge/`.

## Assistant Guidelines
- ALWAYS read relevant `.memory` documents before taking action or continuing an SDLC phase.
- Ensure strict alignment between implementation plans, the documented `architecture`, and `design-guidelines`.
- Whenever a detail is missing, make a reasonable assumption and explicitly record it using the `assumption` skill.
