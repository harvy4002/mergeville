# GDS Service — Design Guidelines

> This document is the canonical design reference for the project. Every AI agent skill reads it before generating or reviewing UI. When in doubt, this file is the tiebreaker.
>
> All rules in this document are sourced directly from the GDS Design System (https://design-system.service.gov.uk) or the GOV.UK Component Guide (https://components.publishing.service.gov.uk/component-guide). Where gaps exist that are not covered by any official source, they should be explicitly flagged as **[DECISION NEEDED]**.

---

## 1. Design Philosophy

This is a government service. Users arrive with a specific task or need for information, often feeling anxious, time-pressured, or on a mobile device.

The restraint of the GDS design language is a deliberate signal of authority, calm, and trustworthiness. Every design decision must serve that signal. Do not reach for visual complexity to solve a content problem.

---

## 2. Design System Reference

All UI must be built using components, tokens, and patterns from these systems, in this order of priority:

1. **GDS Design System** — https://design-system.service.gov.uk
2. **GOV.UK Component Guide** — https://components.publishing.service.gov.uk/component-guide (for publishing-specific patterns such as the contents list)
3. **Departmental Design Systems** — Any specific departmental extensions (e.g., DfE, MOJ) take precedence over GDS only when explicitly required by the project.

---

## 3. Colour

*Source: https://design-system.service.gov.uk/styles/colour/*

All colour must come from GDS design tokens. Never hardcode hex values in component code.

### GDS functional colour tokens

| Token | Hex | Use |
|---|---|---|
| `text` | `#0b0c0c` | All body text |
| `secondary-text` | `#484949` | Supporting / meta text |
| `body-background` | `#ffffff` | Page background |
| `link` | `#1a65a6` | Default link colour |
| `link-hover` | `#0f385c` | Link hover state |
| `link-visited` | `#54319f` | Visited link state |
| `focus` | `#ffdd00` | Focus ring only — never use for any other purpose |
| `focus-text` | `#0b0c0c` | Text colour on focus background |
| `error` | `#d4351c` | Error states only |
| `success` | `#00703c` | Success states only |
| `border` | `#b1b4b6` | Borders and dividers |

### Rules

- Always use the GDS colour palette first.
- Never use colour as the only differentiator. Always pair with text or an icon.
- The focus ring colour (`#ffdd00`) is mandated by GDS for WCAG 2.2 compliance. Never override it.

---

## 4. Typography

*Source: https://design-system.service.gov.uk/styles/headings/*

### Heading classes

GDS heading classes are visual modifiers and are not strictly tied to a single HTML tag.

| Class | HTML tag | Use |
|---|---|---|
| `govuk-heading-xl` | `h1` | Page title. One per page. |
| `govuk-heading-l` | `h2` | Major sections within a page |
| `govuk-heading-m` | `h3` | Sub-sections within an h2 |
| `govuk-heading-s` | `h4` | Use sparingly — only when h3 is genuinely insufficient |
| `govuk-caption-xl` | `span` inside `h1` | Section label above the page title |
| `govuk-caption-l` | `span` inside `h2` | Sub-section label above an h2 |

### Body text classes

| Class | Tag | Use |
|---|---|---|
| `govuk-body-l` | `p` | Lead paragraph — first paragraph after h1 only |
| `govuk-body` | `p` | All standard body text |
| `govuk-body-s` | `p` | Supporting or meta text (e.g. "Last updated: ...") |

### Typography rules

- Every heading must carry a `govuk-heading-*` class. Bare heading tags without a class are invalid.
- Never skip heading levels. An `h3` may only appear within an `h2` context.
- Never put `<strong>` or `<b>` inside a heading element. Headings already communicate emphasis.
- All headings use sentence case.
- No full stops at the end of headings.

---

## 5. Layout & Grid

*Source: https://design-system.service.gov.uk/styles/layout/*

### Page structure

Every page uses two wrappers:
- `govuk-width-container` — constrains maximum content width with responsive gutters
- `govuk-main-wrapper` — adds responsive vertical padding to the `<main>` element

### Content column rule

All body content (headings, paragraphs, expanders, lists, inline links) should generally use `govuk-grid-column-two-thirds`. This is a readability decision — line lengths beyond ~75 characters increase reading fatigue.

### Available column classes

| Class | Use |
|---|---|
| `govuk-grid-column-full` | Full width sections (e.g. card grids, wide tables) |
| `govuk-grid-column-two-thirds` | All standard body content |
| `govuk-grid-column-one-third` | Sidebar content |
| `govuk-grid-column-one-half` | Two-column layouts |

### Spacing

Use GDS spacing utility classes (`govuk-!-margin-*`, `govuk-!-padding-*`). Do not write inline `style` values for spacing.

---

## 6. Navigation

### Header

*Source: https://design-system.service.gov.uk/components/header/*

Use the `govuk-header` component. Ensure any departmental logos follow specific departmental guidelines if overriding the standard GOV.UK crown.

### Category navigation bar

*Source: https://design-system.service.gov.uk/components/service-navigation/*

For service-level navigation, use the `govuk-service-navigation` component. It must collapse into a menu on mobile when multiple items exist.

### Breadcrumbs

*Source: https://design-system.service.gov.uk/components/breadcrumbs/*

**Placement:** Breadcrumbs must be placed directly inside the `govuk-width-container` and above the `govuk-main-wrapper`.

**Rules:**
- The breadcrumb trail begins with the home page.
- The trail ends with the **parent section** of the current page — the current page itself must not appear in the breadcrumb list (per GDS guidance).
- Use `govuk-breadcrumbs--collapse-on-mobile` to show only the first and last items on mobile and tablet.

### Back link

*Source: https://design-system.service.gov.uk/components/back-link/*

The back link is intended for question pages within multi-step transactions. It should not be used on informational content pages.

---

## 7. Page Types

Understanding which type a page is determines which components apply.

### Type 1: Hub / Category index page

**Purpose:** Entry point for a section. Lists child pages.

**Required elements:**
- Breadcrumbs (Home only — current page not included)
- `h1` with `govuk-heading-xl`
- Lead paragraph (`govuk-body-l`)
- Grid listing child pages or sections

**Not used on this page type:**
- Back link
- Contents list
- Expanders (typically)

### Type 2: Deep content page

**Purpose:** Detailed informational content on a specific topic.

**Required elements:**
- Breadcrumbs (Home → Section — current page not included)
- `h1` with `govuk-heading-xl`
- Lead paragraph (`govuk-body-l`)
- Contents list (if 4 or more h2 sections)

**Optional elements:**
- `govuk-details` expanders for supplementary content
- `govuk-warning-text` for safety-critical information
- `govuk-inset-text` for additional context

**Not used on this page type:**
- Back link
- Card grids (these belong on hub pages)

### Type 3: Transactional page

**Purpose:** Part of a multi-step form or service.

**Required elements:**
- Back link (instead of breadcrumbs)
- `h1` with `govuk-heading-l` or `govuk-heading-xl` depending on whether it's a question or a start page.
- Forms utilizing standard GDS input components.

---

## 8. Component Rules

### 8.1 Details (Expander)

*Source: https://design-system.service.gov.uk/components/details/*

**When to use:** Make a page easier to scan when it contains information that only some users will need.

**Summary text:** Must be short and descriptive. Write as a specific noun phrase or action so it makes sense to screen reader users in isolation.

### 8.2 Contents List (On This Page)

*Source: https://components.publishing.service.gov.uk/component-guide/contents_list*

**When to use:** On deep content pages with 4 or more `h2`-level sections.

**Position:** Immediately after the `h1` and lead paragraph, before the first `h2`.

### 8.3 Warning Text

*Source: https://design-system.service.gov.uk/components/warning-text/*

**When to use:** When you need to warn users about something important, such as legal consequences of an action.

**When not to use:** For tips, best practice, or general recommendations. Use `govuk-inset-text` for important-but-not-critical information.

### 8.4 Inset Text

*Source: https://design-system.service.gov.uk/components/inset-text/*

**When to use:** To differentiate a block of text from surrounding content. Appropriate for quotes, examples, and additional information.

### 8.5 Buttons

*Source: https://design-system.service.gov.uk/components/button/*

| Variant | Class | Use |
|---|---|---|
| Default | `govuk-button` | Primary call to action. One per page context. |
| Start | `govuk-button govuk-button--start` | Start page of a service only |
| Secondary | `govuk-button govuk-button--secondary` | Secondary actions alongside a primary button |
| Warning | `govuk-button govuk-button--warning` | Irreversible destructive actions only (e.g. delete) |

### 8.6 Links

*Source: https://design-system.service.gov.uk/styles/links/*

- Every `<a>` tag must carry the `govuk-link` class (or a specific variant).
- Link text must make sense out of context. Never use "Click here", "Find out more" alone.
- For external links: make the destination clear in the link text. Avoid opening links in a new tab unless unavoidable.

### 8.7 Lists

*Source: https://design-system.service.gov.uk/styles/lists/*

- `govuk-list--bullet`: Unordered items (options, tips).
- `govuk-list--number`: Sequential steps only.
- Do not end bullet items with a full stop if they are sentence fragments.

### 8.8 Images

*Source: https://design-system.service.gov.uk/styles/images/*

- Only use images if there is a real user need. Avoid decorative images.
- Every `<img>` must have an `alt` attribute.
- Informative images: alt text must be specific, meaningful, and concise.

### 8.9 Forms

*Source: https://design-system.service.gov.uk/components/*

- Every label must use `govuk-label` and be associated to its input via matching `for`/`id`.
- Inputs must use `govuk-input`, checkboxes `govuk-checkboxes`, etc.
- Error messages must follow the GDS error message pattern (`govuk-error-message`).

---

## 9. Content & Copy Standards

*Source: https://www.gov.uk/guidance/style-guide*

- **Tone of voice:** Direct. Plain English. Professional.
- **Headings:** Sentence case throughout. No full stops.
- **Numbers and dates:** Spell out one to nine; use digits for 10 and above. Dates: "12 December 2025".

---

## 10. Accessibility

*Source: https://design-system.service.gov.uk/accessibility/*

- **Standard:** WCAG 2.2 Level AA.
- **Colour contrast:** Minimum 4.5:1 for normal text, 3:1 for large text and UI components.
- **Focus states:** Visible focus states must be present for all interactive elements.
- **Keyboard navigation:** All interactive components must be fully operable by keyboard alone. Include a skip link.
- **Screen readers:** Use semantic HTML. Use `aria-label` only when native semantics are insufficient.

---

## 11. Common Anti-patterns to Avoid

- Including the current page in the breadcrumb trail.
- Using a back link on informational content pages.
- Wrapping headings inside `<a>` tags instead of links inside headings.
- Omitting the `govuk-link` class from anchors.
- Using `outline: none` to remove focus rings.

---

## 12. What Requires a Design Decision Before Implementation

Stop and raise a design decision before proceeding if any of the following arise:

- A component not covered in this catalogue or in the GDS design system.
- Any colour outside the approved tokens.
- Any complex interactive pattern (filter, search, multi-step form) not covered by existing guidelines.
- Any custom JavaScript for animation or interaction.
- Responsive behaviour that differs from GDS breakpoints.
