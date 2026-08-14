extends GutTest

## Covers the data-driven ItemDefinition/ItemCatalog layer (intent.md Code
## Data Structures) — not exercised by the merge/save tests, which only
## deal with raw tier ints.

func test_get_definition_returns_correct_tier_for_each_valid_tier():
	for tier in range(1, MergeRules.MAX_TIER + 1):
		var definition := ItemCatalog.get_definition(tier)
		assert_not_null(definition, "tier %d should have a definition" % tier)
		assert_eq(definition.tier, tier)

func test_get_definition_returns_null_for_invalid_tiers():
	assert_null(ItemCatalog.get_definition(0))
	assert_null(ItemCatalog.get_definition(MergeRules.MAX_TIER + 1))
	assert_null(ItemCatalog.get_definition(-1))

func test_tier_chain_links_to_next_tier_correctly():
	for tier in range(1, MergeRules.MAX_TIER):
		var definition := ItemCatalog.get_definition(tier)
		assert_not_null(definition.next_tier, "tier %d should link to a next tier" % tier)
		assert_eq(definition.next_tier.tier, tier + 1)

func test_max_tier_has_no_next_tier():
	var definition := ItemCatalog.get_definition(MergeRules.MAX_TIER)
	assert_null(definition.next_tier, "max tier must be a dead end, per feature.md CQ-5")

func test_each_tier_has_a_distinct_name_and_color():
	## Colorblind-safe differentiation per design-guidelines.md: every tier
	## must be tellable apart by name, not just by (possibly similar) color.
	var seen_names := {}
	var seen_colors := {}
	for tier in range(1, MergeRules.MAX_TIER + 1):
		var definition := ItemCatalog.get_definition(tier)
		assert_false(seen_names.has(definition.display_name), "tier %d display_name should be unique" % tier)
		seen_names[definition.display_name] = true
		assert_false(seen_colors.has(definition.color), "tier %d color should be unique" % tier)
		seen_colors[definition.color] = true
