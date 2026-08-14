extends RefCounted
class_name MergeRules

## Pure, stateless merge logic: grid state in, grid state (or verdict) out.
## No scene/node dependencies, per .memory/architecture.md's Key Patterns —
## keeps merge rules directly unit-testable without instancing the scene tree.

const MAX_TIER := 5

## grid is an Array[Array] indexed grid[x][y]; a cell is null (empty) or an
## int tier in [1, MAX_TIER].
static func can_merge(grid: Array, from: Vector2i, to: Vector2i) -> bool:
	if not _is_adjacent(from, to):
		return false
	var tier_a = grid[from.x][from.y]
	var tier_b = grid[to.x][to.y]
	if tier_a == null or tier_b == null:
		return false
	if tier_a != tier_b:
		return false
	if tier_a >= MAX_TIER:
		return false
	return true

## Precondition: can_merge(grid, from, to) is true. Returns a new grid with
## the merge applied — does not mutate the input grid.
static func resolve_merge(grid: Array, from: Vector2i, to: Vector2i) -> Array:
	var new_grid := _clone_grid(grid)
	var resulting_tier: int = new_grid[from.x][from.y] + 1
	new_grid[to.x][to.y] = resulting_tier
	new_grid[from.x][from.y] = null
	return new_grid

static func _is_adjacent(a: Vector2i, b: Vector2i) -> bool:
	var diff := (a - b).abs()
	return diff.x + diff.y == 1

static func _clone_grid(grid: Array) -> Array:
	var new_grid: Array = []
	for column in grid:
		new_grid.append(column.duplicate())
	return new_grid
