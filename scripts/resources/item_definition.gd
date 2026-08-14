extends Resource
class_name ItemDefinition

## Data-driven item tier definition (.memory/architecture.md Key Patterns).
## One .tres instance per tier lives under resources/items/.

@export var tier: int = 1
@export var display_name: String = ""
@export var color: Color = Color.WHITE
## Null for the maximum tier (tier 5) — see feature.md CQ-1/CQ-5.
@export var next_tier: ItemDefinition = null
