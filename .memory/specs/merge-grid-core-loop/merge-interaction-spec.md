## ADDED Requirements

### Requirement: Drag-to-Merge
When the player drags an item and releases it onto an adjacent slot containing another item of the same type and tier, the system shall merge the two items into a single item of the next tier, placed in the slot where the item was released, and clear the origin slot.

#### Acceptance Criteria
- Dragging a tier-N item onto a matching tier-N item produces exactly one tier-(N+1) item.
- The origin slot becomes empty after a successful merge.
- The merge completes within a single continuous drag-and-release gesture (no extra confirmation step).

### Requirement: Reject Invalid Merge
If the player drags an item and releases it onto a slot containing a non-matching item (different type or tier), the system shall prevent the merge and return the dragged item to its original slot.

#### Acceptance Criteria
- No new item is created and no existing item is destroyed when an invalid merge is attempted.
- The dragged item visibly animates back to its original slot.
- Repeated invalid merge attempts do not corrupt or change the state of either involved slot.

### Requirement: Merge Feedback
When a merge occurs, the system shall play a visual and audio feedback effect (per `.memory/design-guidelines.md` Component Behaviors) indicating a successful merge.

#### Acceptance Criteria
- Every successful merge triggers a visible animation on the resulting item.
- Every successful merge plays an audio cue.
- The feedback plays immediately (no perceptible delay) after the merge completes, per Success Criteria SC-004 in `feature.md`.

### Requirement: Prevent Merging Beyond Maximum Tier
If a merge would produce an item beyond tier 5 (the highest tier defined for this feature, per Decisions & Clarifications CQ-1 in `feature.md`), then the system shall prevent that merge from occurring, leaving both source items unchanged in place.

#### Acceptance Criteria
- Two matching tier-5 items cannot be merged with each other.
- Attempting to do so behaves identically to an invalid merge (see Reject Invalid Merge above): no state change, dragged item returns to origin.
- No special conversion, score, or messaging occurs for tier-5 items in this feature — that is explicitly deferred to a future feature, per Decisions & Clarifications CQ-5 in `feature.md`.
