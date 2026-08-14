extends GutTest

## Regression coverage for a real bug found via code review: refresh() used
## to unconditionally destroy/recreate its ItemView on every call, and
## grid.gd calls refresh() on all 42 slots on every grid_changed — meaning
## a single tap or merge anywhere on the board interrupted every other
## item's in-flight animation. refresh() must now be a no-op when a slot's
## displayed tier hasn't actually changed.

func before_each():
	GameState.reset_to_empty()

func test_refresh_does_not_recreate_item_view_when_tier_is_unchanged():
	GameState.grid[0][0] = 1
	var slot := GridSlot.new()
	slot.grid_position = Vector2i(0, 0)
	add_child_autofree(slot)  # triggers _ready(), which calls refresh() once

	var first_item_view = slot._item_view
	assert_not_null(first_item_view)

	slot.refresh()  # tier at (0,0) hasn't changed
	assert_eq(
		slot._item_view, first_item_view, "unchanged tier should not rebuild the item view"
	)

func test_refresh_rebuilds_item_view_when_tier_changes():
	GameState.grid[0][0] = 1
	var slot := GridSlot.new()
	slot.grid_position = Vector2i(0, 0)
	add_child_autofree(slot)

	var first_item_view = slot._item_view
	GameState.grid[0][0] = 2
	slot.refresh()

	assert_ne(slot._item_view, first_item_view, "changed tier should rebuild the item view")
	assert_true(is_instance_valid(slot._item_view))
	assert_eq(slot._item_view.tier, 2)

func test_refresh_clears_item_view_when_slot_becomes_empty():
	GameState.grid[0][0] = 1
	var slot := GridSlot.new()
	slot.grid_position = Vector2i(0, 0)
	add_child_autofree(slot)

	GameState.grid[0][0] = null
	slot.refresh()

	assert_null(slot._item_view)
