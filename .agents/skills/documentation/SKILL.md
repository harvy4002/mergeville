---
name: documentation
description: Use to generate documentation. Do NOT use to write ADRs or code comments or commits.
---

# Documentation

The documentation for this project is available in the `docs/` directory. It uses GitHub-flavored markdown and follows the Diátaxis framework for systematic documentation.

## Diátaxis Framework

Documentation must be organized into four distinct types, each serving a specific purpose:

### 1. Tutorials (Learning-Oriented)

**Purpose**: Guide beginners through achieving a specific outcome to build confidence.

- Start with what the user will build or achieve
- Provide a clear, step-by-step path from start to finish
- Include concrete examples and working code
- Assume minimal prior knowledge
- Focus on the happy path (avoid edge cases and alternatives)
- End with a working result the user can see and use
- Use imperative mood: "Create a file", "Run the command"
- **Use `.memory`**: Leverage outputs from the `feature` and `propose` skills to identify core "happy paths" and key user journeys to form the foundation of tutorials.

**Avoid**: Explaining concepts in depth, multiple options, troubleshooting

### 2. How-to Guides (Goal-Oriented)

**Purpose**: Show how to solve a specific real-world problem or accomplish a particular task.

- Title format: "How to [accomplish specific goal]"
- Assume the user knows the basics
- Focus on practical steps to solve one problem
- Include necessary context but stay focused
- Show multiple approaches only when genuinely useful
- End when the goal is achieved
- Use imperative mood: "Configure the setting", "Add the following"
- **Use `.memory`**: Extract practical problem-solving steps by reviewing user acceptance criteria, test cases, and feature requirements defined by the `feature` skill.

**Avoid**: Teaching fundamentals, explaining every detail, being exhaustive

### 3. Reference (Information-Oriented)

**Purpose**: Provide accurate, complete technical descriptions of the system.

- Organized by structure (CLI commands, configuration options, API endpoints)
- Comprehensive and authoritative
- Consistent format across all entries
- Technical accuracy is paramount
- Include all parameters, options, and return values
- Use descriptive mood: "The command accepts", "Returns a string"
- Minimal narrative or explanation
- In addition to standard reference documents, generate the comprehensive Technical Architecture Specification using the **Technical Architecture Specification Workflow** defined below.
- Select the appropriate asset templates and guidance using:
  - If [documentation_type] is equivalent to `SDK` use the guidance in `references/sdk.md`
  - For [documentation_type] is equivalent to `Mobile Application` use the guidance in `references/mobile-application.md`
  - For any other [documentation_type] use the guidance in `references/default.md`

**Avoid**: Instructions, tutorials, opinions on usage

### 4. Explanation (Understanding-Oriented)

**Purpose**: Clarify and illuminate topics to deepen understanding.

- Discuss why things are the way they are
- Explain design decisions and tradeoffs
- Provide context and background
- Connect concepts to help form mental models
- Discuss alternatives and their implications
- Use indicative mood: "This approach provides", "The engine uses"
- **Use `.memory`**: Synthesize the "why" behind the system by referencing Architectural Decision Records (ADRs), technical designs from the `propose` skill, and threat models.

**Avoid**: Step-by-step instructions, exhaustive reference material

## Technical Architecture Specification Workflow

When asked to generate documentation, you must also output the Technical Architecture Specification alongside the standard Diátaxis framework files. Follow these structured steps:

1. **Determine the Application/SDK Category**:
   - Determine if the project is an `SDK`, `Mobile Application`, or standard/generic service (using `documentation_type` or context clues in the codebase).
   - Locate the corresponding template folder under `skills/engineering/documentation/assets/` (`sdk`, `mobile`, or `default`).

2. **Establish the Output Directory**:
   - Create a dedicated subdirectory for these files: `docs/architecture/` (this prevents mixing architecture specifications with standard Diátaxis docs).

3. **Read and Parse the Template Order**:
   - Locate the `order` file in the chosen templates directory (e.g., `assets/default/order`). This file lists the exact sequence of template files that must be generated.

4. **Iterate, Analyze, and Populate Templates**:
   - For every template listed in the `order` file:
     - Load the template file from the corresponding assets folder (e.g., `skills/engineering/documentation/assets/default/high-level-Architecture.md`).
     - Scan the codebase and analyze the `.memory/` directory to replace all `{{AI_FILL: ...}}` or `{{AI-FILL: ...}}` placeholders with deep, accurate, project-specific factual explanations. Do NOT leave any `AI_FILL` placeholders unresolved or generic.
     - Save the fully populated document to `docs/architecture/<filename>` (using the exact filename specified in `order`).

