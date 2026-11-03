---
name: pairing-session-board
description: Create a fresh 1Password pairing session board in Notion from the Pairing Session Boards template. Use when asked to make a pairing board, including for linked Jira work; ask how to construct its title when that input is missing.
---

# Pairing session board

Create a blank session board under [Pairing Session Boards](https://app.notion.com/p/3a6633c0e92d4395aff89d0730d399f9) by duplicating its **Pairing Session – Template** child page. The template contains an inline kanban board.

1. If the user has not supplied an exact title or a rule for constructing one, ask: **How should I construct the board title?** Accept either the exact title or a pattern such as topic, participants, and date in a chosen order. Wait for the answer before creating anything. Fill in requested ingredients from the conversation and linked sources; use the user's local date when the pattern calls for a date. Ask only for any ingredient that remains unavailable.
2. Fetch the parent and its template to confirm their current relationship. Check that the template's board has no task rows. Do not alter the template. If it has tasks, stop and report that the template is no longer blank; do not duplicate it into a session board.
3. Duplicate the template once, then rename the returned copy with the constructed title. Wait for asynchronous duplication to populate the copy before relying on its content. Do not add task rows from issue links or other context unless the user explicitly asks for them.
4. Verify the copy is under the parent, has the requested title, retains the To Do, Doing, and Done board columns, and has zero tasks. If a step fails after duplication, inspect the existing copy before retrying so that retries do not create extra boards. Return the new board's link.

Use an available Notion connection with page fetch, duplication, rename, and database query capabilities. If the required access is unavailable, explain the missing connection and stop without claiming the board was created.
