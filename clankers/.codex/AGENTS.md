# Global rules

## Tracer-bullet development

For non-trivial planning or implementation work, attempt a tracer bullet before
broadening the solution.

- Start with the cheapest safe spike or read-only exploration that tests the
  riskiest assumption. Keep exploratory artifacts disposable; retain code only
  when it meets production standards.
- Incrementally evolve the spike into the smallest production-quality
  end-to-end slice that exercises the real path and can be validated.
- For every change off the critical path—anything the requested outcome does
  not strictly need, such as a refactor, cleanup, abstraction, or speculative
  addition—ask "Why is this change on the non-critical path necessary?" If
  there is no satisfactory answer, don't make the change; pause and discuss it
  with the user. This applies in Plan mode, during implementation, and even
  when a tracer bullet is not meaningful.
- Be adversarial: probe unhappy paths, boundaries, invalid states, integration
  seams, and assumptions—not only the happy path.
- In Plan mode, describe the desired behavior as concrete TODO tests or
  equivalent acceptance scenarios, including adversarial cases, and use them to
  agree on scope with the user before finalizing the plan. Do not reopen
  acceptance criteria the user already approved.
- During implementation, use the agreed or explicitly requested behavior to
  guide and validate the slice without adding another approval pause unless the
  scope is materially ambiguous or must change, or a non-critical-path change
  lacks a satisfactory answer.
- If a tracer bullet is not meaningful—for example, for purely editorial,
  mechanical, or single-step work—say so briefly and use the smallest useful
  validation instead.
- This rule applies equally to main agents and sub-agents. Delegated tasks must
  preserve these expectations.

### Tracer-bullet lesson from poll-jobs-and-fast-fail PRs 77 and 78

In `poll-jobs-and-fast-fail`, PR 77 grew beyond the reported external-check failure and added behavior that PR 78's smaller fix did not need. Follow the tracer-bullet rule in future work: test the riskiest assumption cheaply, build the smallest production-quality slice through the real path, and ask why **each** non-critical-path change is necessary for the requested outcome. If there is no satisfactory answer, leave it out and pause to discuss it. Keep further improvements as separate, stackable changes.

## Project documentation

Treat `README.md` and `CONTRIBUTING.md` as project instructions, on par with
`AGENTS.md` and `CLAUDE.md` — not as optional background reading.

**When to read them**

- On entering a repo or working directory for the first time in a session, read
  the repo-root `README.md` and `CONTRIBUTING.md`. Also check `docs/` and
  `.github/` for `CONTRIBUTING.md`.
- Before editing files in a subdirectory that has its own `README.md`, read that one.
- Match case-insensitively: `readme.md`, `Readme.md`, `README`, `Contributing.md`.

**How to apply them**

- Follow the setup, build, test, lint, commit-message, branch, and PR conventions
  they document instead of defaulting to generic ones.
- Prefer the exact commands they document over inventing equivalents.

**Bounds** (keep this cheap)

- Read each file once per session; don't re-read.
- Skip vendored/generated trees: `node_modules/`, `vendor/`, `.git/`, `target/`,
  `dist/`, `build/`.
- Root-level docs are enough for a large repo — don't sweep every subdirectory.

**Precedence**

- If `README.md`/`CONTRIBUTING.md` contradicts `CLAUDE.md` or `AGENTS.md`, follow
  `CLAUDE.md`/`AGENTS.md` (READMEs are written for humans and go stale) and tell
  the user about the conflict in one line.

## CLI command verification

When recommending commands for a CLI installed in the user's environment:

- Verify the exact local CLI version and validate the existence and syntax of
  every material subcommand and flag using read-only help output such as
  `tool --version`, `tool --help`, and `tool subcommand --help`.
- Do not verify syntax by executing the intended operational command. If the
  CLI documents a dry-run or no-op option, use it to validate the command
  safely; otherwise, stop after checking the CLI's help documentation.
- Prefer the locally installed CLI's output over memory, shell history, or
  documentation for another version.
- If local verification is impossible, explicitly say the command is
  unverified and consult version-specific primary documentation before
  presenting it.

## Data processing and one-off scripts

- Always use the `gh` CLI for interactions with github.com, including GitHub API
  requests through `gh api`. Pipe JSON results to `jq`. Never use `curl`, `wget`,
  or equivalent alternatives.
- For JSON or JSON Lines, use `jq` when it can reasonably express the parsing,
  filtering, or transformation. Prefer readable `jq` filters over one-off
  scripts in Python or other general-purpose languages.
- For other formats, an unavailable `jq`, or operations it cannot reasonably
  handle, try a suitable purpose-built CLI or simple shell commands first. Use
  one-off Python only when those options cannot reasonably do the job; briefly
  explain why.
- This applies to main agents and subagents. Pass the rule along when delegating
  to a subagent that may not receive global instructions.
- This preference does not restrict normal Python project code or tests.

## Test writing

When writing or modifying tests, including delegated work:

- Keep test bodies linear: no `if`, `switch`, ternaries, or conditional
  short-circuit branches. Use `describe.each` or `describe.table` or `it.each` or `it.table` with explicit inputs and expected outputs
  when setup is shared; use separate tests when setup differs. Do not recreate
  production decisions in assertions or expectation-building helpers.
- Keep varying responses, branch-defining conditions, and other scenario-specific
  fixtures and spies in each test's Arrange section.
- Share stable setup in the narrowest relevant describe block or equivalent test
  group, including lifecycle work and unchanged prerequisites or boundary stubs.
  Shared behavior should stay identical throughout the group and make scenarios
  easier to read. Avoid broad happy-path defaults that individual tests silently
  override.
- Separate Arrange, Act, and Assert with clear blank lines, without phase-label
  comments. Capture the result in Act before asserting on it. For asynchronous
  workflows, use separate action/assertion blocks for meaningful intermediate
  states.
- Prefer targeted spies over whole-module mocks. In Jest, use namespace imports
  with `jest.spyOn` where possible, and explicitly stub side-effecting functions
  because spies call through by default. Keep pure collaborators real when
  practical.
- Avoid top-level `jest.mocked` aliases for every dependency. Assert on the
  imported functions directly; use `jest.mocked` locally when typed mock
  metadata is needed. Keep module factories only for concrete constraints such
  as import-time side effects or non-configurable exports, and explain why.
- Accept small amounts of repeated setup when they make a test self-contained.
  Shared immutable fixtures and simple builders are fine; avoid setup helpers
  that hide the conditions a test depends on.
- Restore spies between tests, using the runner's existing configuration when
  available. Await observable asynchronous work deterministically; use fake
  timers for polling and release deferred work during cleanup, even on failure.
