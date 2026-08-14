---
name: vision
description: Use to create a high-level Product Vision Document. Do NOT use to define specific features or sprint goals.
---

Given the **product vision**, create a **complete Product Vision Document** using the Markdown template.

## Instructions

1. Load and review `assets/vision-template.md` 
2. Ask the user for the following inputs **before generating the document**:
    - A clear **product vision or short product description**  
    - The **intended audience** for the document (e.g. internal stakeholders, cross-functional teams, leadership)  
    - The **current maturity stage** (e.g. concept, discovery, alpha, beta, live)  
    - Any **constraints** (e.g. technical, legal, policy, resourcing)
3. Where specific details are missing, make **realistic, evidence-based assumptions** grounded in product management best practice. Record these assumptions using the `save-assumption` skill. Link the assumptions in the vision document.
4. If you need further information ask the user at MOST 3 clarifying questions
5. Use professional, clear language that would be suitable for alignment among product, design, and policy stakeholders.

## Output Format
The output should be a markdown document following the structure of the `vision-template.md` asset, with the relevant sections populated based on the user input and any assumptions you had to make. The final document should be saved to `.memory/product-vision.md`.

