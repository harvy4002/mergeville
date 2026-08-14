---
title: "Intent: Merge Grid Core Loop"
feature: "merge-grid-core-loop"
created: 2026-08-09
updated: 2026-08-09
---

# Intent: Merge Grid Core Loop

## Objective

Deliver a complete, playable merge-grid core loop (grid → drag-to-merge → tier progression → persistence) as the foundational vertical slice of mergeville, per `.memory/specs/merge-grid-core-loop/feature.md`. Success means a player can open the app, merge items up to tier 5, generate new items, and have their progress survive a restart — with the deterministic logic covered by unit tests per `.memory/testing.md`.

## Boundaries & Scope Constraints

- **Untouchable:** N/A — this is a new, empty project; there is no existing code to avoid touching.
- **Scope Limits:**
  - MUST NOT implement any idle/offline economy logic (resource-generating buildings) — only the tap-to-generate placeholder defined in `feature.md` CQ-3.
  - MUST NOT implement the city-builder meta layer (town map, building placement).
  - MUST NOT add networking, accounts, ads, or IAP of any kind.
  - MUST NOT add a CI/CD pipeline or automated deployment — out of scope per `.memory/testing.md`.
  - MUST NOT create any screens/menus beyond the single main grid play screen implied by `feature.md` and its sub-specs.

## Technical Constraints

- **Dependencies:** Godot 4.x, GDScript only ([ADR-0001](../../decisions/ADR-0001-godot-4-gdscript-engine.md)). GUT (Godot Unit Test) addon for testing — the only new dependency, added as a Godot addon (no package manager).
- **Performance:** No formal budget set (`.memory/testing.md`); merge/drag interactions must show no perceptible input lag during manual playtesting.
- **Compatibility:** Must run on Android via Godot's export template; must also run in the Godot editor (desktop) for development/testing convenience.
- **Persistence format:** Plain JSON at `user://save_data.json` ([ADR-0002](../../decisions/ADR-0002-json-local-save-format.md)).

## Data Definitions & Schemas

### Database Schema Changes

N/A — no database. Persistence is a local JSON file (see Save File Schema below).

### Code Data Structures

- **`ItemDefinition` (Godot `Resource` subclass, `scripts/resources/item_definition.gd`):**
  - `tier: int` — 1 to 5.
  - `display_name: String`
  - `icon: Texture2D`
  - `next_tier: ItemDefinition` (nullable — `null` for tier 5, the max tier per `feature.md` CQ-1/CQ-5).
  - One `.tres` resource instance per tier, stored under `resources/items/`.

- **`GameState` (autoload singleton, `scripts/autoloads/game_state.gd`):**
  - `grid: Array[Array]` — a 6×7 (columns × rows) array; each cell holds either `null` (empty) or an `int` tier value (1-5). Column-major or row-major indexing is an implementation detail, but must stay internally consistent across `game_state.gd`, `save_system.gd`, and any tests.
  - Signals: `item_merged(tier: int, position: Vector2i)`, `item_spawned(position: Vector2i, tier: int)`, `grid_changed()` (emitted after any mutation, consumed by `save_system.gd` to know when to persist).

- **`SaveSystem` (autoload singleton, `scripts/autoloads/save_system.gd`):**
  - `save() -> void` — serializes `GameState.grid` to JSON at `user://save_data.json`.
  - `load() -> bool` — returns `true` and populates `GameState.grid` on success; returns `false` (triggering first-launch population, per progress-persistence-spec.md) on missing file, JSON parse failure, or schema/version mismatch.

### Save File Schema (JSON, `user://save_data.json`)

```json
{
  "version": 1,
  "grid": [
    { "x": 0, "y": 0, "tier": 1 },
    { "x": 2, "y": 3, "tier": 4 }
  ]
}
```

- `version`: integer, `1` for this feature. A future save-format change increments this; `SaveSystem.load()` must treat an unrecognized `version` the same as a corrupted file (fresh-game fallback).
- `grid`: sparse array — only occupied slots are listed (`x`, `y` are 0-indexed grid coordinates within the 6×7 grid, `tier` is 1-5). Absence of a coordinate pair means that slot is empty. Chosen over a dense 42-entry array to keep the file small and to make "is this slot occupied" checks during load trivial (presence in the array).

