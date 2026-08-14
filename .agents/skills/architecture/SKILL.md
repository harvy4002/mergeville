---
name: architecture
description: "Assists in defining, updating, and documenting the project's architecture. Use this skill when you need to create or update the system architecture overview (.memory/architecture.md)."
---

# Architecture Skill

This skill guides the process of documenting the project's architecture and recording major architectural decisions.

## Workflows

### Defining Project Architecture

When asked to define or document the project architecture for the first time:

1.  **Research & Discovery**: Proactively analyze the codebase (e.g., `package.json`, `requirements.txt`, directory structure, core libraries) to identify architectural patterns, technologies, and components.
2.  **Gather Information**: Present your findings to the user and ask for:
    *   Applied architectural patterns and layers (if not obvious).
    *   A high-level description of the system components and their interactions.
    *   Any specific technical constraints or future goals.
3.  **Generate `.memory/architecture.md`**:
    *   Use `assets/architecture-template.md` as a base.
    *   Include a **System Diagram** using the C4 model in [mermaid.js](https://mermaid.js.org/) syntax.
    *   Detail the **Tech Stack**, **Layers**, and **Key Patterns**.
    *   Ensure the file is saved to `.memory/architecture.md`.
4.  **Record Decisions & Assumptions**: 
    *   Use the `adr` skill to record any foundational architecture decisions discovered during this process.
    *   Use the `save-assumption` skill to record any technical or business assumptions that influence the architecture. Link these in `.memory/architecture.md`.

### Updating Project Architecture

When the system evolves or new components are added:

1.  **Surgical Update**: Edit `.memory/architecture.md` to reflect the changes in layers, patterns, or components.
2.  **Update Diagram**: Ensure the Mermaid.js system diagram is updated to include new services or modified interactions.
3.  **ADR & Assumption Reference**: 
    *   Update the ADR table in the architecture document to reference any new Architectural Decision Records.
    *   Update the Assumptions section (create if missing) to reference any new or resolved assumptions using the `save-assumption` skill.

## Assets

*   `assets/architecture-template.md`: Template for the main architecture document.
