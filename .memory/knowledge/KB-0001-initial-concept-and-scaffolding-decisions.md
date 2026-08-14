---
id: KB-0001
title: "Initial game concept and scaffolding decisions (pre-init-project)"
component: "product/concept"
domain: "adlc"
tags: ["concept", "genre", "scaffolding", "vibe-engineering"]
status: "unresolved"
created: 2026-08-09
updated: 2026-08-09
---

## What Happened

This project was scaffolded as a "vibe engineering" experiment for an Android game, using Hippo's `ai-sdlc` framework (same pattern as the sibling project `consultantsim`). Before running `/init-project`, a brainstorming pass was done (grounded in web research on mobile game genres and core-loop design) to settle on a starting concept, so `/init-project`'s vision/architecture Q&A has something concrete to work from.

## Key points

- **Concept**: a "merge city builder" hybrid — a validated mobile genre (Merge Mansion, Township, Mergest Kingdom). Three layers:
  1. **Core action (tight loop)**: drag two matching items together on a grid to merge into the next tier — instant visual/audio feedback (pop/level-up), deterministic grid logic, no physics-feel risk.
  2. **Idle layer**: buildings/resource nodes passively generate new low-tier items over time, including offline — pure economy/math, easy for AI to build and balance correctly.
  3. **City-builder meta layer**: higher-tier merges unlock buildings placed on a growing town map — gives a long-term "never really finished" retention hook, addressing the common failure mode in similar games (e.g. Survivor.io's D30 retention collapses to ~4% once the power curve flattens because there's nothing left to chase).
- **Why this genre was picked over the original "bullet-heaven" (Vampire Survivors-like) idea**: user wanted genres that are easy for AI-assisted solo development specifically — grid/merge logic and idle economy are deterministic and math-heavy with minimal "feel-tuning" risk, unlike bullet-heavens which need real-time enemy AI, wave balancing, and juice/hit-stop tuning to land well.
- **Deferred to the `/init-project` step** (not decided yet):
  - Engine/tech stack (Godot vs. Unity vs. other) — to be decided via the `adr` skill once `/init-project` runs. `consultantsim` (sibling project) uses Godot 4.x/GDScript, if a reference point is useful.
  - Full product vision, architecture, design guidelines, test strategy.
  - `GDD.md` — comes out of `vision`/`feature` skills.
- **Scaffolding note**: `init.sh` was run with its AntiGravity-specific tail (the `agy -i ...` call and the subsequent `rm -rf .agents/skills/init-project`) stripped out, so the `init-project` skill was deliberately preserved (normally it self-deletes after one use) — it's still available and has not been run yet.

## Why It Matters

Without this note, a fresh session/terminal opened directly in `mergeville` (as opposed to continuing the session that did the brainstorming) would only see the generic `AGENTS.md` and have no idea a concept was already chosen — `/init-project` would ask vision questions from a blank slate and might land somewhere unrelated to the merge-city-builder direction already agreed with the user.

## Applies When

Relevant to anyone (or any future session) running `/init-project`, `/vision`, `/architecture`, or `/adr` for this project for the first time — read this before asking the user to re-derive the concept from scratch.
