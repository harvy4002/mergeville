---
title: "Merge Grid Core Loop"
component: "merge-grid"
domain: "gameplay"
tags: ["godot", "merge-grid", "core-loop", "persistence"]
created: 2026-08-09
updated: 2026-08-09
---

# Implementation Proposal: Merge Grid Core Loop

## Intent

Build the first playable slice of mergeville: a 6×7 grid on which the player merges matching items up to tier 5, can generate new tier-1 items via a placeholder tap-to-generate mechanism, and has their progress saved/restored locally across app sessions. This is the foundational vertical slice all future features (idle economy, city-builder meta) depend on, and the first real test of the AI-assisted spec→propose→implement workflow for this project (`.memory/product-vision.md`).

## Scope

### In-Scope

- Initial Godot 4.x project scaffolding (`project.godot`, folder structure per `.memory/architecture.md`'s Source code layout).
- Data-driven item tier definitions (5 tiers) as Godot `Resource` files.
- A 6×7 merge grid scene: display, drag-and-drop input, merge-on-match logic, reject-on-mismatch behavior.
- Tap-to-generate tier-1 items on an empty slot, with a cooldown ([[ASSUME-003]]).
- Grid-full and max-tier (tier 5) simple stop states (no popup, no conversion).
- Visual/audio merge feedback per `.memory/design-guidelines.md` Component Behaviors.
- Local JSON save/load of grid state ([ADR-0002](../../decisions/ADR-0002-json-local-save-format.md)), with fresh-game fallback on missing/corrupt data.
- GUT unit tests for merge rules, tier progression, and save/load round-trip, per `.memory/testing.md`.

### Out-of-Scope

- Idle economy system (resource-generating buildings, offline generation) — future feature.
- City-builder meta layer (town map, building placement/unlocks) — future feature.
- Any monetization, ads, IAP, accounts, or networking (permanently out of scope per `.memory/product-vision.md`).
- Automated CI/CD pipeline (deferred per `.memory/testing.md`).
- Formal accessibility/security compliance audits (deferred per `.memory/testing.md`).

## Knowledge Context

### Assumptions

- [ASSUME-002](../../assumptions/ASSUME-002-local-only-single-player-no-backend.md) — single-player, local-only persistence, no backend.
- [ASSUME-003](../../assumptions/ASSUME-003-tap-to-generate-cooldown-duration.md) — tap-to-generate cooldown is 3 seconds, not persisted across restarts.

### Architectural Decisions (ADRs)

- [ADR-0001](../../decisions/ADR-0001-godot-4-gdscript-engine.md) — Godot 4.x / GDScript engine choice.
- [ADR-0002](../../decisions/ADR-0002-json-local-save-format.md) — plain JSON local save format.

## Approach

Follow the layered structure in `.memory/architecture.md`:

- **`scripts/autoloads/game_state.gd`**: singleton holding the in-memory grid state (42 slots, each empty or holding an item tier) as the single source of truth during play.
- **`scripts/autoloads/save_system.gd`**: singleton that serializes/deserializes `game_state` to/from `user://save_data.json` ([ADR-0002](../../decisions/ADR-0002-json-local-save-format.md)) on scene-tree pause/quit notifications and app launch.
- **`resources/items/item_tier_*.tres`**: 5 `ItemDefinition` Resource instances (tier, display name, icon, next-tier reference) — data-driven per `.memory/architecture.md` Key Patterns, so tier count/art can change without touching merge logic.
- **`scripts/merge_grid/merge_rules.gd`**: pure, stateless functions (grid state in → grid state out) for validating/resolving a merge — kept free of scene/node dependencies so GUT can unit-test it directly.
- **`scenes/merge_grid/grid.tscn` + `scripts/merge_grid/grid.gd`**: renders `game_state`, handles drag input (`_gui_input`/`Control` drag-and-drop or custom touch handling), calls into `merge_rules.gd`, and emits an `item_merged(tier, position)` signal on success (per `.memory/architecture.md` Key Patterns) for future systems (idle economy, town meta) to listen to without this feature depending on them.
- **`scripts/merge_grid/item.gd`**: individual draggable item node; owns its own merge/drag feedback animation per `.memory/design-guidelines.md`.
- Tap-to-generate and the grid-full/max-tier stop states are implemented as conditionals inside `grid.gd`/`game_state.gd` rather than a separate system, since they're explicitly temporary placeholders ([[ASSUME-003]], CQ-3/CQ-4/CQ-5 in `feature.md`) with a narrow surface area.
- Tests live under `tests/unit/` using GUT, targeting `merge_rules.gd`, `game_state.gd` (grid manipulation), and `save_system.gd` (round-trip) in isolation from the scene tree where possible.

### PR & Deployment Strategy

Three atomic, independently testable PRs, per `tasks.md`:

1. **PR1 — Scaffolding & data model**: project setup, GUT addon install, item tier `Resource` definitions, `game_state.gd` grid data structure (no UI yet). Testable via unit tests alone.
2. **PR2 — Grid scene, persistence & first-launch population**: visible grid, save/load round-trip, first-launch item population. Testable by launching the game, seeing the grid, and confirming state survives a restart.
3. **PR3 — Merge interaction, generation & stop states**: drag-to-merge, feedback, tap-to-generate, grid-full/max-tier stop states. Testable by playing the full loop end-to-end (Success Criteria SC-001 to SC-004 in `feature.md`).