## API & Integration Contracts

No REST/RPC/GraphQL APIs — this is a fully offline, client-only feature ([[ASSUME-002]]). "Integration contracts" here are in-process Godot signals consumed by future features (idle economy, town meta), per `.memory/architecture.md` Key Patterns:

### Signal Contracts

| Signal | Emitted By | Payload | Consumed By (future) |
|---|---|---|---|
| `item_merged(tier: int, position: Vector2i)` | `GameState` | Resulting tier and grid position of a successful merge | Town Meta system (tier-unlock thresholds) |
| `item_spawned(position: Vector2i, tier: int)` | `GameState` | Position and tier of a tap-to-generated item | Not consumed by this feature; reserved for future economy telemetry/balancing |
| `grid_changed()` | `GameState` | None | `SaveSystem` (triggers a save) |

These signal names/payloads are the "integration contract" this feature must not break, since `.memory/architecture.md`'s system diagram depends on them for the idle economy and town-meta features to hook in later without modifying this feature's internals.

## Validation Rules

### Test Sets (Input/Output Rulesets)

- Given two adjacent grid cells both containing tier-N items (N < 5), merging them must result in exactly one cell containing a tier-(N+1) item and the other cell empty.
- Given two adjacent grid cells containing different tiers (or one empty), attempting to merge them must leave both cells unchanged.
- Given two adjacent grid cells both containing tier-5 items, attempting to merge them must leave both cells unchanged (per `feature.md` CQ-5).
- Given a `SaveSystem.load()` call with no existing save file, the result must be `false` and `GameState.grid` must be left for first-launch population.
- Given a `SaveSystem.load()` call with a malformed/non-JSON file at `user://save_data.json`, the result must be `false` (same fresh-game fallback, no crash).
- Given a `GameState.grid` populated with N occupied cells, calling `SaveSystem.save()` followed by `SaveSystem.load()` must restore exactly those N cells with matching positions and tiers.

### Properties (Universally Quantifiable Predicates)

- For all grid positions, a cell's value is always either `null` or an integer in `[1, 5]` — no other value is ever valid.
- For all successful merges, the resulting tier is always exactly `source_tier + 1` — never any other value.
- For all tap-to-generate spawns, the spawned item's tier is always `1`.

### Contracts (Preconditions, Invariants, Postconditions)

- **Merge operation** — Precondition: both target cells are non-empty, adjacent, and equal tier < 5. Postcondition: one cell holds tier+1, the other is empty; total non-empty cell count decreases by exactly 1.
- **Tap-to-generate operation** — Precondition: target cell is empty AND cooldown has elapsed ([[ASSUME-003]]). Postcondition: target cell holds a tier-1 item; cooldown timer resets.
- **Save/Load cycle** — Invariant: `GameState.grid` state before `save()` equals `GameState.grid` state after a subsequent `load()`, for any valid grid state.

## Measurable Success Criteria

- All Test Sets above pass as GUT unit tests with zero failures.
- `feature.md` Success Criteria SC-001 through SC-004 are confirmed via manual playtesting on an Android device or emulator.
- Zero GDScript parser/runtime errors when running the full merge → save → relaunch → restore cycle manually.

## Implementation Directives

- Run the full GUT suite (`tests/unit/`) after completing each PR (per `proposal.md`'s PR strategy), not just at the end — regressions in PR1's data model should be caught before PR2/PR3 build on it.
- `merge_rules.gd` and `game_state.gd`'s grid-mutation logic must be written as pure/stateless functions wherever possible (grid array in, grid array out) specifically so GUT can test them without instancing the full scene tree — mirrors `.memory/architecture.md`'s intent to keep merge rules decoupled from rendering.
- After PR2 and PR3, manually verify the save file at `user://save_data.json` (Godot's user data directory) matches the schema above by inspection, since there is no schema-validation tooling in scope.
