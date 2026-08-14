# Design Plan: [Feature/Screen Name]

## 1. Overview
[Brief description of the screen's purpose and key user interactions.]

## 2. Architectural & Design Alignment
- **Framework**: [List how this plan respects .memory/architecture.md, .memory/design-guidelines.md]
- **Styling**: [List how this plan respects .memory/architecture.md, .memory/design-guidelines.md]
- **Constraints**: [List how this plan respects .memory/architecture.md, .memory/design-guidelines.md]

## 3. Layout Structure & Breakpoint Behaviors
- **Mobile (< 768px)**: [e.g., Single column, bottom tab bar]
- **Tablet (768px - 1024px)**: [e.g., Sidebar navigation rail, fluid grid]
- **Desktop (> 1024px)**: [e.g., Full sidebar, centered content area with max-width]
[Describe specific shifts in layout or component visibility at standard breakpoints.]

## 4. Component Hierarchy & Reuse
| Component | Type | Source | Purpose | Props/State |
| :--- | :--- | :--- | :--- | :--- |
| [Name] | [Screen/Molecule] | [New / Existing Path] | [Description] | [Key Props] |

### Visual Tree
```text
[PageContainer]
 ├── [Sidebar] (Existing)
 └── [MainContent] (New)
      ├── [Header] (Existing)
      └── [TaskGrid] (New)
           └── [TaskCard] (Existing)
```

## 5. Styling Constants
- **Primary Colors**: [e.g., #007AFF (iOS Blue)]
- **Typography**: [e.g., SF Pro, Inter]
- **Spacing Unit**: [e.g., 4px / 8px grid]
- **Elevations**: [e.g., Shadow 0 4px 12px rgba(0,0,0,0.1)]

## 6. Data & State Management
- **Local State**: [State managed within components]
- **Global State**: [Store/Context integration]
- **API/Data Fetching**: [Hooks or services used]

## 7. Proposed File Changes
### New Files
- `src/components/NewComponent.tsx`
- `src/features/feature-name/Screen.tsx`

### Modified Files
- `src/App.tsx` (Routing)
- `src/components/ExistingComponent.tsx` (Adding props)

## 8. Implementation Phases
### Phase 1: Scaffolding & Shared Components
1. [Step 1]
2. [Step 2]

### Phase 2: Feature Screen & Logic
1. [Step 1]
2. [Step 2]

### Phase 3: Integration & Testing
1. [Step 1]
2. [Step 2]

## 9. Implementation Notes
[Any specific constraints or logic (e.g., 'Use CSS backdrop-filter for blur') that the implementing LLM must follow.]
