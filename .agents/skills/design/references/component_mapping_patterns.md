# Component Mapping Patterns

Best practices for translating static designs into maintainable component architectures.

## 1. The Container/Presentational Pattern
- **Containers (Smart)**: Handle data fetching, state management, and side effects.
- **Presentational (Dumb)**: Purely visual, receive data via props, and emit actions via callbacks.

## 2. Atomization (Atomic Design)
- **Atoms**: Basic building blocks (Buttons, Inputs, Labels). Reuse existing UI library atoms.
- **Molecules**: Groups of atoms functioning together (Search bar, Form field).
- **Organisms**: Complex UI sections composed of molecules (Header, Sidebar, Grid).

## 3. Maximizing Reuse
- **Prop Expansion**: Before creating a new component, check if an existing one can be extended with a new optional prop.
- **Composition**: Prefer composing small components over creating monolithic "God components" with many flags.
- **Styling Consistency**: Ensure new components use the same CSS variables or Tailwind theme as existing ones.

## 4. State Placement
- **Lifting State Up**: If multiple components need the same data, move it to their closest common ancestor.
- **Context/Stores**: Use for truly global data (Auth, Theme, Global Settings). Avoid using for feature-specific state unless nesting is extreme.

## 5. Responsive Implementation
- Ensure components handle props for different breakpoints (e.g., `<Container width={{ mobile: '100%', desktop: '50%' }}>`) or use CSS media queries that align with the project's defined breakpoints.
