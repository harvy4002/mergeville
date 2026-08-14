# Value Assessment: Merge Grid Core Loop

**Date**: 2026-08-09
**Status**: Draft

## 1. Context

- **Feature / Initiative**: Merge Grid Core Loop
- **Associated Vision**: `.memory/product-vision.md` (Section 6, Key Features — "Merge grid (core loop)"; Value Rule Set)
- **Feature Specification**: `.memory/specs/merge-grid-core-loop/feature.md`

## 2. Organizational Value Definition

mergeville has no organization, revenue target, or external user base (solo, non-monetized experiment — see `.memory/product-vision.md` Section 8). Value is defined per the product vision's Value Rule Set: experiment validation, core loop progress, genre-risk mitigation, and developer enjoyment — not commercial value drivers.

- **Primary Value Driver(s)**: Core Loop Progress (primary), Experiment Validation (primary), Developer Enjoyment (secondary).
- **Strategic Goals Alignment**: This is the single most foundational feature in the product vision — layer 1 of 3 in the core loop (Section 6), and a prerequisite for every other planned feature (idle economy, city-builder meta).

## 3. Value Rule Set

See `.memory/product-vision.md` — Value Rule Set section (Vision Alignment, Testability, Workflow Fit, Genre-Risk Awareness).

## 4. Feature Assessment

| Criterion | Expected Impact | Confidence Level (High/Med/Low) | Notes / Evidence |
|-----------|-----------------|---------------------------------|------------------|
| Vision Alignment | Directly implements layer 1 of the core loop and is a hard dependency for layers 2 and 3. | High | `.memory/product-vision.md` Section 6 names the merge grid explicitly as a key feature. |
| Testability | Merge rules and persistence are deterministic and unit-testable; drag feel is playtestable. Success Criteria SC-001 to SC-004 are defined in `feature.md`. | High | `.memory/testing.md` already scopes unit tests for exactly this kind of logic. |
| Workflow Fit | Scoped tightly to grid + merge + persistence only; idle economy and meta layer explicitly excluded, keeping this buildable as one `propose`/`implement` cycle. | High | Feature spec explicitly excludes out-of-scope layers. |
| Genre-Risk Awareness | Not directly applicable — this feature has no long-term progression/retention pacing decisions (those belong to the future meta-layer feature). | N/A (not a blocker per rule set) | Rule set marks this non-blocking for foundational features. |

## 5. Assumptions

- [ASSUME-002](../../assumptions/ASSUME-002-local-only-single-player-no-backend.md) — local-only persistence underpins the Progress Persistence sub-feature's approach.
- Five open product clarifications (tier count, grid size, new-item generation mechanism, stuck-state handling, max-tier behavior) are tracked directly in `feature.md` Section 6 (Decisions & Clarifications) rather than as separate ASSUME records, since they are pending direct user answers in this same session rather than standing assumptions.

## 6. Conclusion & Recommendation

**Recommendation**: GO

**Rationale**: This feature is the foundational, unavoidable first building block of mergeville — every rule in the Value Rule Set is satisfied at a high confidence level, and no other feature can proceed without it. The five open clarifications in `feature.md` are product-level details to resolve before `propose`/`implement`, not blockers to the value case itself.

---

## 7. Knowledge Captured

- [KB-0002](../../knowledge/KB-0002-value-definition-for-a-non-commercial-solo-experiment.md) — value definition rationale for this project.
