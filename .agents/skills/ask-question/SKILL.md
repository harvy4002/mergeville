---
name: ask-question
description: Scans .memory, docs, and other relevant folders to answer user questions based strictly on repository information. Use when a user asks a question about project processes, local setup, assumptions, or existing documentation.
---

# Ask Question

## Overview

This skill enables accurate, grounded answers to questions about the project by systematically searching and analyzing the repository's documentation and memory files.

## Guidelines

To provide a high-quality answer, follow these guidelines:

### 1. Document Discovery

Identify relevant documents by searching the following directories:
- `.memory/` (for project-specific notes and private memory)
- `docs/` (for official project documentation)
- `skills/` (for procedural knowledge defined in skills)
- Any other folder that appears relevant to the user's query (e.g., `src/`, `scripts/`).

Use `glob` and `grep_search` to find markdown (`.md`) files.

### 2. Relevance Assessment via Frontmatter

When scanning documents, prioritize reading the YAML frontmatter. Look for:
- `title`: The main subject of the document.
- `tags` or `keywords`: Indicators of the document's content.
- `description`: A brief summary of the file's purpose.

Use these fields to quickly filter for the most relevant documents before reading the full content.

### 3. Grounded Synthesis

Your answer MUST be 100% grounded in the information found within the repository.
- **Cite Sources:** Mention which file(s) provided the information.
- **No Hallucinations:** Do not use general external knowledge or assume project details not explicitly documented.
- **Handle Missing Information:** If the answer cannot be found in the repository, explicitly state: "I could not find information regarding [topic] in the repository's documentation or memory." Do not attempt to guess.

## Example Workflow

1. **User asks:** "How do I setup the local development environment?"
2. **Agent action:**
   - Search for `setup`, `install`, `environment` in `docs/` and `.memory/`.
   - Find `docs/setup-guide.md` and `.memory/local-dev-notes.md`.
   - Read frontmatter of both files.
   - Read content of the most relevant sections.
3. **Agent response:** "To setup the local environment, follow these steps from `docs/setup-guide.md`: [Steps...]. Additionally, a note in `.memory/local-dev-notes.md` mentions: [Note...]."
