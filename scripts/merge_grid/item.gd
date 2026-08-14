extends Control
class_name ItemView

## Draggable visual representation of a single grid item. Built entirely in
## code (no child scene) to avoid hand-authoring .tscn node trees for a
## purely data-driven visual.

var tier: int = 1:
	set(value):
		tier = value
		_refresh_visual()

var grid_position: Vector2i

var _background: Panel
var _label: Label

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	set_anchors_preset(Control.PRESET_FULL_RECT)

	_background = Panel.new()
	_background.set_anchors_preset(Control.PRESET_FULL_RECT)
	_background.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_background)

	_label = Label.new()
	_label.set_anchors_preset(Control.PRESET_FULL_RECT)
	_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_label.vertical_alignment = VERTICAL_ALIGNMENT_CENTER
	_label.mouse_filter = Control.MOUSE_FILTER_IGNORE
	add_child(_label)

	_refresh_visual()

## Colorblind-safe differentiation per design-guidelines.md: pastel fill
## AND a distinct name label, never color alone.
func _refresh_visual() -> void:
	if _background == null or _label == null:
		return
	var definition := ItemCatalog.get_definition(tier)
	if definition == null:
		return
	var style := StyleBoxFlat.new()
	style.bg_color = definition.color
	style.set_corner_radius_all(20)
	_background.add_theme_stylebox_override("panel", style)
	_label.text = definition.display_name

func _get_drag_data(_at_position: Vector2) -> Variant:
	var preview := Panel.new()
	preview.custom_minimum_size = size
	var style := StyleBoxFlat.new()
	var definition := ItemCatalog.get_definition(tier)
	if definition != null:
		style.bg_color = definition.color
	style.set_corner_radius_all(20)
	preview.add_theme_stylebox_override("panel", style)
	preview.modulate.a = 0.85
	set_drag_preview(preview)
	return {"source_position": grid_position, "tier": tier}

## Merge feedback per design-guidelines.md Component Behaviors: a brief
## pop/scale animation. (Audio cue intentionally omitted — no audio asset
## exists yet; see AudioStreamPlayer note in grid.gd.)
func play_merge_pop() -> void:
	scale = Vector2(0.6, 0.6)
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2.ONE, 0.15) \
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
