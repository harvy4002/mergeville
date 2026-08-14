---
name: design
description: A comprehensive design skill that handles UI mockup generation, Storybook screen composition, and UI implementation planning. Adapts to project constraints including the presence of Storybook or design systems like GDS (GOV.UK Design System).
---

# Design Skill

This skill unifies the workflows for generating UI mockups, composing Storybook stories, and creating technical implementation plans. It automatically adapts its approach based on the project's environment (e.g., if Storybook is used or if a specific design system like GDS is in place).

## Core Workflow

### 1. Pre-flight Check (Constraints & Environment)
Before generating any mockup or plan, you MUST understand the environment you are building in.
- Silently read `.memory/architecture.md` and `.memory/design-guidelines.md` if they exist.
- Identify the framework (React, Vue, etc.), styling approach (Tailwind, Vanilla CSS, Framework-specific like GDS), and state management.
- Detect if **Storybook** is present in the project.
- **Component Discovery**: Use `glob` and `grep_search` to find existing component folders (e.g., `src/components`, `ui/`, or Storybook stories). Catalog available components to maximize reuse and prevent duplication.

### 2. Information Gathering
If the user's request is underspecified, ask for:
- **Target Screen/Feature**: What is being built? Identify and generate designs for *all* individual screens, states, and modals involved in the feature.
- **Device Formats**: Mobile (iOS/Android), Tablet, Desktop, or Responsive?
- **Stylistic Overrides**: Any specific preferences not in `design-guidelines.md`?

### 3. Step 1: Generate `design-plan.md`
Create a `.memory/specs/{feature-name}/design-plan.md` (where `{feature-name}` is kebab-cased) using the `assets/design-plan-template.md`. This document serves as the unified visual and technical blueprint.
- **Visual Design**: Detailed component breakdown, layout strategy (Flex/Grid), breakpoint-specific behaviors, and styling constants.
- **Technical Implementation**: Component hierarchy mapping, state management strategy, proposed file changes, and sequential implementation phases.
- **Assumptions**: Use the `save-assumption` skill to record any assumptions about user behavior, data structures, or edge cases. Link these in the design plan.

### 4. Step 2: Generate Mockups or Compose Screens
Depending on the project environment, proceed with one of the following approaches:

#### Approach A: Storybook Composition (If Storybook is detected)
Prioritize using existing components to compose screen-level Storybook stories.
- **Creation Permission:** If a design requirement cannot be met using existing components, you MUST explicitly ask the user for permission before creating new components.
- **Updates:** If existing components need modifications to fulfill requirements, you MUST explicitly ask the user for permission before updating them.
- **True Components:** Any new component created must be a **true** component, treated as if it were part of the design system. It MUST be fully abstracted into a `components` folder and not built inline within the screen or page.
- Create the Storybook story file (e.g., `*.stories.tsx`) and give the story title a `Screens/` prefix.

#### Approach B: Standalone HTML Mockups (If no Storybook, e.g., GDS or custom UI)
Create standalone HTML files in the `.memory/specs/{feature-name}/mockups/` directory (e.g., `.memory/specs/{feature-name}/mockups/feature-mobile.html`).
- **iOS/Android**: Use standard viewports and add fake device frames/bezels. Reference `references/device_frames.md`.
- **Responsive**: Use standard browser breakpoints and adaptive layouts. Reference `references/layout_patterns.md`.
- **External Frameworks (e.g., UNPKG, GDS)**: If utilizing a CSS framework from a CDN like UNPKG (e.g., GOV.UK Frontend) that relies on root-relative URLs, you MUST NOT link to the CSS directly in the HTML. Instead:
    1. Download the CSS file locally (e.g., into a `stylesheets/` folder).
    2. Perform a find-and-replace to rewrite the unquoted relative paths to absolute UNPKG URLs.
    3. Update the HTML mockup to point to this patched local stylesheet.
    4. Ensure any JavaScript from the CDN uses the absolute UNPKG URL.

### 5. Step 3: Persist Design Decisions
If new design decisions or constraints were established during this task (e.g., a specific shadow depth, a new primary color variation, or a reusable component pattern):
- Update `.memory/design-guidelines.md` with these details to ensure consistency in future tasks.

## Reference Materials
- [Device Viewports & Frames](references/device_frames.md): Common dimensions for iPhone, Pixel, etc.
- [Layout Patterns](references/layout_patterns.md): Best practices for responsive and mobile-first design.
- [Design Plan Template](assets/design-plan-template.md): The standard structure for visual and technical blueprints.
- [Component Mapping Patterns](references/component_mapping_patterns.md): Best practices for translating UI to component architectures.