5. **Provide the Compilation Order File**:
   - Write the sequence of generated filenames to `docs/architecture/order`. This allows any downstream processes (such as automated doc compilers) to build the documents in the correct order.

## Knowledge Management Integration

Before generating or updating documentation, review the `.memory` directory located in the project root. This directory contains accumulated knowledge, architectural decisions, and project state managed by the `feature`, `propose`, `implement`, and `finalise` skills. Actively incorporate any relevant context from these files into your documentation to ensure accuracy and completeness.

Specifically, use the `feature` skill's intended outcomes and stories for non-technical tutorials and guides, and the `propose` skill's design decisions (like ADRs) for explanatory documentation.

## General Style Guidelines

- **Tone**: Neutral, technical, not promotional
- **Voice**: Avoid "we", "our", "us" (use "the tool", "this command")
- **Headings**: Use markdown heading syntax, not bold text as headings
- **Lists**: Avoid long bullet point lists; prefer prose with structure
- **Code samples**: Minimal and focused; exclude optional fields unless relevant
- **Language tag**: Use `aw` for agentic workflow snippets with YAML frontmatter

**Example workflow code block**:

```aw wrap
on: push
# Your workflow steps here
```

## GitHub-Flavored Markdown Syntax

Documentation files use GitHub-flavored markdown. Key syntax elements:

### Frontmatter

Every documentation page must have frontmatter:

```markdown
title: Page Title
description: Brief description for SEO and navigation
```

**Remember**: Keep components minimal. Prefer standard markdown when possible.

## Content to Avoid

- "Key Features" sections
- Marketing language or selling points
- Excessive bullet points (prefer structured prose)
- Overly verbose examples with all optional parameters
- Mixing documentation types (e.g., tutorials that become reference)

## Avoiding Documentation Bloat

Documentation bloat reduces clarity and makes content harder to navigate. Common types of bloat include:

### Types of Documentation Bloat

1. **Duplicate content**: Same information repeated in different sections
2. **Excessive bullet points**: Long lists that could be condensed into prose or tables
3. **Redundant examples**: Multiple examples showing the same concept
4. **Verbose descriptions**: Overly wordy explanations that could be more concise
5. **Repetitive structure**: The same "What it does" / "Why it's valuable" pattern overused

### Writing Concise Documentation

When editing documentation, focus on:

**Consolidate bullet points**:

- Convert long bullet lists into concise prose or tables
- Remove redundant points that say the same thing differently

**Eliminate duplicates**:

- Remove repeated information
- Consolidate similar sections

**Condense verbose text**:

- Make descriptions more direct and concise
- Remove filler words and phrases
- Keep technical accuracy while reducing word count

**Standardize structure**:

- Reduce repetitive "What it does" / "Why it's valuable" patterns
- Use varied, natural language

**Simplify code samples**:

- Remove unnecessary complexity from code examples
- Focus on demonstrating the core concept clearly
- Eliminate boilerplate or setup code unless essential for understanding
- Keep examples minimal yet complete
- Use realistic but simple scenarios

### Example: Before and After

**Before (Bloated)**:

```markdown
### Tool Name
Description of the tool.

- **What it does**: This tool does X, Y, and Z
- **Why it's valuable**: It's valuable because A, B, and C
- **How to use**: You use it by doing steps 1, 2, 3, 4, 5
- **When to use**: Use it when you need X
- **Benefits**: Gets you benefit A, benefit B, benefit C
- **Learn more**: [Link](url)
```

**After (Concise)**:

```markdown
### Tool Name
Description of the tool that does X, Y, and Z to achieve A, B, and C.

Use it when you need X by following steps 1-5. [Learn more](url)
```

### Documentation Quality Guidelines

1. **Preserve meaning**: Never lose important information
2. **Be surgical**: Make precise edits, don't rewrite everything
3. **Maintain tone**: Keep the neutral, technical tone
4. **Test locally**: Verify links and formatting are still correct

## Structure by File Type

- **Getting Started**: Tutorial format
- **How-to Guides**: Goal-oriented, one task per guide
- **CLI Reference**: Reference format, complete command documentation
- **Concepts**: Explanation format, building understanding
- **API Reference**: Reference format, complete API documentation
