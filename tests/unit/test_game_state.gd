extends GutTest

## Covers TC-03, TC-08, TC-12 (test-cases.md) plus GameState's grid-level
## wrapping of MergeRules.

func before_each():
	GameState.reset_to_empty()
	GameState.generation_cooldown_remaining = 0.0

func test_attempt_merge_succeeds_for_matching_adjacent_items():
	GameState.grid[0][0] = 1
	GameState.grid[0][1] = 1
	var result := GameState.attempt_merge(Vector2i(0, 0), Vector2i(0, 1))
	assert_true(result)
	assert_eq(GameState.grid[0][1], 2)
	assert_eq(GameState.grid[0][0], null)

func test_attempt_merge_fails_for_mismatched_items_and_leaves_grid_unchanged():
	GameState.grid[0][0] = 1
	GameState.grid[0][1] = 2
	var result := GameState.attempt_merge(Vector2i(0, 0), Vector2i(0, 1))
	assert_false(result)
	assert_eq(GameState.grid[0][0], 1)
	assert_eq(GameState.grid[0][1], 2)

func test_attempt_merge_fails_at_max_tier():
	GameState.grid[0][0] = MergeRules.MAX_TIER
	GameState.grid[0][1] = MergeRules.MAX_TIER
	var result := GameState.attempt_merge(Vector2i(0, 0), Vector2i(0, 1))
	assert_false(result)

func test_attempt_generate_spawns_tier_one_on_empty_slot():
	var result := GameState.attempt_generate(Vector2i(1, 1))
	assert_true(result)
	assert_eq(GameState.grid[1][1], 1)

func test_attempt_generate_blocked_during_cooldown():
	GameState.attempt_generate(Vector2i(1, 1))
	var second_result := GameState.attempt_generate(Vector2i(2, 2))
	assert_false(second_result, "generation should be blocked while cooldown is active")
	assert_eq(GameState.grid[2][2], null)

func test_attempt_generate_blocked_on_occupied_or_full_grid():
	for x in range(GameState.GRID_WIDTH):
		for y in range(GameState.GRID_HEIGHT):
			GameState.grid[x][y] = 1
	var result := GameState.attempt_generate(Vector2i(0, 0))
	assert_false(result, "cannot generate onto an occupied slot / full grid")

func test_is_full_true_when_all_slots_occupied():
	for x in range(GameState.GRID_WIDTH):
		for y in range(GameState.GRID_HEIGHT):
			GameState.grid[x][y] = 1
	assert_true(GameState.is_full())

func test_is_full_false_with_any_empty_slot():
	assert_false(GameState.is_full())

func test_populate_starting_items_leaves_most_slots_empty():
	GameState.populate_starting_items()
	var occupied := 0
	for column in GameState.grid:
		for cell in column:
			if cell != null:
				occupied += 1
	assert_gt(occupied, 0, "at least one starting item should be placed")
	assert_lt(
		occupied,
		GameState.GRID_WIDTH * GameState.GRID_HEIGHT,
		"grid should not be fully populated on first launch"
	)

func test_is_within_bounds_true_for_corners():
	assert_true(GameState.is_within_bounds(Vector2i(0, 0)))
	assert_true(GameState.is_within_bounds(Vector2i(GameState.GRID_WIDTH - 1, GameState.GRID_HEIGHT - 1)))

func test_is_within_bounds_false_outside_grid():
	assert_false(GameState.is_within_bounds(Vector2i(-1, 0)))
	assert_false(GameState.is_within_bounds(Vector2i(0, -1)))
	assert_false(GameState.is_within_bounds(Vector2i(GameState.GRID_WIDTH, 0)))
	assert_false(GameState.is_within_bounds(Vector2i(0, GameState.GRID_HEIGHT)))

func test_attempt_merge_rejects_out_of_bounds_positions():
	GameState.grid[0][0] = 1
	var result := GameState.attempt_merge(Vector2i(0, 0), Vector2i(99, 99))
	assert_false(result)

func test_attempt_generate_rejects_out_of_bounds_position():
	var result := GameState.attempt_generate(Vector2i(-1, 0))
	assert_false(result)

func test_generation_cooldown_decrements_over_time():
	GameState.attempt_generate(Vector2i(0, 0))
	assert_almost_eq(
		GameState.generation_cooldown_remaining, GameState.GENERATION_COOLDOWN_SECONDS, 0.001
	)
	GameState._process(1.0)
	assert_almost_eq(
		GameState.generation_cooldown_remaining, GameState.GENERATION_COOLDOWN_SECONDS - 1.0, 0.001
	)

func test_generation_cooldown_does_not_go_negative():
	GameState.attempt_generate(Vector2i(0, 0))
	GameState._process(GameState.GENERATION_COOLDOWN_SECONDS + 10.0)
	assert_eq(GameState.generation_cooldown_remaining, 0.0)

func test_can_generate_again_once_cooldown_elapses():
	GameState.attempt_generate(Vector2i(0, 0))
	GameState._process(GameState.GENERATION_COOLDOWN_SECONDS)
	var result := GameState.attempt_generate(Vector2i(1, 1))
	assert_true(result, "generation should be allowed again once the cooldown fully elapses")
