---
id: KB-0003
title: "Broad-signal full refresh interrupts per-node view animations"
component: "merge-grid/view-layer"
domain: "godot-ui"
tags: ["signals", "view-refresh", "animation", "godot", "bug-pattern"]
status: "validated"
created: 2026-08-14
updated: 2026-08-14
---

## What Happened

The user reported the game felt like "a buggy mess" on a real Android device, despite all 43 (then) GUT unit tests passing and clean headless boots. Root cause, found via code review (no device access needed): `GridSlot.refresh()` unconditionally destroyed and recreated its `ItemView` child on every call, and `MergeGrid._on_grid_changed()` called `refresh()` on **all 42 slots** every time `GameState.grid_changed` fired — which happens on every single tap-to-generate or merge, anywhere on the board.

Effect: any single action anywhere on the grid destroyed and rebuilt every other item's visual node too, including ones mid-animation. A merge's `play_merge_pop()` tween (or any other slot's in-flight animation) would get its node freed and replaced with a static fresh one before the tween finished — reading as flicker, snapping, and interrupted animations exactly like general instability, especially under the rapid tap/drag interaction a merge game invites.

## Key points

- **This class of bug is invisible to headless/automated testing.** GUT tests confirmed grid *state* was always correct (right tier ends up in the right cell) — the bug was purely about *view churn*, which only manifests visually over time, not as a state assertion failure.
- **The fix**: cache the currently-displayed tier per `GridSlot` (`_displayed_tier`) and make `refresh()` a no-op when the underlying tier hasn't changed for that specific slot. Only the slot(s) whose content actually changed get their view rebuilt; everything else, including in-flight tweens, is left alone.
- **Sentinel gotcha**: the initial `_displayed_tier` sentinel must be an `int` (e.g. `-1`), not a `String` — GDScript 4 throws a runtime error on `==` between an `int` and a `String` (`Invalid operands 'int' and 'String' in operator '=='`), unlike `int == null` which is a safe, normal comparison. This surfaced immediately as a test failure once a regression test was added.
- **Regression test added**: `tests/unit/test_grid_slot.gd` instantiates a bare `GridSlot` (via `add_child_autofree`) and asserts the `ItemView` instance identity is preserved across a no-op `refresh()`, and only changes when the tier actually changes.

## Why It Matters

The upcoming idle-economy and city-builder-meta features (`.memory/product-vision.md`) will introduce more autoload signals (e.g. resource-generation ticks, building placement) that some view layer will need to react to. The same trap applies: **a view listening to a broad "something changed" signal must diff before rebuilding**, or it will silently degrade animation/interaction quality in a way no unit test catches — only a real device/manual playtest surfaces it. This is also a concrete argument for not skipping the manual playtest step in `.memory/testing.md` even when the automated suite is fully green.

## Applies When

Relevant whenever a new Godot view/UI layer subscribes to a broad state-changed signal (rather than a signal scoped to the specific thing that changed) and rebuilds child nodes in response — check for a diff/no-op guard before assuming a full rebuild is safe.
