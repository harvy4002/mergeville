extends Control
class_name MergeGrid

## Root controller for the main (and only) play screen: builds the grid
## from GameState, loads/saves progress, and relays merge feedback.

const GRID_MARGIN := Vector2(24, 24)
const SLOT_SEPARATION := 8

var _slots: Dictionary = {}
var _slot_container: GridContainer

func _ready() -> void:
	_build_background()
	_build_slot_container()
	_build_slots()

	if not SaveSystem.load_game():
		GameState.populate_starting_items()

	GameState.grid_changed.connect(_on_grid_changed)
	GameState.item_merged.connect(_on_item_merged)

	_refresh_all_slots()

func _build_background() -> void:
	var background := ColorRect.new()
	background.color = Color("#FFF8F0")
	background.set_anchors_preset(Control.PRESET_FULL_RECT)
	background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(background)
	move_child(background, 0)

func _build_slot_container() -> void:
	_slot_container = GridContainer.new()
	_slot_container.columns = GameState.GRID_WIDTH
	_slot_container.add_theme_constant_override("h_separation", SLOT_SEPARATION)
	_slot_container.add_theme_constant_override("v_separation", SLOT_SEPARATION)
	_slot_container.position = GRID_MARGIN
	add_child(_slot_container)

func _build_slots() -> void:
	for y in range(GameState.GRID_HEIGHT):
		for x in range(GameState.GRID_WIDTH):
			var slot := GridSlot.new()
			slot.grid_position = Vector2i(x, y)
			_slot_container.add_child(slot)
			_slots[Vector2i(x, y)] = slot

func _refresh_all_slots() -> void:
	for pos in _slots:
		_slots[pos].refresh()

func _on_grid_changed() -> void:
	_refresh_all_slots()

func _on_item_merged(_tier: int, position: Vector2i) -> void:
	if _slots.has(position):
		_slots[position].play_merge_feedback()
