# React source guide

Use this guide to route research. For React behavior, consult React Learn first, Josh W. Comeau second, and other sources afterward. For React testing, consult the primary Testing Library sources below directly; they do not require the Josh Comeau research step.

## Primary: React Learn

Start at [React Learn](https://react.dev/learn), then use the relevant chapter:

- [Describing the UI](https://react.dev/learn/describing-the-ui): components, JSX, props, conditional rendering, lists and keys, pure components, and render trees.
- [Adding Interactivity](https://react.dev/learn/adding-interactivity): event handlers, state as a snapshot, queued updates, and immutable object or array updates.
- [Managing State](https://react.dev/learn/managing-state): declarative UI states, state shape, lifting state, identity and reset behavior, reducers, and context.
- [Escape Hatches](https://react.dev/learn/escape-hatches): refs, DOM access, Effects, Effect lifecycle and dependencies, and custom Hooks.

High-value focused pages:

- [Thinking in React](https://react.dev/learn/thinking-in-react)
- [Keeping Components Pure](https://react.dev/learn/keeping-components-pure)
- [Choosing the State Structure](https://react.dev/learn/choosing-the-state-structure)
- [Sharing State Between Components](https://react.dev/learn/sharing-state-between-components)
- [Preserving and Resetting State](https://react.dev/learn/preserving-and-resetting-state)
- [Extracting State Logic into a Reducer](https://react.dev/learn/extracting-state-logic-into-a-reducer)
- [Passing Data Deeply with Context](https://react.dev/learn/passing-data-deeply-with-context)
- [Synchronizing with Effects](https://react.dev/learn/synchronizing-with-effects)
- [You Might Not Need an Effect](https://react.dev/learn/you-might-not-need-an-effect)
- [Lifecycle of Reactive Effects](https://react.dev/learn/lifecycle-of-reactive-effects)
- [Removing Effect Dependencies](https://react.dev/learn/removing-effect-dependencies)
- [Reusing Logic with Custom Hooks](https://react.dev/learn/reusing-logic-with-custom-hooks)

Use the current React documentation as the authority for React semantics and supported APIs. If the task concerns an API outside Learn, inspect Learn first, then Josh's React material, then the official React API reference.

## Primary for React tests: React Testing Library

Start with [React Testing Library's introduction](https://testing-library.com/docs/react-testing-library/intro/). Favor tests of rendered UI and user-observable behavior that remain useful when implementation details change. React Learn remains authoritative for React behavior; Testing Library is primary for testing practices and its APIs.

Read the relevant official guidance when needed:

- [Queries and query priority](https://testing-library.com/docs/queries/about/): accessible queries, asynchronous appearance, and absence assertions.
- [user-event introduction](https://testing-library.com/docs/user-event/intro/): per-test sessions and realistic, awaited interactions.
- [Async methods](https://testing-library.com/docs/dom-testing-library/api-async/): waiting for observable changes without arbitrary sleeps.
- [React Testing Library API](https://testing-library.com/docs/react-testing-library/api/): render, rerender, provider wrappers, and cleanup.
- [Using fake timers](https://testing-library.com/docs/using-fake-timers/): timer cleanup and interaction-library compatibility.

Apply these practices within the project's existing runner, provider stack, and the user's test-writing rules. Do not introduce a different test framework merely to match a documentation example.

## Secondary: Josh W. Comeau's React articles

After React Learn, open [the React article index](https://www.joshwcomeau.com/react/) and select the relevant article. Common routes include:

- [Common Beginner Mistakes with React](https://www.joshwcomeau.com/react/common-beginner-mistakes/): conditional zero rendering, immutable state, stable keys, state snapshots, controlled inputs, JSX details, and async Effect callbacks.
- [Data Binding in React](https://www.joshwcomeau.com/react/data-binding/): controlled and uncontrolled inputs, form control differences, IDs, labels, and value conversion.
- [Why React Re-Renders](https://www.joshwcomeau.com/react/why-react-re-renders/): render ownership, descendant re-renders, purity, context, profiling, and avoiding render-count superstition.
- [Understanding useMemo and useCallback](https://www.joshwcomeau.com/react/usememo-and-usecallback/): expensive calculations, reference equality, memo boundaries, and evidence-driven optimization.
- [Snappy UI Optimization with useDeferredValue](https://www.joshwcomeau.com/react/use-deferred-value/): urgent versus non-urgent UI, required memo boundaries, stale indicators, and lower-end device testing.
- [Delightful React File/Directory Structure](https://www.joshwcomeau.com/react/file-structure/): colocation, extraction thresholds, naming consistency, aliases, and explicit organizational tradeoffs. Treat this as one personal approach; prefer the repository's established structure.
- [Making Sense of React Server Components](https://www.joshwcomeau.com/react/server-components/): server/client mental models, client module boundaries, and composition across boundaries. Verify current framework support afterward.
- [The Perils of Hydration](https://www.joshwcomeau.com/react/the-perils-of-rehydration/): matching initial server/client output and deferring browser-only information safely.
- [Accessible Animations in React](https://www.joshwcomeau.com/react/prefers-reduced-motion/): user motion preferences and reusable hooks.
- [Persisting React State in localStorage](https://www.joshwcomeau.com/react/persisting-react-state-in-localstorage/): lazy initialization, browser storage, and reusable persistence hooks. Reconcile older examples with current SSR and Effect guidance.

Use Josh Comeau's articles to sharpen mental models and practical tradeoffs. Do not copy a dated example without checking it against the current React Learn guidance, the installed React version, and the current framework behavior.

## Tertiary sources

Except for the primary Testing Library documentation for React tests above, only after opening the relevant React Learn material and Josh React index/article may you consult:

- The official React API reference.
- The project's framework and library documentation.
- Web-platform standards and MDN.
- Other articles, discussions, or examples.

ALWAYS explicitly reference every tertiary source that influences the work so the user or reviewer can verify it. Never rely on tertiary guidance silently.

- In a plan, review, or final response, name the source, link directly to the relevant page, and connect it to the decision it supports.
- When a tertiary source explains why non-obvious complexity or a workaround must remain in the code, a concise adjacent comment may carry the reference instead. The comment must explain **why the complexity is necessary**, include the source name or direct URL, and remain useful to a future maintainer.
- Do not write comments that merely narrate what the code does. If the source does not justify durable complexity, reference it in the agent output instead of adding noise to the code.
- When multiple tertiary sources are used, make it clear which decision or constraint each source supports.

Prefer primary documentation for API behavior. Clearly identify an inference or project-specific tradeoff instead of presenting it as a React rule.
