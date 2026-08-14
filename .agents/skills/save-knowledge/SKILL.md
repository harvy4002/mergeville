---
name: save-knowledge
description: Record important knowledge, lessons learned, or technical insights to the project's persistent knowledge base. Use this skill when a significant technical decision is made, a bug root cause is identified, or a specific implementation pattern is established that should be preserved for future reference.
---

# Save Knowledge

This skill provides a standardized way to capture and store knowledge in the project's knowledge base located in `.memory/knowledge/`.

## Workflow

To save a new piece of knowledge, follow these steps:

1.  **Identify the Knowledge**: Determine the title, component, domain, and tags for the knowledge being recorded.
2.  **Determine the Next ID**:
   Run the following command to securely increment the counter and generate a zero-padded reference number (e.g., 0001):
   ```bash
   mkdir -p .memory/knowledge
   CURRENT=$(cat .memory/.state/.kb-count 2>/dev/null || echo "0")
   NEXT=$((CURRENT + 1))
   echo $NEXT > .memory/.state/.kb-count
   printf "%04d\n" $NEXT
   ```
3.  **Prepare the Content**:
    - Use the template found in `assets/knowledge-template.md`.
    - Fill in the frontmatter:
        - `id`: The `KB-NNN` ID.
        - `title`: A concise, descriptive title.
        - `component`: The specific area (e.g., "API/auth").
        - `domain`: The broad area (e.g., "engineering").
        - `tags`: Relevant keywords.
        - `created`: Today's date (YYYY-MM-DD).
        - `updated`: Today's date (YYYY-MM-DD).
    - Complete the sections: **What Happened**, **Key points**, **Why It Matters**, and **Applies When**.
4.  **Save the File**:
    - Format the filename as `KB-NNN-{short-description}.md`.
    - Use kebab-case for the `{short-description}`.
    - Save the file to the `.memory/knowledge/` directory.

## Resources

### assets/
- **knowledge-template.md**: The standard markdown template for all knowledge base entries.
