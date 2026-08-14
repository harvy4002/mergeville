---
name: design-guidelines
description: "Assists in defining, updating, and documenting the project's UI and content design guidelines and constraints. Use this skill when you need to create or update the design overview (.memory/design-guidelines.md)."
---

# Design Guidelines Skill

This skill guides the process of documenting the project's visual identity, UI constraints, content strategy, and accessibility requirements.

## Workflows

### Defining Design Guidelines

When asked to define or document the project design guidelines for the first time:

1.  **Research & Discovery**: Proactively analyze the codebase (e.g., CSS/SCSS files, Tailwind configs, component libraries, image assets) to identify existing design patterns, color palettes, and typography. Also evaluate if Storybook or an external design system (e.g., Material UI, Ant Design, GDS Design System) is being used.
2.  **Gather Information**: Present your findings to the user and ask for:
    *   Desired "vibe" or aesthetic goals (e.g., modern, professional, playful).
    *   Target audience and primary device focus (mobile-first, desktop, etc.).
    *   Content tone of voice preferences.
    *   Any specific brand requirements or accessibility targets (e.g., WCAG 2.1 AA).
    *   **Confirmation of Tooling**: If you cannot definitively determine if Storybook or an external design system is in use from the codebase, you MUST ask the user. Also check if the service is based on the **GDS Design System**.
3.  **Generate `.memory/design-guidelines.md`**:
    *   If the service is based on the **GDS Design System**, use `assets/gds-design-guidelines.md` as a base reference for all GDS-specific standards, constraints, and component rules.
    *   Otherwise, use `assets/design-guidelines-template.md` as a base.
    *   Detail the **Design Principles**, **UI Constraints** (colors, type, spacing), **Content Strategy**, and **Accessibility** requirements.
    *   Ensure the file is saved to `.memory/design-guidelines.md`.

### Updating Design Guidelines

When the UI evolves or new branding/content rules are established:

1.  **Surgical Update**: Edit `.memory/design-guidelines.md` to reflect the changes in colors, typography, or content tone.
2.  **Consistency Check**: Ensure that new components or features documented elsewhere align with these updated guidelines.

## Assets

*   `assets/design-guidelines-template.md`: Template for the main design guidelines document.
*   `assets/gds-design-guidelines.md`: Generalised reference guidelines for services based on the GDS Design System.
