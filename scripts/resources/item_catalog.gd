extends RefCounted
class_name ItemCatalog

## Static lookup from tier number to its data-driven ItemDefinition resource.

const _TIER_PATHS := {
	1: "res://resources/items/item_tier_1.tres",
	2: "res://resources/items/item_tier_2.tres",
	3: "res://resources/items/item_tier_3.tres",
	4: "res://resources/items/item_tier_4.tres",
	5: "res://resources/items/item_tier_5.tres",
}

static func get_definition(tier: int) -> ItemDefinition:
	if not _TIER_PATHS.has(tier):
		return null
	return load(_TIER_PATHS[tier])
