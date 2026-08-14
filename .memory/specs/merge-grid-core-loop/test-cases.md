# Test Cases: Merge Grid Core Loop

Generated per `.memory/testing.md`'s lightweight strategy: automated (GUT) cases for deterministic logic, manual cases for feel/UX. References `feature.md`, `intent.md`, and the four sub-feature specs.

## 🟢 Happy Path Scenarios

### TC-01: Successful merge produces next tier (Automated — GUT)
- **Pre-conditions**: `GameState.grid` has a tier-1 item at (0,0) and a tier-1 item at (0,1).
- **Steps**:
  1. Call the merge operation with source (0,0) and target (0,1).
- **Expected Result**: (0,1) contains a tier-2 item; (0,0) is empty. `item_merged` signal fires with `tier=2, position=(0,1)`.

### TC-02: Save and reload restores exact grid state (Automated — GUT)
- **Pre-conditions**: `GameState.grid` populated with a mix of occupied/empty cells across several tiers.
- **Steps**:
  1. Call `SaveSystem.save()`.
  2. Reset `GameState.grid` to empty.
  3. Call `SaveSystem.load()`.
- **Expected Result**: `load()` returns `true`; grid matches the pre-save state exactly (same positions and tiers).

### TC-03: Tap-to-generate spawns a tier-1 item (Automated — GUT / Manual)
- **Pre-conditions**: Cooldown has elapsed; target slot is empty.
- **Steps**:
  1. Tap/trigger generation on the empty slot.
- **Expected Result**: Slot now contains a tier-1 item; cooldown timer resets.

### TC-04: Full drag-to-merge feel (Manual)
- **Pre-conditions**: App running on Android device/emulator, two adjacent matching items visible.
- **Steps**:
  1. Drag one item onto the other with a finger.
- **Expected Result**: Merge completes smoothly within the single gesture; visual pop/scale animation and audio cue play immediately (SC-004).

### TC-05: First-time player reaches first merge quickly (Manual)
- **Pre-conditions**: Fresh install, no save data.
- **Steps**:
  1. Launch the app for the first time.
  2. Attempt to merge without any external instructions.
- **Expected Result**: Player completes at least one merge within 30 seconds (SC-001).

## 🔴 Negative Scenarios

### TC-06: Mismatched tiers do not merge (Automated — GUT)
- **Pre-conditions**: (0,0) has a tier-1 item, (0,1) has a tier-2 item.
- **Steps**:
  1. Attempt to merge (0,0) into (0,1).
- **Expected Result**: Both cells unchanged; no `item_merged` signal fires.

### TC-07: Dragging onto an empty slot does not merge (Automated — GUT / Manual)
- **Pre-conditions**: (0,0) has a tier-1 item, (0,1) is empty.
- **Steps**:
  1. Drag (0,0) onto (0,1).
- **Expected Result**: Per `merge-interaction-spec.md`, this is not a merge (no matching item present); behavior should place/return the item consistently with the "Reject Invalid Merge" requirement — item returns to (0,0), (0,1) remains empty.

### TC-08: Tap during cooldown has no effect (Automated — GUT / Manual)
- **Pre-conditions**: Cooldown active (recently generated).
- **Steps**:
  1. Tap an empty slot before cooldown elapses.
- **Expected Result**: No item spawned; no error or crash.

### TC-09: Corrupted save file falls back to fresh game (Automated — GUT)
- **Pre-conditions**: `user://save_data.json` contains invalid/non-JSON content.
- **Steps**:
  1. Call `SaveSystem.load()`.
- **Expected Result**: Returns `false`; no crash or exception propagates; caller proceeds to first-launch population.

### TC-10: Missing save file on first launch (Automated — GUT)
- **Pre-conditions**: `user://save_data.json` does not exist.
- **Steps**:
  1. Call `SaveSystem.load()`.
- **Expected Result**: Returns `false`; first-launch population proceeds (at least one tier-1 item visible, per grid-and-starting-items-spec.md).

## 🟡 Edge Cases

### TC-11: Maximum tier cannot merge further (Automated — GUT)
- **Pre-conditions**: Two adjacent cells both contain tier-5 items.
- **Steps**:
  1. Attempt to merge them.
- **Expected Result**: Both cells unchanged; behaves identically to TC-06 (no special conversion/messaging, per CQ-5).

### TC-12: Grid full blocks further generation (Automated — GUT / Manual)
- **Pre-conditions**: All 42 slots occupied.
- **Steps**:
  1. Tap any slot.
- **Expected Result**: No item spawned; no popup/error; no crash. Generation resumes automatically after the next successful merge frees a slot.

### TC-13: Drag released outside the grid bounds (Manual)
- **Pre-conditions**: An item is being dragged.
- **Steps**:
  1. Release the drag gesture outside the grid's visible bounds.
- **Expected Result**: Item returns to its original slot; no crash, no item loss.

### TC-14: Save/load round-trip with a full grid (Automated — GUT)
- **Pre-conditions**: All 42 slots occupied with a mix of tiers.
- **Steps**:
  1. Save, clear in-memory state, then load.
- **Expected Result**: All 42 cells restored exactly; sparse JSON array (per `intent.md` schema) contains exactly 42 entries.

### TC-15: Save/load round-trip with an empty grid (Automated — GUT)
- **Pre-conditions**: All 42 slots empty.
- **Steps**:
  1. Save, then load.
- **Expected Result**: `grid` array in the JSON is empty (`[]`); load restores an all-empty grid without error.
