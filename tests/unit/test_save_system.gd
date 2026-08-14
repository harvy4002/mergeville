extends GutTest

## Covers TC-02, TC-09, TC-10, TC-14, TC-15 (test-cases.md) and the
## bounds-check remediation from security.md Section 7.

func before_each():
	GameState.reset_to_empty()
	_delete_save_file()

func after_each():
	_delete_save_file()

func _delete_save_file():
	if FileAccess.file_exists(SaveSystem.SAVE_PATH):
		var dir := DirAccess.open("user://")
		dir.remove("save_data.json")

func test_save_and_load_round_trip_restores_exact_state():
	GameState.grid[0][0] = 1
	GameState.grid[2][3] = 4
	GameState.grid[5][6] = 5
	SaveSystem.save_game()

	GameState.reset_to_empty()
	var result := SaveSystem.load_game()

	assert_true(result)
	assert_eq(GameState.grid[0][0], 1)
	assert_eq(GameState.grid[2][3], 4)
	assert_eq(GameState.grid[5][6], 5)

func test_load_returns_false_when_no_save_file_exists():
	var result := SaveSystem.load_game()
	assert_false(result)

func test_load_returns_false_for_corrupted_json():
	var file := FileAccess.open(SaveSystem.SAVE_PATH, FileAccess.WRITE)
	file.store_string("{ this is not valid json ")
	file.close()
	var result := SaveSystem.load_game()
	assert_false(result)

func test_load_returns_false_for_unrecognized_version():
	var file := FileAccess.open(SaveSystem.SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify({"version": 999, "grid": []}))
	file.close()
	var result := SaveSystem.load_game()
	assert_false(result)

func test_load_returns_false_for_out_of_range_tier():
	var file := FileAccess.open(SaveSystem.SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify({"version": 1, "grid": [{"x": 0, "y": 0, "tier": 999}]}))
	file.close()
	var result := SaveSystem.load_game()
	assert_false(result)

func test_load_returns_false_for_out_of_bounds_position():
	var file := FileAccess.open(SaveSystem.SAVE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify({"version": 1, "grid": [{"x": 99, "y": 0, "tier": 1}]}))
	file.close()
	var result := SaveSystem.load_game()
	assert_false(result)

func test_round_trip_with_full_grid_produces_42_entries():
	for x in range(GameState.GRID_WIDTH):
		for y in range(GameState.GRID_HEIGHT):
			GameState.grid[x][y] = 1
	SaveSystem.save_game()

	var file := FileAccess.open(SaveSystem.SAVE_PATH, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()

	assert_eq(parsed["grid"].size(), GameState.GRID_WIDTH * GameState.GRID_HEIGHT)

func test_round_trip_with_empty_grid_produces_empty_array_and_loads_cleanly():
	SaveSystem.save_game()

	var file := FileAccess.open(SaveSystem.SAVE_PATH, FileAccess.READ)
	var parsed = JSON.parse_string(file.get_as_text())
	file.close()
	assert_eq(parsed["grid"].size(), 0)

	var result := SaveSystem.load_game()
	assert_true(result)
	assert_false(GameState.is_full())
