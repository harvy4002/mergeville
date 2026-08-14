# mergeville — Test Strategy

## Overview

mergeville is a solo, AI-assisted, concept-stage Android game (Godot 4.x/GDScript) with no backend, no network calls, no user accounts, and no monetization (see `.memory/product-vision.md`, `.memory/architecture.md`). The test strategy is deliberately **lightweight**, matched to that scope: automated unit tests cover the deterministic, math-heavy systems (merge rules, idle/offline economy, save/load), while everything about "does this feel fun" is validated through manual playtesting by the developer. Levels that assume a server, live traffic, or sensitive data (Performance API, Security, formal Accessibility compliance) are explicitly scoped down or deferred below rather than treated as gaps — they should be revisited if the project's scope changes (e.g. a backend, monetization, or public release is added later).

## Test Environments & Access

- **Environments:** Local only — the Godot editor (for unit tests and iteration) and a physical or emulated Android device (for manual playtesting of exported builds). No CI, staging, or production environment exists.
- **Access Needs:** None beyond a local Godot 4.x install and Android export template/keystore for manual builds.
- **Data Management:** No shared or seeded test data — unit tests construct minimal in-memory fixtures (e.g. item/building `Resource` instances) per test; local save files used for manual testing can be freely deleted/reset since there is no shared state to protect.
- **CI/CD Integration:** None at this stage. Builds are exported manually from the Godot editor. This is a deliberate concept-stage choice (solo project, no release cadence to support) — revisit (e.g. a simple GitHub Actions workflow running GUT headless) once the project matures past the experimental phase.

## Testing Approach

| Level | Scope / Objective | Tools / Frameworks | Success Criteria | Responsibilities |
|---|---|---|---|---|
| **Unit** | Deterministic logic: merge rules (item + item → next tier), idle/offline economy math (resource generation over elapsed time), save/load serialization round-trips. | GUT (Godot Unit Test) for GDScript | All merge/economy/save logic has passing unit tests before a feature is considered done; no formal coverage % target given solo/lightweight scope. | Developer (AI-assisted) |
| **Integration** | Cross-system interaction via signals (e.g. a merge reaching unlock threshold correctly notifies the Town Meta system; save system correctly persists combined state from all three systems). | GUT, run against real in-editor scene instances (no mocking needed — no external systems to isolate). | Key signal contracts (documented in `.memory/architecture.md`) verified by at least one test each. | Developer (AI-assisted) |
| **Functional** | Feature verification against `feature`/`propose` skill acceptance criteria for each shipped feature. | Manual playtesting in the Godot editor and on an Android device/emulator. | All acceptance criteria in the relevant `.memory/specs/{feature-name}/intent.md` are manually confirmed. | Developer |
| **End-to-End (E2E)** | Full loop: launch app → merge items → generate idle resources (incl. offline) → unlock/place a building → close and relaunch to confirm persistence. | Manual playtesting only. | Full loop completable without crashes or state loss across an app restart. | Developer |
| **Performance (API)** | N/A — no backend/API exists. | N/A | N/A | N/A |
| **Performance (Web/Client)** | On-device frame rate and responsiveness of grid/merge and idle-tick logic on a low-to-mid-range Android device. | Manual observation (Godot's in-editor profiler when investigating a specific issue). | No noticeable frame drops or input lag during merge/drag interactions during manual playtesting; no formal FPS budget set at this stage. | Developer |
| **Security** | Explicitly deferred/non-goal at this stage. No backend, no PII, no accounts, no monetization to protect — see `.memory/architecture.md` Cross-Cutting Concerns. | N/A | N/A — revisit if a backend, accounts, or monetization are ever introduced. | N/A |
| **Accessibility** | Basic mobile-game accessibility only (colorblind-safe tier differentiation, touch target sizing, text legibility) as defined in `.memory/design-guidelines.md`, verified via manual review rather than a formal compliance audit. | Manual design review against `.memory/design-guidelines.md`. | New UI/merge-tier art checked against the color-independence and touch-target rules before merging a feature. | Developer |

## Risk & Mitigation

| Risk | Mitigation |
|---|---|
| Economy/merge math bugs (e.g. incorrect tier progression, wrong offline-gain calculation) going unnoticed without a backend to catch anomalies | Unit tests for merge rules and idle economy math are treated as required, not optional, for those specific systems — see Unit row above. |
| Save/load corruption or data loss (only copy of progress is the local save file) | Save/Persistence unit tests cover round-trip serialization; save system falls back to a fresh game state on a corrupt/missing file rather than crashing (see `.memory/architecture.md`). |
| No CI means regressions in previously-working systems can silently reappear | Re-run the full GUT suite locally before considering any feature "done" in the `implement` skill workflow, even without automated enforcement. |
| Manual-only functional/E2E testing is subjective and easy to skip under solo-dev time pressure | Each feature's `.memory/specs/{feature-name}/test-cases.md` (per `.memory/specification-conventions.md`) should list the specific manual steps to re-run, so playtesting stays checklist-driven rather than ad hoc. |

## Sign off

| Name | Role | Approved | Date |
|---|---|---|---|
| Harvinder Atwal | Developer / Test Lead | [ ] | 2026-08-09 |
