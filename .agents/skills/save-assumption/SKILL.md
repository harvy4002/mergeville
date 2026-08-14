---
name: save-assumption
description: "Assists in creating, updating, and reviewing project assumptions. Use this skill to record assumptions made during design, architecture, or planning phases in .memory/assumptions/"
---

When an assumption needs to be recorded, updated, or reviewed:

1. **Gather Context**: Identify what is being assumed, why it is being assumed, and which requirement (REQ-xxx) or document (vision, architecture, etc.) it relates to.
2. **Generate Assumption Reference**:
   Run the following command to securely increment the counter and generate a zero-padded reference number (e.g., 001):
   ```bash
   mkdir -p .memory/.state
   CURRENT=$(cat .memory/.state/.assume-count 2>/dev/null || echo "0")
   NEXT=$((CURRENT + 1))
   echo $NEXT > .memory/.state/.assume-count
   printf "%03d\n" $NEXT
   ```
3. **Draft the Assumption**:
   - Use the template at `assets/assumption-template.md`.
   - Set `status` to `unresolved` by default for new assumptions.
   - Set `created` to the current date (YYYY-MM-DD).
   - Format the filename as `.memory/assumptions/ASSUME-{ref}-{kebab-case-title}.md` (e.g., `ASSUME-001-user-login-method.md`).
4. **Cross-Reference**:
   - Add a link to the new assumption (using its ID and file path) in the document currently being worked on (e.g., `vision.md`, `architecture.md`, or a technical implementation plan).
5. **Update or Resolve an Assumption**:
   - When an assumption is validated or invalidated, strictly modify the existing file.
   - Change `status` to `validated` or `invalidated`.
   - Set `resolved` to the current date (YYYY-MM-DD).
   - Fill in the `## Resolution` section with details on how it was verified.

## Assets

- `assets/assumption-template.md`: Template for Project Assumptions.
