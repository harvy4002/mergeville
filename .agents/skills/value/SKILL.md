---
name: value
description: Use to define whether a feature has enough value for an organisation to be taken through to development. Captures organizational value definitions, extends the product vision with a value rule set, and assesses features.
---

## Workflow

1. **Load Context**: 
   - Read the existing product vision from `.memory/product-vision.md` (output of the `vision` skill).
   - Read the relevant feature specification from `.memory/specs/[feature-name]/feature.md` (output of the `feature` skill) if a specific feature is being evaluated.
2. **Define Value**: 
   - Ask the user to define what "value" means to their organisation (e.g., revenue generation, cost savings, user growth, strategic alignment, compliance).
   - Establish a clear set of value drivers.
3. **Establish Value Rule Set**: 
   - Create a "Value Rule Set" based on the organization's definition of value to evaluate current and future features.
4. **Extend Product Vision**:
   - Update `.memory/product-vision.md` by appending a new section: `## Value Rule Set`. 
   - Document the defined organizational value and the rule set in this section to guide and refine future features.
5. **Feature Value Assessment**: 
   - Evaluate the specific feature against the Value Rule Set.
   - Determine a go/no-go recommendation for development based on the assessment.
6. **Capture Knowledge & Assumptions**:
   - Invoke the `save-knowledge` skill to record the agreed "Value Definition" and "Value Rule Set" into `.memory/knowledge/`.
   - Invoke the `save-assumption` skill to record any assumptions made about the feature's value, cost, or expected impact into `.memory/assumptions/`. Ensure these are linked in the assessment.
7. **Format Output**:
   - Load `assets/value-template.md`.
   - Write the completed Value Assessment to `.memory/specs/[feature-name]/value-assessment.md` (or `.memory/value-assessment.md` if not evaluating a specific feature).
   - Use professional, clear language suitable for alignment among product and business stakeholders.
