extends GutTest

## Covers GameState's signal contracts (intent.md Signal Contracts) — the
## integration surface future features (idle economy, town meta) will hook
## into. Not exercised by test_game_state.gd, which only checks grid state.

func before_each():
	GameState.reset_to_empty()
	GameState.generation_cooldown_remaining = 0.0
	watch_signals(GameState)

func test_attempt_merge_emits_item_merged_with_resulting_tier_and_position():
	GameState.grid[0][0] = 2
	GameState.grid[0][1] = 2
	GameState.attempt_merge(Vector2i(0, 0), Vector2i(0, 1))
	assert_signal_emitted_with_parameters(GameState, "item_merged", [3, Vector2i(0, 1)])

func test_attempt_merge_emits_grid_changed():
	GameState.grid[0][0] = 1
	GameState.grid[0][1] = 1
	GameState.attempt_merge(Vector2i(0, 0), Vector2i(0, 1))
	assert_signal_emitted(GameState, "grid_changed")

func test_failed_merge_emits_neither_signal():
	GameState.grid[0][0] = 1
	GameState.grid[0][1] = 2
	GameState.attempt_merge(Vector2i(0, 0), Vector2i(0, 1))
	assert_signal_not_emitted(GameState, "item_merged")
	assert_signal_not_emitted(GameState, "grid_changed")

func test_attempt_generate_emits_item_spawned_with_position_and_tier_one():
	GameState.attempt_generate(Vector2i(3, 3))
	assert_signal_emitted_with_parameters(GameState, "item_spawned", [Vector2i(3, 3), 1])

func test_attempt_generate_emits_grid_changed():
	GameState.attempt_generate(Vector2i(3, 3))
	assert_signal_emitted(GameState, "grid_changed")

func test_blocked_generate_emits_no_additional_signals():
	GameState.attempt_generate(Vector2i(3, 3))
	GameState.attempt_generate(Vector2i(4, 4))  # blocked by cooldown
	assert_signal_emit_count(
		GameState, "item_spawned", 1, "blocked generation must not emit an extra item_spawned"
	)
	assert_signal_emit_count(
		GameState, "grid_changed", 1, "blocked generation must not emit an extra grid_changed"
	)

func test_populate_starting_items_emits_grid_changed():
	GameState.populate_starting_items()
	assert_signal_emitted(GameState, "grid_changed")
