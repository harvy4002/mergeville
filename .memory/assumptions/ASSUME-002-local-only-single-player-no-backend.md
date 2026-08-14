---
id: ASSUME-002
title: "Single-player, local-only save data, no backend/server"
component: "product/vision"
domain: "architecture"
tags: ["scope", "offline", "single-player", "no-backend"]
status: "unresolved"
created: 2026-08-09
updated: 2026-08-09
---

## Assumption

mergeville is single-player only, with all progress/save data stored locally on-device. No user accounts, cloud save/sync, multiplayer, or backend server are in scope, since there is no monetization or live-ops plan and the project's driving goal is testing solo/AI-assisted client-side game development.

## Context

Raised while drafting `.memory/product-vision.md`. The idle layer requires tracking elapsed time for offline generation, which can be done entirely client-side (e.g. timestamp diffing on load) without a server. If this assumption is wrong (e.g. cross-device sync is wanted later), it affects the architecture skill's choice of persistence approach.

## Resolution

