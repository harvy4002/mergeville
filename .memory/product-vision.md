# 🧭 Product Vision Document

## 1. Product Overview

**Product Name:**
> mergeville

**Author / Owner:**
> Harvinder Atwal (solo developer, AI-assisted)

---

## 2. Vision Statement

> Prove out how far AI-assisted, solo "vibe engineering" can take a real mobile game — using a cozy merge city-builder as the vehicle — by building a genuinely satisfying core-merge → idle-economy → city-meta loop end to end with an AI coding assistant as the primary implementation partner.

---

## 3. Problem Statement

- **Who experiences the problem?** The solo developer, who wants to understand the practical limits and workflow of AI-assisted solo game development — not an external end user with an unmet need.
- **What's the impact today?** It's unclear how much of a coherent, "fun-feeling" mobile game (systems, economy balance, UI, persistence, Android packaging) can be produced and kept consistent across sessions by an AI assistant working from structured specs, versus work that still requires significant manual intervention.
- **Why does solving this matter?** The findings inform how the developer approaches future AI-assisted projects (including the sibling project `consultantsim`) — which genres/mechanics are AI-tractable, and where the workflow (vision → architecture → feature → propose → implement) breaks down.

*Secondary, in-fiction problem the game itself solves (for the persona in section 4):* casual mobile players want a low-stress, "always something to chase" game they can dip into for a few minutes at a time without pressure, ads, or spending money.

---

## 4. Target Users / Audiences

| Persona | Description | Key Needs / Goals |
|----------|--------------|-------------------|
| The solo developer (primary, real audience) | Building mergeville as an AI-assisted engineering experiment | A working, testable core loop; clear docs/specs an AI assistant can pick up cold each session; evidence of what AI can/can't build unassisted |
| Casual mobile player (in-fiction/secondary) | Plays cozy merge/city-builder games (Merge Mansion, Township, Mergest Kingdom) in short sessions | Satisfying, low-friction merge feedback; steady sense of progress; no ads or spend pressure; "never quite finished" town to keep building |

---

## 5. Product Goals & Outcomes

> Framed around the experiment, not commercial KPIs — see [[ASSUME-001]] (`.memory/assumptions/ASSUME-001-success-metrics-are-dev-experiment-not-game-kpis.md`).

| Goal | Metric / KPI | Desired Outcome |
|------|----------------|-----------------|
| Ship a playable core loop | Merge → idle generation → meta unlock all functioning end-to-end in a single Android build | Loop is playable and internally consistent, no dead ends |
| Validate AI-assisted solo workflow | Proportion of features implemented via `propose`/`implement` skills without manual rewrite | High proportion of code/specs survive without significant hand-correction |
| Avoid known genre failure mode | Design review confirms the meta layer keeps introducing new goals past early merge tiers | No hard "power curve flattens, nothing left to chase" wall, unlike Survivor.io's observed D30 collapse |
| Keep the loop fun | Developer's own playtesting sessions | Developer voluntarily wants to keep playing/building past a single test session |

---

## 6. Key Features / Capabilities

- **Merge grid (core loop):** drag two matching items together to combine into the next tier, with immediate visual/audio feedback (pop/level-up animation), deterministic merge rules.
- **Idle economy layer:** buildings/resource nodes passively spawn low-tier items over time, including while the app is closed (offline progress calculated on return).
- **City-builder meta layer:** higher-tier merge results unlock new buildings that get placed on an expanding town map, creating a long-horizon progression/collection goal.
- **Local save/progress:** on-device persistence of grid state, town layout, and currencies (see [[ASSUME-002]]).
- **Android packaging:** exportable, installable Android build (Godot 4.x/GDScript — see `.memory/architecture.md`).

---

## 7. Value Proposition

| For (user type) | Who want to (need) | Our product (solution) | Unlike (alternative) |
|-----------------|---------------------|------------------------|-----------------------|
| The solo developer | Test the real limits of AI-assisted solo game development | A structured, spec-driven build of a full mobile game genre with an AI coding assistant, from vision through implementation | Building solo without AI assistance (slower, no comparison point) or building a genre with high manual "feel-tuning" needs (bullet-heaven), which would confound the experiment |
| Casual mobile player (in-fiction) | A relaxing, low-stakes game to dip into | A cozy, pastel merge city-builder with no ads, no IAP, and no monetization pressure | Existing merge games (Merge Mansion, Township), which monetize aggressively via ads/IAP |

---

## 8. Constraints / Assumptions

