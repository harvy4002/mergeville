extends Node

## GameState — single source of truth for the merge grid during play.
## Autoload singleton, per .memory/architecture.md.

signal item_merged(tier: int, position: Vector2i)
signal item_spawned(position: Vector2i, tier: int)
signal grid_changed()

const GRID_WIDTH := 6
const GRID_HEIGHT := 7

## Placeholder pacing for the tap-to-generate stand-in mechanism — see
## ASSUME-003. Not persisted across restarts; resets to 0 on load.
const GENERATION_COOLDOWN_SECONDS := 3.0

## grid[x][y] is null (empty) or an int tier in [1, MergeRules.MAX_TIER].
var grid: Array = []
var generation_cooldown_remaining: float = 0.0

func _ready() -> void:
	reset_to_empty()

func _process(delta: float) -> void:
	if generation_cooldown_remaining > 0.0:
		generation_cooldown_remaining = max(0.0, generation_cooldown_remaining - delta)

func reset_to_empty() -> void:
	grid = []
	for x in range(GRID_WIDTH):
		var column: Array = []
		column.resize(GRID_HEIGHT)
		grid.append(column)

func is_within_bounds(pos: Vector2i) -> bool:
	return pos.x >= 0 and pos.x < GRID_WIDTH and pos.y >= 0 and pos.y < GRID_HEIGHT

func get_item(pos: Vector2i):
	return grid[pos.x][pos.y]

func is_empty(pos: Vector2i) -> bool:
	return get_item(pos) == null

func is_full() -> bool:
	for column in grid:
		for cell in column:
			if cell == null:
				return false
	return true

## Attempts to merge the item at `from` into `to`. Returns true on success.
## Rejects silently (no state change) on any invalid merge, per
## merge-interaction-spec.md's "Reject Invalid Merge" requirement.
func attempt_merge(from: Vector2i, to: Vector2i) -> bool:
	if not is_within_bounds(from) or not is_within_bounds(to):
		return false
	if not MergeRules.can_merge(grid, from, to):
		return false
	grid = MergeRules.resolve_merge(grid, from, to)
	var resulting_tier = grid[to.x][to.y]
	# grid_changed first so listeners rebuild views before item_merged fires
	# feedback against them (e.g. MergeGrid's refresh-then-animate ordering).
	grid_changed.emit()
	item_merged.emit(resulting_tier, to)
	return true

func can_generate_at(pos: Vector2i) -> bool:
	return is_within_bounds(pos) and is_empty(pos) and generation_cooldown_remaining <= 0.0

## Tap-to-generate placeholder (feature.md CQ-3 / ASSUME-003). Always spawns
## a tier-1 item; blocked by cooldown or an occupied/out-of-bounds slot.
func attempt_generate(pos: Vector2i) -> bool:
	if not can_generate_at(pos):
		return false
	grid[pos.x][pos.y] = 1
	generation_cooldown_remaining = GENERATION_COOLDOWN_SECONDS
	item_spawned.emit(pos, 1)
	grid_changed.emit()
	return true

## First-launch population (grid-and-starting-items-spec.md) — a small
## number of tier-1 items, leaving the remainder of the grid empty.
func populate_starting_items() -> void:
	var starting_positions := [Vector2i(2, 3), Vector2i(3, 3), Vector2i(2, 4)]
	for pos in starting_positions:
		grid[pos.x][pos.y] = 1
	grid_changed.emit()

## Replaces the grid with the given sparse cell list, e.g. from SaveSystem.
## Each cell is a Dictionary with "x", "y", "tier" (already validated).
func load_from_cells(cells: Array) -> void:
	reset_to_empty()
	for cell in cells:
		grid[cell["x"]][cell["y"]] = cell["tier"]

## Sparse serialization matching ADR-0002's save file schema: only occupied
## cells are listed.
func serialize_to_cells() -> Array:
	var cells: Array = []
	for x in range(GRID_WIDTH):
		for y in range(GRID_HEIGHT):
			var tier = grid[x][y]
			if tier != null:
				cells.append({"x": x, "y": y, "tier": tier})
	return cells
