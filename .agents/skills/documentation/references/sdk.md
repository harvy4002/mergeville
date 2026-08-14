# SDK Documentation Generation

This guide governs the generation of the SDK Technical Architecture Specification documents.

## Active Generation Instructions

1. **Locate the Templates**:
   - Access the template files under `skills/engineering/documentation/assets/sdk/`.
2. **Review the Compilation Order**:
   - Parse the `skills/engineering/documentation/assets/sdk/order` file to determine the correct sequence of files to generate.
3. **Instantiate and Populate Every Template**:
   - For each template file listed in `order`:
     - Load the template contents.
     - Extensively research the repository and the `.memory/` folder (referencing design documents, configuration files, API references, library architectures, and ADRs) to resolve and replace all `{{AI_FILL: ...}}` or `{{AI-FILL: ...}}` placeholders with deep, factual technical descriptions.
     - Save the completed file to `docs/architecture/<filename>` (using the exact filename from `order`).
4. **Output the Order File**:
   - Save the matching ordered list of filenames to `docs/architecture/order` to preserve compilation and merging sequences.
