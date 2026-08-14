extends Control
class_name GridSlot

## A single grid cell: renders its ItemView (if occupied), accepts drops
## for merging, and handles tap-to-generate when empty.

const SLOT_SIZE := Vector2(140, 140)

var grid_position: Vector2i
var _background: Panel
var _item_view: ItemView = null

func _ready() -> void:
	custom_minimum_size = SLOT_SIZE
	mouse_filter = Control.MOUSE_FILTER_STOP

	_background = Panel.new()
	_background.set_anchors_preset(Control.PRESET_FULL_RECT)
	_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	var style := StyleBoxFlat.new()
	style.bg_color = Color("#FFF8F0")
	style.set_corner_radius_all(16)
	_background.add_theme_stylebox_override("panel", style)
	add_child(_background)

	refresh()

func refresh() -> void:
	if _item_view != null and is_instance_valid(_item_view):
		_item_view.queue_free()
		_item_view = null
	var tier = GameState.get_item(grid_position)
	if tier != null:
		_item_view = ItemView.new()
		_item_view.tier = tier
		_item_view.grid_position = grid_position
		add_child(_item_view)
		_item_view.set_anchors_preset(Control.PRESET_FULL_RECT)

func play_merge_feedback() -> void:
	if _item_view != null and is_instance_valid(_item_view):
		_item_view.play_merge_pop()

## Tap-to-generate placeholder (feature.md CQ-3) — only acts on empty slots.
func _gui_input(event: InputEvent) -> void:
	var tapped := false
	if event is InputEventScreenTouch and event.pressed:
		tapped = true
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		tapped = true
	if tapped and GameState.is_empty(grid_position):
		GameState.attempt_generate(grid_position)

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	if typeof(data) != TYPE_DICTIONARY or not data.has("source_position"):
		return false
	var from: Vector2i = data["source_position"]
	return from != grid_position

## Merges are attempted, and rejected silently, entirely through
## GameState.attempt_merge — since the dragged ItemView is never actually
## reparented (only a preview follows the cursor), an invalid drop leaves
## it exactly where it started, satisfying the "return to origin" behavior
## in merge-interaction-spec.md without extra bookkeeping here.
func _drop_data(_at_position: Vector2, data: Variant) -> void:
	var from: Vector2i = data["source_position"]
	GameState.attempt_merge(from, grid_position)
