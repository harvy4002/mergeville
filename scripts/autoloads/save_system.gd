extends Node

## SaveSystem — serializes/deserializes GameState.grid to a local JSON file.
## ADR-0002. Autoload singleton, per .memory/architecture.md.

const SAVE_PATH := "user://save_data.json"
const SAVE_VERSION := 1

func _ready() -> void:
	GameState.grid_changed.connect(_on_grid_changed)

func _notification(what: int) -> void:
	if what == NOTIFICATION_WM_CLOSE_REQUEST or what == NOTIFICATION_APPLICATION_PAUSED:
		save_game()

func _on_grid_changed() -> void:
	save_game()

func save_game() -> void:
	var data := {
		"version": SAVE_VERSION,
		"grid": GameState.serialize_to_cells(),
	}
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		return
	file.store_string(JSON.stringify(data))
	file.close()

## Returns true and populates GameState.grid on success. Returns false on a
## missing file, unparseable JSON, unrecognized version, or any
## out-of-range cell — in every case leaving grid untouched so the caller
## can fall back to first-launch population (progress-persistence-spec.md).
func load_game() -> bool:
	if not FileAccess.file_exists(SAVE_PATH):
		return false
	var file := FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		return false
	var text := file.get_as_text()
	file.close()

	var json := JSON.new()
	if json.parse(text) != OK:
		return false
	var parsed = json.get_data()
	if typeof(parsed) != TYPE_DICTIONARY:
		return false
	if not parsed.has("version") or int(parsed["version"]) != SAVE_VERSION:
		return false
	if not parsed.has("grid") or typeof(parsed["grid"]) != TYPE_ARRAY:
		return false

	var validated_cells = _validate_cells(parsed["grid"])
	if validated_cells == null:
		return false

	GameState.load_from_cells(validated_cells)
	return true

## Returns a cleaned Array of {x, y, tier} Dictionaries, or null if any
## entry is malformed or out of bounds (security.md remediation task).
func _validate_cells(cells: Array):
	var result: Array = []
	for cell in cells:
		if typeof(cell) != TYPE_DICTIONARY:
			return null
		if not (cell.has("x") and cell.has("y") and cell.has("tier")):
			return null

		var x := int(cell["x"])
		var y := int(cell["y"])
		var tier := int(cell["tier"])

		if x < 0 or x >= GameState.GRID_WIDTH:
			return null
		if y < 0 or y >= GameState.GRID_HEIGHT:
			return null
		if tier < 1 or tier > MergeRules.MAX_TIER:
			return null

		result.append({"x": x, "y": y, "tier": tier})
	return result
