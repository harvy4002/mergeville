---
name: adr
description: "Assists in creating architecture decision records. Use this skill when you need to record architectural decisions (ADRs) in .memory/decisions/"
---

When an architectural decision needs to be recorded:

1. **Gather Context**: Discuss the problem, options considered, and the chosen solution with the user, only if it isn't available from the existing context.
2. **Generate ADR Reference**:
   Run the following command to securely increment the counter and generate a zero-padded reference number (e.g., 0001):
   ```bash
   mkdir -p .memory/decisions
   CURRENT=$(cat .memory/.state/.adr-count 2>/dev/null || echo "0")
   NEXT=$((CURRENT + 1))
   echo $NEXT > .memory/.state/.adr-count
   printf "%04d\n" $NEXT
   ```
3. **Draft the ADR**:
   - Use the template at `assets/adr-template.md`.
   - Format the filename as `.memory/decisions/ADR-{ref}-{kebab-case-title}.md` (e.g., `ADR-0001-migrate-to-postgresql.md`).
4. **Link in Architecture Document**:
   - Add a link to the new ADR in the `## ADRs` section of `.memory/architecture.md`. If the file or section does not exist, create it.

*Note: If the user asks to update an ADR, strictly modify the `Status` field (e.g., Draft -> Accepted, or Accepted -> Superseded by ADR-XXXX) rather than rewriting history.*

## Assets

- `assets/adr-template.md`: Template for Architectural Decision Records.
