## 1. PR1 — Project Scaffolding & Data Model

- [x] 1.1 Initialize the Godot 4.x project (`project.godot`, portrait mobile viewport, folder structure per `.memory/architecture.md` Source code layout).
- [x] 1.2 Install and configure the GUT (Godot Unit Test) addon; verify an empty test suite runs.
- [x] 1.3 Create the `ItemDefinition` Resource script (`scripts/resources/item_definition.gd`) and 5 `.tres` instances under `resources/items/` (tiers 1–5, tier 5's `next_tier` is `null`), per `intent.md` Code Data Structures.
- [x] 1.4 Implement the `GameState` autoload (`scripts/autoloads/game_state.gd`): 6×7 grid array, `item_merged`, `item_spawned`, `grid_changed` signals per `intent.md` Signal Contracts.
- [x] 1.5 Implement `merge_rules.gd` as pure, stateless functions (`can_merge`, `resolve_merge`) operating on grid data only, per `proposal.md` Approach.
- [x] 1.6 [write-tests] Use the `write-tests` skill to implement GUT unit tests for TC-01, TC-06, and TC-11 (successful merge, mismatched-tier rejection, max-tier rejection) against `merge_rules.gd`. — `tests/unit/test_merge_rules.gd` (7 tests).
- [x] 1.7 Run the GUT suite; confirm all PR1 tests pass before starting PR2. — 7/7 passing.

## 2. PR2 — Grid Scene, Persistence & First-Launch Population

- [x] 2.1 Implement the `SaveSystem` autoload (`scripts/autoloads/save_system.gd`): `save_game()`/`load_game()` against `user://save_data.json`, JSON schema and `version` field per `intent.md`. (Named `save_game`/`load_game` rather than `save`/`load` to avoid shadowing Godot's global `load()` function.)
- [x] 2.2 Implement the security remediation from `security.md` Section 7: `load_game()` validates every entry's `tier` is in `[1,5]` and `(x,y)` is within grid bounds, treating any violation as a corrupted file.
- [x] 2.3 Build the `grid.tscn` scene (`scenes/merge_grid/`) rendering the 6×7 grid from `GameState`.
- [x] 2.4 Implement first-launch population: when `SaveSystem.load_game()` returns `false`, populate a small number of tier-1 items per `grid-and-starting-items-spec.md`.
- [x] 2.5 Wire `SaveSystem.save_game()` to `GameState.grid_changed` and to app pause/quit notifications.
- [x] 2.6 [write-tests] Use the `write-tests` skill to implement GUT unit tests for TC-02, TC-09, TC-10, TC-14, and TC-15 (save/load round-trip, corrupted file, missing file, full-grid and empty-grid round-trips) plus a case covering the bounds-check from task 2.2. — `tests/unit/test_save_system.gd` (8 tests).
- [x] 2.7 Run the GUT suite; confirm all PR1+PR2 tests pass. — 15/15 passing.
- [x] 2.8 Manual test: launch the app fresh, confirm the grid renders with starting items visible; close and reopen the app, confirm the exact same state is restored (SC-003). — Verified via headless boot runs (see finalise notes): first launch wrote 3 starting items to `user://save_data.json`; a second headless run loaded the identical state instead of re-populating; a run with a hand-corrupted save file fell back to fresh-game population with no crash. Visual rendering itself (does it *look* right on screen) still needs a human pass in the editor/device — see 3.10.

## 3. PR3 — Merge Interaction, Generation & Stop States

- [x] 3.1 Implement the `item.gd` draggable item node (`scripts/merge_grid/item.gd`) with drag input handling.
- [x] 3.2 Wire drag-and-drop in `grid_slot.gd` to `GameState.attempt_merge` (which calls into `merge_rules.gd`); emits `item_merged` on success (per Drag-to-Merge requirement in `merge-interaction-spec.md`).
- [x] 3.3 Implement reject-invalid-merge behavior: since the dragged `ItemView` is never reparented (only a preview follows the cursor), an invalid drop leaves it exactly where it started — no separate "animate back" logic needed. See comment in `grid_slot.gd`.
- [x] 3.4 Implement merge visual feedback per `.memory/design-guidelines.md` Component Behaviors (pop/scale animation via `ItemView.play_merge_pop()`). **Audio cue not implemented** — no audio asset exists yet; `play_merge_pop()` has a code comment flagging this gap for whoever adds sound assets.
- [x] 3.5 Implement tap-to-generate on empty slots with a cooldown ([[ASSUME-003]], 3 seconds, not persisted).
- [x] 3.6 Implement the grid-full stop state: generation blocked with no popup/error when all 42 slots are occupied (per Grid-Full Stop State requirement).
- [x] 3.7 Implement the max-tier stop state: two tier-5 items cannot merge, no special conversion (per Prevent Merging Beyond Maximum Tier requirement).
- [x] 3.8 [write-tests] Use the `write-tests` skill to implement GUT unit tests for TC-03, TC-08, and TC-12 (tap-to-generate success, cooldown rejection, grid-full rejection). — covered in `tests/unit/test_game_state.gd` (9 tests).
- [x] 3.9 Run the full GUT suite; confirm all PR1+PR2+PR3 automated tests pass. — 24/24 passing.
- [ ] 3.10 **Manual playtest pass covering TC-04, TC-05, TC-07, and TC-13 (drag feel, first-merge-within-30s, drag-onto-empty-slot, drag-released-outside-grid); confirm Success Criteria SC-001 through SC-004 in `feature.md`.** NOT DONE by the implementer — this environment has no way to drive a live Godot window (no display/GUI automation available), and `.memory/testing.md` assigns this level explicitly to the human Developer. Open the project in the Godot editor (`godot -e --path .`) or export to an Android device/emulator and play through the loop to confirm this.

## 4. Finalize

- [x] 4.1 Run the complete GUT suite one final time; confirm zero failures across all three PRs. — 24/24 passing (`godot --headless --path . -s addons/gut/gut_cmdln.gd -gexit`).
- [x] 4.2 Manually inspect `user://save_data.json` against the schema in `intent.md` after a real playtest session. — Inspected after headless runs; matches schema exactly (`{"version":1,"grid":[{"x":..,"y":..,"tier":..}, ...]}`).
- [ ] 4.3 Hand off to the `finalise` skill to reconcile assumptions ([[ASSUME-002]], [[ASSUME-003]]) and capture any implementation-time knowledge/lessons learned. — Not yet run; do this once 3.10's manual playtest is complete.
