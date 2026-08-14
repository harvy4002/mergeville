## ADDED Requirements

### Requirement: Defined Tier Sequence
The system shall define a fixed sequence of 5 item tiers for this feature (tier 1 through tier 5), each with a distinct visual identity (per `.memory/design-guidelines.md` color/icon differentiation rules).

#### Acceptance Criteria
- Every tier in the sequence is visually distinguishable from every other tier by shape/icon, not color alone.
- The player can reach tier 5 through repeated merges starting from tier-1 items, without any tier being unreachable.
- Tier 5 is a hard cap for this feature (see Merge Interaction spec, "Prevent Merging Beyond Maximum Tier"); it sits on the grid with no special conversion behavior, per Decisions & Clarifications CQ-5 in `feature.md`.

### Requirement: Deterministic Merge Outcome
The system shall ensure that merging two items of the same tier always produces the same resulting tier, with no randomness or variation.

#### Acceptance Criteria
- Repeating the same merge (same starting tiers) always yields the same resulting tier.
- No player action or game state affects which tier results from a given merge.
