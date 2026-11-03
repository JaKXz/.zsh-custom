---
name: react-patterns
description: Plan, write, modify, debug, refactor, or review React, JSX, and TSX using React Learn as the primary authority for React behavior, React Testing Library as a primary authority for React tests, and Josh W. Comeau's React articles as secondary practical guidance. Use for React components, hooks, state, effects, forms, rendering, testing, performance, SSR, hydration, Server Components, or React architecture, including delegated React work.
---

# React Patterns

Produce React plans and code that fit the current project while following the source order and review gates below.

## Establish the local constraints

Before proposing React-specific changes:

1. Read the applicable repository instructions, including `AGENTS.md`, `CLAUDE.md`, root `README.md`, and `CONTRIBUTING.md` files when present.
2. Inspect the existing component patterns, package versions, framework, compiler configuration, lint rules, test setup, and styling approach relevant to the task.
3. Preserve established project conventions unless they conflict with React correctness, the user's request, or higher-priority project instructions. Do not impose a new state library, folder structure, form library, styling system, or rendering strategy without a task-specific reason.

## Use sources in the required order

Use the baseline in this skill for ordinary work. For React test design and Testing Library usage, [React Testing Library](https://testing-library.com/docs/react-testing-library/intro/) is a primary authority alongside React Learn. Consult its relevant official documentation directly; the React Learn/Josh Comeau research sequence below does not gate Testing Library sources. React documentation remains authoritative for React semantics.

For other React topics, when external research, current API verification, or source-backed justification is needed, consult sources in this order:

1. Open [React Learn](https://react.dev/learn) and read the relevant official chapter or article.
2. Then open [Josh W. Comeau's React index](https://www.joshwcomeau.com/react/) and read the relevant article when one exists.
3. Only after actually consulting both sources in that order may you use other framework documentation, library documentation, web standards, or other sources, except the primary Testing Library documentation for React tests described above.

An opened page counts; a search-result snippet does not. For topic routing and source links, read [references/source-guide.md](references/source-guide.md). If the sources conflict, current React documentation wins for React behavior. Treat Josh Comeau's personal preferences as practical guidance, not universal rules. Account for the project's installed versions and explain any version-driven departure.

If network access is unavailable, apply the baseline below and state that current source verification was not possible when it materially affects the answer. Do not claim to have consulted a source you could not open.

## Carry the skill into delegated work

When delegating any React-scoped planning, implementation, debugging, refactoring, or review, explicitly tell every subagent to use `$react-patterns` and follow its source order. Do not assume a subagent inherited or loaded this skill.

Review every returned React plan, snippet, and code change against this skill before incorporating it. The parent agent owns the final compliance check.

## Design from the component tree and data flow

For non-trivial work, identify before implementation:

- The component boundaries and each component's responsibility.
- The minimal source of truth, its owner, and how data flows down and events flow up.
- The user-visible states and valid transitions, including loading, empty, error, success, and disabled states when relevant.
- Every external system that genuinely needs synchronization and the lifetime of that synchronization.
- The server/client boundary and hydration constraints when rendering on both sides.

Plans must make these decisions concrete enough that their React correctness can be reviewed. Code examples inside a plan must satisfy the same rules as production code.

## Keep rendering pure

- Treat components and Hooks as pure calculations from props, state, and context to UI.
- Do not mutate pre-existing objects, arrays, props, state, context values, module state, or the DOM during render.
- Do not perform subscriptions, network calls, analytics, timers, storage writes, or other side effects during render.
- Avoid render-time reads whose value changes independently of React, such as the current time, random values, or mutable external state. Capture or subscribe to them through the appropriate state, event, or external-store mechanism.
- Call Hooks only at the top level of React components and custom Hooks, never inside conditions, loops, callbacks, or ordinary functions.
- When using `&&` for conditional JSX, make the left side a boolean expression so values such as `0` cannot leak into the UI.
- Prefer semantic JSX and preserve accessibility relationships, names, focus behavior, and reduced-motion preferences relevant to the change.

## Model state deliberately

- Store the minimum state needed. Calculate values from current props and state during render instead of duplicating or synchronizing derived data.
- Avoid contradictory, redundant, deeply duplicated, or impossible state. Group values that always change together; keep unrelated values separate.
- Treat state as an immutable snapshot. Replace objects and arrays rather than mutating them.
- Use functional state updates when the next value depends on the previous value or when updates may be queued.
- Never expect a state variable to change inside the currently running event handler after calling its setter. Calculate and use an explicit next value when needed immediately.
- Put state in the closest common owner of every component that must coordinate it. Pass data down and event handlers up.
- Prefer ordinary props and composition for local relationships. Use context for genuinely cross-cutting data needed through a distant subtree, not merely to avoid a few explicit props.
- Use a reducer when many handlers perform related transitions or when explicit actions make a complex state machine easier to understand.
- Use a stable `key` to express identity and intentionally reset state. Do not nest component definitions inside another component.

## Keep identities stable where identity matters

- Use stable keys derived from the data. Create missing IDs when data is created or received, not while rendering.
- Do not use a fresh random value as a key. Avoid array indexes for lists that can be inserted into, removed from, reordered, filtered, or edited.
- Remember that keys are scoped to siblings and are not passed as props.
- Do not add `useMemo`, `useCallback`, or `memo` merely to make every reference stable. Stabilize identities only where a consumer relies on them or measurement demonstrates a useful optimization.

## Separate events from Effects

- Put logic caused by a specific user interaction in that event handler.
- Use an Effect only to synchronize React with an external system such as a network connection, timer, browser API, non-React widget, or subscription.
- Do not use Effects to transform render data, mirror props into state, chain state updates, notify parents of local state, or handle an interaction that already has an event boundary.
- Include every reactive dependency. Change the surrounding code to remove an unnecessary dependency; never lie to the linter or suppress the dependency rule to force timing.
- Make setup and cleanup symmetrical. Effects must remain correct across setup-cleanup-setup cycles and when dependencies change.
- Do not make the Effect callback itself `async`. Define and call an async function inside it, and handle cancellation, stale responses, or ignored results when work can outlive that Effect instance.
- Split unrelated synchronization processes into separate Effects.

## Use refs and custom Hooks for their intended roles

- Use refs for DOM access or values that must survive renders without affecting rendered output, such as timer IDs or imperative handles.
- Use state, not refs, for information displayed by the UI. Avoid reading or writing `ref.current` during render except for safe one-time initialization patterns supported by React.
- Use custom Hooks to reuse stateful logic and synchronization behavior. Each call owns independent state; a custom Hook does not share state unless it deliberately uses a shared external source or context.
- Keep a custom Hook's API focused on the caller's job rather than leaking its internal Effects or bookkeeping.

## Handle forms consistently

- Choose controlled or uncontrolled ownership deliberately and do not switch an input between them during its lifetime.
- Initialize controlled text values to strings and boolean controls to booleans so their values are never accidentally `undefined` or `null`.
- Pair controlled `value` with `onChange`; use `checked` for checkboxes and radio buttons. Convert DOM strings to the intended application type explicitly.
- Use stable accessible IDs and labels. Use `useId` when a reusable component needs instance-safe IDs; do not use it for list keys.

## Optimize only a demonstrated problem

- Reason from the render tree: initial rendering, local state updates, ancestor renders, and consumed context can cause a component to render. A changed prop is an input supplied during an ancestor's render, not an independent scheduler.
- First improve state placement, component boundaries, and composition. Profile before adding manual memoization.
- Use `memo`, `useMemo`, and `useCallback` for measured expensive work or a real reference-stability boundary, while considering whether the project's React Compiler already handles memoization.
- Measure representative production behavior and lower-end devices when performance matters; development timings and render counts alone are not the user experience.
- Use `useDeferredValue` or transitions only when a proven slow, non-urgent region can lag behind urgent input. Preserve the memoization boundary needed for deferral to skip slow work and communicate stale UI only when useful.

## Respect server rendering boundaries

- Keep the initial client render compatible with the server-rendered HTML. Do not branch during render on browser-only state in a way that creates a hydration mismatch.
- Use the installed framework's supported data-loading and browser-only patterns after consulting the two required React sources.
- In a Server Components environment, keep components on the server unless they need client-only interactivity or APIs, but do not optimize for the fewest possible Client Components.
- Treat `'use client'` as a module dependency boundary. Keep client boundaries intentionally placed and pass Server Component output through composition where the framework permits it.
- Never use client-only Hooks in a Server Component. Keep secrets and server-only modules out of the client dependency graph.

## Write React tests through the user interface

- Exercise rendered UI and observable outcomes. Prefer accessible roles and names or labels; use test IDs only when semantic queries are impractical. Avoid assertions on component internals when the UI exposes the behavior.
- Create a `userEvent.setup()` session before rendering and await its interactions. Use `findBy` for elements that appear asynchronously and `queryBy` for absence; keep `waitFor` callbacks free of interactions and other side effects.
- Preserve provider identity when rerendering to deliver updated inputs. Keep scenario-specific responses explicit, mock external boundaries deliberately, and release deferred work and timers during cleanup, including on failure. Follow the repository's test setup and the user's test-writing rules.

See [the testing sources](references/source-guide.md#primary-for-react-tests-react-testing-library) for query, interaction, async, rerender, and timer guidance.

## Verify before handing off

Review every React plan, snippet, and changed file for:

- Pure render and valid Hook placement.
- Minimal, immutable state with correct ownership and stable identity.
- Event logic in handlers and Effects limited to external synchronization.
- Complete Effect dependencies, cleanup, and async race handling.
- Intentional form ownership, semantic markup, and accessibility.
- Hydration and server/client correctness where applicable.
- Performance changes supported by structure or evidence rather than superstition.
- React tests that exercise observable behavior with accessible queries, awaited interactions, and deterministic cleanup.

Run the repository's documented formatting, lint, typecheck, and relevant tests when code changed. Report any deliberate exception with the project constraint or source principle that required it.