- No monetization: free to play, no ads, no in-app purchases — see product overview above.
- No dedicated user base or marketing plan; this is not intended for public commercial launch during this phase.
- Solo development, AI-assisted: scope must stay within what one developer + AI assistant can realistically implement and test.
- Engine/stack: Godot 4.x / GDScript, chosen for Android export simplicity and consistency with the sibling project `consultantsim` — to be formalized as an ADR in the architecture skill.
- [[ASSUME-001]] — success is measured by the dev experiment, not game KPIs.
- [[ASSUME-002]] — single-player, local-only save data, no backend/server.

---

## 9. Success Metrics

- **Primary metric(s):** A complete, playable core-loop → idle → meta build exists on Android; the specification-driven AI workflow (vision/architecture/feature/propose/implement) was used to build a majority of it.
- **Secondary metric(s):** Number of manual corrections/overrides needed against AI-generated specs and code.
- **Qualitative indicators:** The developer finds the loop genuinely engaging in playtesting; the meta layer avoids feeling "finished" or flat after early merge tiers.

---

## 10. Stakeholders

| Role | Name / Team | Interest / Contribution |
|------|--------------|-------------------------|
| Developer / Product Owner | Harvinder Atwal | Sole decision-maker, implementer, and player-tester |
| AI Assistant | Claude Code | Implementation partner across the full SDLC skill workflow |

---

## 11. Risks & Open Questions

- **Genre retention risk:** merge/city-builder games commonly flatten in late-game (see Survivor.io D30 collapse noted in `.memory/knowledge/KB-0001-initial-concept-and-scaffolding-decisions.md`) — the city-meta layer needs deliberate design attention to avoid this, to be addressed in the `feature`/`design` skills rather than left implicit.
- **Open question:** should an iOS or cross-platform export ever be pursued, or does the experiment stay Android-only indefinitely? (Currently out of scope — revisit if the experiment's goals change.)
- **Open question:** is any minimal telemetry/logging wanted to self-assess "is this fun" objectively, or is developer playtesting sufficient? (Currently assumed: playtesting only, no telemetry — no backend per [[ASSUME-002]].)

---

## 12. References

- `.memory/knowledge/KB-0001-initial-concept-and-scaffolding-decisions.md` — pre-`init-project` brainstorming and genre rationale.
- Sibling project: `consultantsim` (Godot 4.x/GDScript reference point).
- Genre references: Merge Mansion, Township, Mergest Kingdom, Survivor.io (retention counter-example).

## Value Rule Set

> Added via the `value` skill. mergeville has no organization, revenue target, or user base — see Section 8, Constraints. "Value" here is redefined around the experiment's own goals (Section 5) rather than commercial value drivers (revenue, cost savings, user growth), since those don't apply to a solo, non-monetized, non-launched project.

- **Primary Value Driver(s)**: (1) Experiment Validation — evidence about how much of the game the AI-assisted spec→implement workflow can build with minimal manual correction; (2) Core Loop Progress — tangible movement toward a complete, playable merge → idle → meta loop; (3) Genre-Risk Mitigation — deliberate avoidance of known failure modes in this genre (e.g. late-game retention collapse, see KB-0001); (4) Developer Enjoyment — the loop is genuinely fun to the developer in playtesting.
- **Strategic Goals Alignment**: Directly maps to `.memory/product-vision.md` Section 5 (Product Goals & Outcomes) — this rule set is that section reframed as go/no-go criteria for individual features rather than product-wide goals.

| Rule / Criterion | Description | Minimum Threshold for Go |
|---|---|---|
| Vision Alignment | Feature implements or directly enables one of the three core-loop layers (merge grid, idle economy, city-builder meta) or genuinely blocks another feature that does. | Must align with at least one layer — no "nice to have" features unrelated to the core loop. |
| Testability | Feature has clear, testable success criteria per `.memory/testing.md` (unit-testable logic where deterministic, playtestable where subjective). | Must have at least one measurable/testable success criterion. |
| Workflow Fit | Feature is scoped so it can realistically be planned (`propose`) and built (`implement`) by a solo developer with AI assistance in a reasonably short cycle. | Must not require capabilities/scope explicitly deferred in `.memory/product-vision.md` (e.g. backend, monetization, multiplayer). |
| Genre-Risk Awareness | For features touching progression/retention (especially the meta layer), the design should show awareness of the flattening-power-curve failure mode. | Not a hard blocker for early/foundational features (e.g. the core grid), but required before meta-layer/progression-pacing features ship. |

Given the low bar appropriate to a solo experiment, this rule set exists mainly to keep scope honest (reject work that doesn't serve the stated experiment or vision) rather than to gate investment decisions.
