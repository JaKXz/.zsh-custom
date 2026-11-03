---
name: write-pr-description
description: Write a PR/MR description to the clipboard in a fixed Why/What form, scoped to whatever changes are currently in play - a git branch ahead of its default branch, a jj bookmark ahead of trunk, or uncommitted working-copy changes if neither exists. Pulls in only the fields a repo's PR template marks as strictly mandatory (e.g. Changelog, Platforms) and leaves out everything the template doesn't require. Use when asked to write, draft, or generate a PR description, write a merge-request description, or "write a PR description to my clipboard".
argument-hint: "[path-to-pr-template]"
---

# Write a PR description

Produces exactly this form, then copies it to the OS clipboard:

```
## Why <motivation>

## What <strategic explanation>
```

Plus, appended after `## What` in the template's own field format: only the
fields the repo's PR/MR template explicitly marks as mandatory/required.
Nothing else from the template (checklist, "Thought Process", "How To Test",
Jira link, etc.) gets pulled in unless it is explicitly marked mandatory.

## 1. Determine the change scope

Figure out what "all the changes" refers to, in this order:

1. **jj bookmark** — if the repo is jj-colocated or pure jj (`jj root`
   succeeds), find the current bookmark/change and diff it against trunk:
   `jj log -r 'trunk()..@' --no-graph -T 'description'` for commit context,
   `jj diff --from 'trunk()' --to @` for the actual diff.
2. **git branch** — else, find the default branch (`git symbolic-ref
   refs/remotes/origin/HEAD --short`, falling back to `main` then `master`),
   and check if the current branch has commits ahead of it
   (`git rev-list --count <default>..HEAD`). If so, diff scope is
   `git diff <default>...HEAD` (merge-base diff) plus `git log
   <default>..HEAD --oneline` for commit messages.
3. **working copy** — else (detached HEAD, on the default branch, or zero
   commits ahead), fall back to uncommitted changes: `git status --short` +
   `git diff HEAD` (covers staged and unstaged). Call out any untracked files
   separately since `git diff` won't show their contents.

State plainly which of the three applied — don't silently guess. If there
turn out to be no changes in any of the three, say so and stop instead of
inventing content.

## 2. Find the repo's PR/MR template

Check, in order: `.github/PULL_REQUEST_TEMPLATE.md`,
`.github/pull_request_template.md`, `.github/PULL_REQUEST_TEMPLATE/*.md`
(GitHub multi-template dirs), `docs/PULL_REQUEST_TEMPLATE.md`, root
`PULL_REQUEST_TEMPLATE.md`, `.gitlab/merge_request_templates/*.md`. An
explicit path passed as an argument to this skill overrides the search.

If multiple templates exist and it's not obvious which applies, ask the user
rather than guessing. If none exist, skip straight to composing Why/What with
no extra fields — say that no template was found.

**Extracting "strictly required" fields**: read the template's own prose and
HTML comments for explicit mandatory/required language (e.g. "X is
mandatory", "required", "must be present") tied to a specific field. Only
those fields qualify - a field merely having a placeholder, or living under a
"nice to have" checklist, does not. Reuse the field's exact label text and
formatting from the template (e.g. `Changelog:` vs `**Changelog:**`).

For fields whose value you cannot know (a Jira link, an Unleash flag name),
never fabricate one. Use the template's own placeholder or `N/A`, and flag it
to the user explicitly rather than guessing.

## 3. Compose the description

- **Why**: the motivation — the problem being solved or need addressed,
  grounded in concrete evidence from the diff/commits (an error, a drift, a
  missing capability), not a restatement of "there was a bug."
- **What**: the strategic explanation — the shape of the solution and why
  that approach, grouped by area/component. Not a line-by-line diff
  walkthrough; name the key mechanism per area (renamed/added/removed
  concepts), not every changed line.
- Keep both sections tight - a few sentences each, not a wall of text.
- Append the mandatory fields (if any were found in step 2) directly after
  `## What`, each on its own line, matching the template's exact label
  format. Do not add a header for them; match how the template itself lays
  them out (flat lines, not nested under another section).

## 4. Copy to the clipboard

Write the composed text to a temp file, then pipe it to whichever clipboard
tool exists on this OS, then delete the temp file:

```bash
if command -v pbcopy >/dev/null 2>&1; then
  pbcopy < /tmp/pr_description.md
elif command -v clip.exe >/dev/null 2>&1; then
  clip.exe < /tmp/pr_description.md
elif command -v xclip >/dev/null 2>&1; then
  xclip -selection clipboard < /tmp/pr_description.md
elif command -v xsel >/dev/null 2>&1; then
  xsel --clipboard --input < /tmp/pr_description.md
else
  echo "No clipboard tool found - printing instead:"
  cat /tmp/pr_description.md
fi
rm -f /tmp/pr_description.md
```

Writing to a temp file first (rather than an inline heredoc) avoids quoting
issues with backticks, `$`, and other shell-special characters that commonly
show up in PR descriptions referencing code.

## 5. Report back

Show the composed Why/What text (plus any appended fields) back to the user
so they can see what was copied without needing to paste it somewhere first.
Explicitly flag anything that needed a judgment call: which of the three
change-scopes applied, any mandatory field whose value you couldn't determine
and left as a placeholder, and whether the underlying changes are even
committed yet (a PR can't be opened against uncommitted or unbranched work -
say so if that's the case, don't imply it's ready to open).
