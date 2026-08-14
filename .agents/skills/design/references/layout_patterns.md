# Layout Patterns for Responsive UI

Guidance for adapting layouts across breakpoints.

## 1. Mobile-First Approach
Start with the vertical stack.
- **Header**: Sticky or absolute top.
- **Content**: Full-width scrolling.
- **Navigation**: Bottom Tab Bar (best for reachability).

## 2. Tablet Transitions (768px - 1024px)
- **Navigation Rail**: Convert the bottom tab bar to a slim left sidebar (64px - 80px wide).
- **Grid Expansion**: Move from 1 column to 2-3 columns.
- **Modals**: Transition from full-screen "bottom sheets" to centered dialogs.

## 3. Desktop Layouts (> 1024px)
- **Full Sidebar**: Navigation rail expands to a 240px - 280px sidebar with labels.
- **Content Max-Width**: Center the main content area (e.g., `max-width: 1200px`) to prevent excessively long lines of text.
- **Dashboard Layout**: Side-by-side widgets or multi-pane views (e.g., Master-Detail).

## 4. CSS Techniques
- **Flexbox**: Use `flex-wrap: wrap` for cards.
- **Grid**: Use `grid-template-columns: repeat(auto-fill, minmax(250px, 1fr))` for fluid layouts.
- **Viewport Units**: Use `100dvh` for full-height containers to avoid mobile address bar issues.
- **Backdrop Blur**: Use `backdrop-filter: blur(20px)` for iOS-style translucent bars.
