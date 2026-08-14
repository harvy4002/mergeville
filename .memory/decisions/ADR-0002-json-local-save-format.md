---
id: ADR-0002
title: "Use plain JSON for the local save file format"
component: "persistence"
domain: "architecture"
tags: ["save-system", "persistence", "json", "godot"]
status: "accepted"
created: 2026-08-09
updated: 2026-08-09
---

# Decision Record: 0002. Use plain JSON for the local save file format

**Feature:** merge-grid-core-loop (Progress Persistence sub-feature)
**Date:** 2026-08-09
**Deciders:** Harvinder Atwal (via `propose` skill planning)
**Status:** Accepted

## Context

The Save/Persistence system (`.memory/architecture.md`) needs a concrete on-disk format for grid state (item positions/tiers) local to the device (see [[ASSUME-002]]). There is no anti-cheat, leaderboard, or competitive-integrity requirement (`.memory/testing.md`, `.memory/architecture.md` Cross-Cutting Concerns explicitly deprioritize save-tampering defense), so the format can optimize for developer debuggability over obfuscation.

## Options Considered

* **Option 1:** Plain JSON via Godot's `FileAccess` + `JSON.stringify`/`JSON.parse`.
* **Option 2:** Godot binary `Resource` (`.tres`/`.res`) serialization of a custom `SaveData` Resource class.
* **Option 3:** Godot's `ConfigFile` (INI-style).

## Evaluation

### Option 1: Plain JSON
* **Pros:** Human-readable — easy for the solo developer to inspect/edit save files directly while debugging; straightforward versioning (a `version` field); no engine-specific binary format to worry about across Godot version upgrades.
* **Cons:** No built-in schema enforcement; must hand-write parsing/validation.

### Option 2: Binary Resource serialization
* **Pros:** Native to Godot, minimal boilerplate.
* **Cons:** Not human-readable, harder to debug; Godot Resource serialization has had breaking format changes across versions, a risk for the save-compatibility this project doesn't want to manage.

### Option 3: ConfigFile
* **Pros:** Built into Godot, simple key/value.
* **Cons:** Poor fit for nested/array data like a 42-slot grid; would require awkward flattening.

## Decision

Use **plain JSON**, written/read via Godot's `FileAccess` and `JSON` singleton, stored at `user://save_data.json`.

## Consequences

### Positive
* Easy to inspect and hand-edit during development/debugging.
* Simple to add a `version` field now for the "handle missing/corrupted save" requirement (see progress-persistence-spec.md) — an unreadable or unparseable file triggers the documented fresh-game fallback.

### Negative
* No enforced schema — malformed hand-edits or future field changes must be defended against explicitly in the load path (already required regardless, per the corrupted-save-data requirement).
* Save data is trivially readable/editable by the player — acceptable since there's no competitive integrity to protect at this stage.
