---
id: KB-0002
title: "Value definition for a non-commercial solo experiment project"
component: "product/vision"
domain: "adlc"
tags: ["value", "prioritization", "vibe-engineering"]
status: "unresolved"
created: 2026-08-09
updated: 2026-08-09
---

## What Happened

While running the `feature` skill's `value` sub-step for the first feature (Merge Grid Core Loop), the standard `value` skill workflow assumes an organizational context with commercial value drivers (revenue, cost savings, user growth, compliance). mergeville has none of these — it's a solo, non-monetized, non-launched AI-development experiment (see `.memory/product-vision.md`).

## Key points

- Redefined "value" around the project's own stated goals instead of commercial drivers: Experiment Validation (does the AI-assisted workflow build this well), Core Loop Progress (does it advance the merge/idle/meta loop), Genre-Risk Mitigation (does it avoid known failure modes like retention flattening), and Developer Enjoyment (is it fun to playtest).
- This Value Rule Set was appended directly to `.memory/product-vision.md` (new "Value Rule Set" section) rather than a separate value-definition document, so all future features can reference one canonical source.
- The bar for "GO" is intentionally low/permissive compared to a commercial ROI-style threshold — the rule set exists to keep scope honest (reject unrelated scope creep) rather than to gate real investment decisions, since there's no budget or stakeholder to protect.

## Why It Matters

Future features run through the `feature` → `value` workflow will hit the same "no organization" mismatch. Reusing the Value Rule Set in `.memory/product-vision.md` (rather than re-deriving value criteria from scratch each time) keeps assessments consistent and avoids asking the user to re-explain that this is a non-commercial experiment.

## Applies When

Relevant whenever the `value` skill is invoked for a new mergeville feature — read `.memory/product-vision.md`'s "Value Rule Set" section first rather than asking the user to define organizational value again.
