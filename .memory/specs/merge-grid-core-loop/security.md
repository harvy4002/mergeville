# Security Assessment: Merge Grid Core Loop

**Target Plan:** `.memory/specs/merge-grid-core-loop/proposal.md` | **Context:** *Single-player, fully offline Android game feature. No network calls, no backend, no user accounts, no PII, no monetization ([[ASSUME-002]]). Only "data" involved is local gameplay state (grid contents) persisted to a local JSON file ([ADR-0002](../../decisions/ADR-0002-json-local-save-format.md)).*

## 1. Context Validation

| Attribute | Declared | Assessment | Match? |
|---|---|---|---|
| Data Sensitivity | Public / Non-sensitive (gameplay state only, no PII) | `intent.md`'s save schema contains only grid coordinates and item tiers — no personal, account, or device-identifying data | ✅ |
| Network Exposure | None — fully offline | No network client/server code proposed anywhere in `proposal.md`/`intent.md` | ✅ |

## 2. CIA Triad

| Pillar | Status | Notes | Controls |
|---|---|---|---|
| Confidentiality | Pass (N/A) | No sensitive data exists to disclose; save file is plain, locally-readable gameplay state only. | None required. |
| Integrity | Pass (low stakes) | Save-file tampering only affects the tampering player's own single-player progress; no leaderboard/competitive integrity to protect (`.memory/architecture.md` Cross-Cutting Concerns). | `SaveSystem.load()` must reject malformed/unrecognized-version files gracefully (fresh-game fallback, per `intent.md`) — a robustness control, not an anti-tamper one. |
| Availability | Pass | Single-device, offline app; no shared service to disrupt. A corrupted save degrades gracefully to a fresh game rather than blocking play (`intent.md` Validation Rules). | Fresh-game fallback on load failure. |

## 3. Data Flow

| Flow | Source | Dest | Type | Trust Boundary? | Protocol | Controls |
|---|---|---|---|---|---|---|
| Grid state write | `GameState` (in-memory) | `user://save_data.json` (device local storage) | Gameplay state (non-sensitive) | No — same device, same trust level (player's own device/app sandbox) | Local filesystem (Godot `FileAccess`) | Version field + parse-failure fallback (`intent.md`) |
| Grid state read | `user://save_data.json` | `GameState` (in-memory) | Gameplay state (non-sensitive) | No | Local filesystem | Schema/version validation before trusting file contents |

No other data flows exist for this feature — no network egress/ingress, no third-party SDKs, no analytics/telemetry (per `.memory/architecture.md` Cross-Cutting Concerns).

## 4. Threat Assessment

* **Local save-file tampering (Low severity):** A player could hand-edit `user://save_data.json` (readable/editable per [ADR-0002](../../decisions/ADR-0002-json-local-save-format.md)) to set arbitrary tiers or fill the grid. Accepted risk: this is a single-player, non-monetized, non-competitive game — a player "cheating" only affects their own local experience, per `.memory/architecture.md`'s explicit deprioritization of this concern.
* **Malformed/malicious save-file input (Low severity, robustness not security):** A hand-edited or corrupted file with out-of-range tiers (e.g. `"tier": 999`) or malformed JSON could crash the load path if not defended against. Mitigated by the `intent.md` requirement that `SaveSystem.load()` returns `false` and falls back to a fresh game on any parse failure or invalid schema/version — this must also validate that `tier` values fall within `[1, 5]` and grid coordinates fall within the 6×7 bounds, treating any out-of-range value the same as a corrupted file.
* **No PII/GDPR exposure:** No personal data is collected, stored, or transmitted by this feature. PII/GDPR scan: not applicable.

## 5. Compliance

* **Zero Trust / Secure by Design:** Not meaningfully applicable — there is no network boundary or multi-party trust relationship in this feature. The one relevant "secure by design" practice is data minimization by default, which is already satisfied (the save schema stores only grid coordinates/tiers, nothing more, per `intent.md`).
* **Anti-Patterns:** None of the NCSC anti-patterns (Browse-Up, Management Bypass, Implicit Trust) apply to a fully offline, single-user, single-process application with no privilege boundaries.

## 6. Required Remediation

### A. Architecture
* [x] No changes required — offline-only architecture already minimizes attack surface by construction.

### B. Requirements
* [ ] **Bounds-check loaded save data:** `SaveSystem.load()` must validate that every loaded `tier` value is an integer in `[1, 5]` and every `(x, y)` falls within the 6×7 grid, treating any violation as a corrupted file (same fresh-game fallback as a JSON parse failure). *(Rationale: Secure by Design — never trust locally-writable input, even in a low-stakes context; also directly serves the existing "handle corrupted save data" functional requirement.)*

### C. Anti-Patterns
* [ ] None identified.

## 7. Remediation Tasks

- [ ] [Security] [Global] `SaveSystem.load()` validates tier range `[1,5]` and grid bounds `(0-5, 0-6)` on every loaded entry; treats any out-of-range value as a corrupted file and falls back to first-launch population.
