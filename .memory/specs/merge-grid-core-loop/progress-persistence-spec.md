## ADDED Requirements

### Requirement: Save Grid State
When the player closes the app or the app is paused/backgrounded, the system shall save the current grid state (item positions and tiers) to local device storage.

#### Acceptance Criteria
- All occupied and empty slot states are captured at save time.
- Saving occurs without requiring an explicit "save" action from the player.

### Requirement: Restore Grid State
When the player reopens the game and saved grid state exists, the system shall restore the grid to exactly the state it was in when last saved, in place of the first-launch population behavior.

#### Acceptance Criteria
- Every item present at save time (position and tier) is present after reload, per Success Criteria SC-003 in `feature.md`.
- No slot's contents change as a result of the save/restore cycle alone.

### Requirement: Handle Missing or Corrupted Save Data
If saved grid state is missing or cannot be read, then the system shall start a fresh game (first-launch item population) rather than showing an error or blocking the player from playing. This mirrors the "simple stop state, no error" approach confirmed for other edge cases in Decisions & Clarifications CQ-4 in `feature.md`.

#### Acceptance Criteria
- A missing save file results in the same experience as a genuine first launch.
- A corrupted/unreadable save file does not crash the app or leave the player on a blank, unrecoverable screen.
