# mergeville — Design Guidelines

## Design Principles & Vibe

Cozy and cute: pastel colors, rounded shapes, soft shadows, friendly character/iconography. The game should feel calm and low-pressure — never urgent, cluttered, or aggressive — in line with genre references like Merge Mansion, Township, and Mergest Kingdom. Since there is no monetization (no ads, no IAP — see `.memory/product-vision.md`), the UI must never use urgency/FOMO patterns (countdown timers pushing spend, "limited time" banners, guilt-based nudges) that are common in the genre's monetized competitors.

Core principles:
- **Warm over slick**: rounded corners, soft pastel fills, gentle drop shadows over sharp edges, high-saturation neons, or hard drop shadows.
- **Legible over dense**: mobile screens are small — prioritize larger touch targets and generous spacing over packing in information.
- **Calm over urgent**: no red alert-style badges/countdowns unless communicating genuinely helpful state (e.g. "resource ready to collect"), never artificial scarcity.

## Design System & Tooling

- **Storybook**: N/A — this is a native Godot game, not a web app.
- **External Design System**: None. mergeville defines its own lightweight visual identity below, implemented as a Godot `Theme` resource (`resources/theme/mergeville_theme.tres`) shared across UI scenes, plus a shared color/constants script (e.g. `scripts/ui/palette.gd`) so values aren't duplicated across scenes.

## UI Constraints

### Color Palette

Pastel palette, distinct hues per merge tier to support color differentiation (paired with shape/icon per the Accessibility section below — never color alone).

| Name | Hex | Usage |
| :--- | :--- | :--- |
| Cream Background | `#FFF8F0` | Base background for grid and menus |
| Blush Pink | `#F7C6D9` | Primary accent, buttons, tier 1 items |
| Soft Peach | `#FBD8B0` | Tier 2 items, secondary accent |
| Mint Green | `#BFE8D4` | Tier 3 items, positive/success feedback (e.g. resource ready) |
| Sky Blue | `#BEE3F0` | Tier 4 items, informational UI |
| Lavender | `#D8CCF0` | Tier 5+ items, meta-layer/building unlock highlights |
| Warm Brown (text) | `#6B4A3D` | Primary text — chosen for sufficient contrast against pastel fills |
| Soft Shadow | `#00000022` (13% black) | Drop shadows / elevation, never harsh black |

Exact hexes are a starting point for the `design` skill's mockups, not final art direction — adjust during first mockup pass while keeping the pastel/rounded principle intact.

### Typography

- **Primary Font**: A rounded, friendly sans-serif (e.g. Fredoka, Baloo 2, or Nunito) rather than a sharp/geometric grotesk — reinforces the cozy vibe. Bundled as a Godot dynamic font resource.
- **Headings**: Bold weight, larger size (e.g. 28-36pt at design resolution) for screen titles and milestone/unlock callouts.
- **Body Text**: Regular/medium weight, minimum 16pt-equivalent at target resolution to stay legible on small Android screens; generous line-height (1.4x+) for readability.

### Spacing & Layout

- **Layout system**: Portrait-orientation, mobile-first canvas (Godot project sized for a common portrait aspect ratio, e.g. 1080x1920, scaled with Godot's `canvas_items` stretch mode so it adapts across Android device sizes).
- **Spacing scale**: 8px-based increments (8/16/24/32) for margins and padding between UI elements, consistent across grid, HUD, and menus.
- **Touch targets**: Minimum 48x48dp tap/drag target for merge-grid items and buttons (Android accessibility guideline baseline), with extra spacing between adjacent grid cells so drag gestures aren't ambiguous.
- **Safe areas**: Keep primary interactive elements clear of device notches/status bars and gesture-navigation zones at the top/bottom of the screen.

## Content Strategy

- **Tone of Voice**: Warm, friendly, encouraging, low-pressure. Celebrate progress ("Nice merge!", "Your town is growing!") without manufacturing urgency or guilt. Never use countdown/loss-framed language ("Don't lose your streak!", "Offer ends soon!") since there is no monetization to justify it.
- **Terminology**: Use consistent, simple names for concepts across all UI copy and code comments/variable names — e.g. always "merge" (not "combine"/"fuse"), "town" (not "base"/"city" interchangeably — pick one), "collect" for gathering idle resources. Define the canonical term list in the `feature` skill specs as concrete features are built.
- **Grammar & Formatting**: Sentence case for headings and buttons (e.g. "Collect resources", not "Collect Resources" or "COLLECT RESOURCES"). Keep copy short — mobile game UI space is limited.

## Accessibility (a11y)

No formal WCAG target applies (native mobile game, not a web service), but the following mobile-game accessibility basics apply:

- **Color independence**: merge-tier and resource-type differentiation must never rely on color alone — pair each tier/type with a distinct icon or shape so colorblind players can distinguish items.
- **Contrast**: body text (Warm Brown `#6B4A3D`) against pastel fills/background should maintain comfortable readability; verify contrast when finalizing exact palette values in the `design` skill.
- **Touch targets**: minimum 48x48dp per the Spacing & Layout section above — sized for players with limited fine motor precision, not just average adult fingers.
- **Text scaling**: avoid hardcoding text into baked images where feasible; use scalable font resources so text sizing can be adjusted later if needed.
- **Focus states**: not applicable in the keyboard-navigation sense (touch-first mobile game); instead, ensure clear pressed/dragged visual states (see Component Behaviors) so touch feedback is unambiguous.

## Component Behaviors

- **Merge feedback**: on a successful merge, play a satisfying but brief pop/scale animation plus a soft chime — feedback should be instant (no more than a couple hundred ms) to keep the core loop feeling responsive.
- **Drag state**: item being dragged should lift slightly (scale up ~10%, add/strengthen drop shadow) to clearly indicate active drag; invalid drop targets should give a gentle "bounce back" rather than a harsh error state.
- **Idle/collectible state**: resource nodes ready to collect should use a gentle pulse or bounce (not a flashing/urgent animation) plus an icon badge — inviting, not alarming.
- **Buttons**: rounded-rect shape matching the overall aesthetic; clear pressed state (slight scale-down + shadow reduction) for tactile feedback; disabled state uses reduced opacity rather than a jarring greyscale.
- **Building unlock/placement**: unlocking a new building should feel celebratory (brief highlight/glow + encouraging copy) to reinforce the meta-layer's long-term progression goal from `.memory/product-vision.md`.
