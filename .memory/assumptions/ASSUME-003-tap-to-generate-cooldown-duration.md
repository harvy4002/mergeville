---
id: ASSUME-003
title: "Tap-to-generate cooldown is 3 seconds and resets on app relaunch"
component: "merge-grid/item-generation"
domain: "gameplay-balance"
tags: ["cooldown", "balance", "merge-grid-core-loop"]
status: "unresolved"
created: 2026-08-09
updated: 2026-08-09
---

## Assumption

The tap-to-generate placeholder mechanism (grid-and-starting-items-spec.md, "New Item Generation") uses a **3-second cooldown** between spawns, and the cooldown timer is **not persisted** across app restarts (it simply resets to "ready" on load, rather than being saved/restored). No other pacing value was specified in `feature.md`.

## Context

Raised during `propose` skill planning for merge-grid-core-loop. 3 seconds is a placeholder balance value chosen to keep the loop moving briskly for solo playtesting without making spawning instantaneous/trivial; since this whole mechanism is explicitly a stand-in for the future idle economy feature (per Decisions & Clarifications CQ-3 in `feature.md`), exact tuning isn't critical here. Not persisting the cooldown avoids adding a timestamp field to the save schema for a value that resets naturally on every launch anyway.

## Resolution

