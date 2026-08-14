## ADDED Requirements

### Requirement: Grid Display
The system shall display a grid of 6 columns by 7 rows of fixed-size slots on the main play screen.

#### Acceptance Criteria
- The grid is visible immediately when the play screen loads.
- Every slot is clearly distinguishable as empty or occupied.
- The grid contains exactly 42 slots (6×7), per Decisions & Clarifications CQ-2 in `feature.md`.

### Requirement: First-Launch Item Population
When the player opens the game for the first time (no existing save data), the system shall populate a small number of grid slots with starting tier-1 items, leaving the remainder empty.

#### Acceptance Criteria
- On a fresh install/first launch, at least one tier-1 item is visible on the grid without any player action.
- The remaining slots are empty and available for play.
- On any subsequent launch where save data exists, this first-launch population does not occur (see [Progress Persistence](progress-persistence-spec.md)).

### Requirement: New Item Generation
While an empty grid slot exists, the system shall allow the player to tap that slot to spawn a tier-1 item into it, subject to a short cooldown between spawns. This is a placeholder mechanism (per Decisions & Clarifications CQ-3 in `feature.md`), explicitly intended to be replaced by the future idle economy feature.

#### Acceptance Criteria
- Tapping an empty slot spawns a tier-1 item in that slot, provided the cooldown has elapsed.
- Tapping an empty slot during the cooldown has no effect (no item spawned, no error state).
- This mechanism is isolated enough to be removed or replaced without affecting the Merge Interaction or Tier Progression specs.

### Requirement: Grid-Full Stop State
If every grid slot is occupied, then the system shall prevent new tier-1 item generation and leave the grid in this state with no popup, error, or game-over screen (per Decisions & Clarifications CQ-4 in `feature.md`) until the player frees a slot via a merge.

#### Acceptance Criteria
- With zero empty slots, tapping any slot has no effect (no item spawned, no crash, no error message).
- Generation resumes automatically as soon as at least one slot becomes empty (e.g. via a successful merge), with no player action required beyond the merge itself.
