---
id: FEAT-0001
title: "Merge Grid Core Loop"
status: Draft
req: REQ-0001 to REQ-0012
created: 2026-08-09
---

# Feature Specification: Merge Grid Core Loop

**Created**: 2026-08-09
**Status**: Draft
**Input**: User description: "First feature to spec: the Merge Grid core loop — the foundational vertical slice everything else builds on. Scope: a grid of item slots; player drags one item onto a matching adjacent item; matching pairs merge into the next tier item with visual/audio feedback; merge rules and tier progression are deterministic; grid state persists across app restarts. No idle economy or town-map/meta layer yet."

## 1. Overview

The Merge Grid Core Loop is the foundational, playable slice of mergeville: a grid of item slots on which the player drags matching items together to merge them into higher-tier items, with satisfying feedback on each merge. This feature delivers the tight core action described in `.memory/product-vision.md` (layer 1 of 3) in isolation — the idle economy (layer 2) and city-builder meta layer (layer 3) are explicitly out of scope and will be built as later features that hook into this one's outcomes (e.g. via a "tier reached" signal, per `.memory/architecture.md`).

## 2. Problem Statement

Without this feature, mergeville has no playable mechanic at all — every other layer (idle generation, town building) depends on the merge grid existing first, since they are defined as consuming or reacting to merge outcomes. The immediate problem this feature solves is proving out the single most important question for the project's stated experiment goal (`.memory/product-vision.md`, Section 5): can a satisfying, correctly-functioning core merge loop be built end-to-end via the AI-assisted spec → implement workflow?

## 3. User Personas

Per `.memory/product-vision.md`:

- **The solo developer** (primary, real audience): needs a working, testable core loop to validate the AI-assisted build process and to have something concrete to playtest.
- **Casual mobile player** (in-fiction/secondary): wants an instantly satisfying, low-friction drag-to-merge interaction they can dip into for short sessions.

## 4. Testing Strategy & Objectives *(mandatory)*

Per `.memory/testing.md`, this feature's critical paths are: (1) a merge only succeeds between matching items and always produces the correct next tier, (2) grid state (item positions and tiers) survives an app restart with no loss or corruption, (3) the drag-and-merge interaction feels responsive with immediate feedback. The first two are objective/deterministic and should be covered by automated unit tests (merge rule correctness, save/load round-trip); the third is subjective and validated via manual playtesting. Detailed technical test cases are out of scope for this document and will be produced by the `propose` skill's `test-cases.md`.

### Edge Cases

- What happens when the player drags an item onto a slot containing a non-matching item?
- What happens when the player drags an item and drops it outside the grid (e.g. releases mid-drag over empty space)?
- What happens when a merge would produce an item beyond the highest defined tier?
- What happens when the saved grid state is missing or corrupted on load?
- What happens when every grid slot is full and no adjacent matching pair exists (a potential "stuck" state)?

## 5. Sub-features & Specifications *(mandatory)*

- [Grid & Starting Items](grid-and-starting-items-spec.md) — the grid's initial layout and first-launch item population.
- [Merge Interaction](merge-interaction-spec.md) — the drag-to-merge mechanic and its feedback.
- [Tier Progression](tier-progression-spec.md) — the defined sequence of item tiers within this slice's scope.
- [Progress Persistence](progress-persistence-spec.md) — saving and restoring grid state across sessions.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A player can complete at least one full merge (dragging two matching items together to produce the next tier) within their first 30 seconds of play, with no instructions beyond on-screen prompts.
- **SC-002**: 100% of valid merges (matching adjacent items, result tier defined) succeed; 100% of invalid merge attempts (non-matching items, undefined result tier) are rejected without side effects.
- **SC-003**: Closing and reopening the app restores the grid to the exact state it was in before closing, with no item loss, on 100% of manual test passes.
- **SC-004**: In developer playtesting, the merge action feels immediate — visual/audio feedback plays with no perceptible delay after a valid merge.

## 6. Decisions & Clarifications

| # | Question | Answer |
|---|----------|--------|
| CQ-1 | How many item tiers should this initial slice define/support? | **5 tiers** (tier 1 through tier 5). Confirmed 2026-08-09. |
| CQ-2 | What are the grid dimensions? | **6 columns × 7 rows**. Confirmed 2026-08-09. |
| CQ-3 | Since the idle economy (which normally spawns new base-tier items) is out of scope for this feature, how does the player get new tier-1 items to keep merging? | **Tap-to-generate on cooldown**: tapping an empty slot spawns a tier-1 item after a short cooldown. Confirmed 2026-08-09 as a placeholder, explicitly intended to be swapped out once the idle economy feature exists. |
| CQ-4 | What happens if the grid fills up completely with no possible matching-adjacent merge (stuck state)? | **Simple stop state**: new item generation (tap-to-generate) is blocked while the grid is full, with no popup or game-over — the player simply cannot spawn further items until a slot frees up via a merge. Confirmed 2026-08-09. |
| CQ-5 | Should reaching the maximum tier item do anything special (e.g. convert to a currency/score), or is it simply a dead-end item that can't merge further in this slice? | **Simple stop state**: the max-tier (tier 5) item sits on the grid with no special conversion or messaging; occupies a slot until a future feature (e.g. city-builder meta layer) gives it a purpose. Confirmed 2026-08-09. |

All five clarifications resolved by the user on 2026-08-09, accepting the recommended defaults from each option set.
