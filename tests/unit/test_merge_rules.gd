extends GutTest

## Covers TC-01, TC-06, TC-11 (test-cases.md) plus purity/adjacency checks.

func _make_empty_grid() -> Array:
	var grid: Array = []
	for x in range(6):
		var column: Array = []
		column.resize(7)
		grid.append(column)
	return grid

func test_can_merge_true_for_matching_adjacent_tiers():
	var grid := _make_empty_grid()
	grid[0][0] = 1
	grid[0][1] = 1
	assert_true(MergeRules.can_merge(grid, Vector2i(0, 0), Vector2i(0, 1)))

func test_resolve_merge_produces_next_tier_and_clears_source():
	var grid := _make_empty_grid()
	grid[0][0] = 1
	grid[0][1] = 1
	var result := MergeRules.resolve_merge(grid, Vector2i(0, 0), Vector2i(0, 1))
	assert_eq(result[0][1], 2, "target cell should hold the next tier")
	assert_eq(result[0][0], null, "source cell should be cleared")

func test_can_merge_false_for_mismatched_tiers():
	var grid := _make_empty_grid()
	grid[0][0] = 1
	grid[0][1] = 2
	assert_false(MergeRules.can_merge(grid, Vector2i(0, 0), Vector2i(0, 1)))

func test_can_merge_false_when_target_is_empty():
	var grid := _make_empty_grid()
	grid[0][0] = 1
	assert_false(MergeRules.can_merge(grid, Vector2i(0, 0), Vector2i(0, 1)))

func test_can_merge_false_for_non_adjacent_cells():
	var grid := _make_empty_grid()
	grid[0][0] = 1
	grid[2][2] = 1
	assert_false(MergeRules.can_merge(grid, Vector2i(0, 0), Vector2i(2, 2)))

func test_can_merge_false_at_max_tier():
	var grid := _make_empty_grid()
	grid[0][0] = MergeRules.MAX_TIER
	grid[0][1] = MergeRules.MAX_TIER
	assert_false(
		MergeRules.can_merge(grid, Vector2i(0, 0), Vector2i(0, 1)),
		"tier 5 items must not merge further"
	)

func test_resolve_merge_does_not_mutate_input_grid():
	var grid := _make_empty_grid()
	grid[0][0] = 1
	grid[0][1] = 1
	MergeRules.resolve_merge(grid, Vector2i(0, 0), Vector2i(0, 1))
	assert_eq(grid[0][0], 1, "input grid must be unchanged (pure function)")
	assert_eq(grid[0][1], 1, "input grid must be unchanged (pure function)")
