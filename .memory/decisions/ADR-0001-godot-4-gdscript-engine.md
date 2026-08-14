---
id: ADR-0001
title: "Use Godot 4.x / GDScript as the game engine"
component: "engine"
domain: "architecture"
tags: ["godot", "gdscript", "android", "engine-choice"]
status: "accepted"
created: 2026-08-09
updated: 2026-08-09
---

# Decision Record: 0001. Use Godot 4.x / GDScript as the game engine

**Feature:** Project scaffolding / engine selection
**Date:** 2026-08-09
**Deciders:** Harvinder Atwal
**Status:** Accepted

## Context

mergeville is a solo, AI-assisted "vibe engineering" experiment to build an Android merge city-builder game (see `.memory/product-vision.md`). An engine/tech stack decision was explicitly deferred from initial scaffolding (see `.memory/knowledge/KB-0001-initial-concept-and-scaffolding-decisions.md`) to be resolved during `/init-project`. The project has no monetization, no backend, and targets Android only, so the engine choice should optimize for solo/AI-assisted development speed and simple Android packaging over ecosystem breadth or cross-platform reach.

## Options Considered

* **Option 1:** Godot 4.x / GDScript
* **Option 2:** Unity / C#
* **Option 3:** Other (e.g. native Android/Kotlin + custom 2D framework, or a JS-based framework like Phaser wrapped for Android)

## Evaluation

### Option 1: Godot 4.x / GDScript
* **Pros:**
    * Free and open-source, no licensing/seat concerns for a solo hobby project.
    * Strong built-in 2D toolkit (TileMap/grid nodes, tweening, signals) well-suited to grid-based merge mechanics and UI-heavy city-builder layouts.
    * One-click Android export template, minimal build/deploy ceremony.
    * Matches the sibling project `consultantsim`, giving the developer (and AI assistant) a consistent reference point and reusable patterns/prompts across projects.
    * GDScript's simple, Python-like syntax is easy for an AI assistant to generate and for the developer to review line-by-line.
* **Cons:**
    * Smaller ecosystem/asset marketplace than Unity.
    * Less mature mobile-specific tooling (e.g. ad/IAP SDK plugins) — acceptable here since monetization is explicitly out of scope.

### Option 2: Unity / C#
* **Pros:**
    * Industry-standard, huge asset store and community/documentation base (which can also mean more AI training data/precedent).
    * Mature mobile monetization and analytics SDK ecosystem.
* **Cons:**
    * Heavier editor/tooling footprint and steeper project setup (Android SDK/NDK, keystore, Player Settings) for a solo experiment.
    * C#/Unity's component and prefab model has more ceremony than needed for a project with no monetization/analytics requirements.
    * Would break consistency with the sibling `consultantsim` project.

### Option 3: Other (native/Kotlin or JS-based framework)
* **Pros:**
    * Full control, no engine abstraction layer.
* **Cons:**
    * Significantly more boilerplate for rendering, input, and animation that a game engine provides for free — a poor fit for a solo/AI-assisted experiment focused on game systems, not engine-building.

## Decision

Use **Godot 4.x with GDScript** as the engine and primary language for mergeville.

## Consequences

### Positive
* Fast path from grid/merge prototype to an installable Android build via Godot's export templates.
* Consistent tooling and patterns with `consultantsim`, letting learnings and AI-assistant conventions transfer between projects.
* GDScript's readability keeps AI-generated code easy for the solo developer to review and correct.

### Negative
* Locked into Godot's built-in physics/rendering/UI conventions; revisiting this decision later (e.g. to reach iOS via a different pipeline, or to use a monetization SDK only available for Unity) would require a costly re-platform. Acceptable given the project's current scope (Android-only, no monetization).
