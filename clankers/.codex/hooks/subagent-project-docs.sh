#!/bin/sh
# SubagentStart hook — injects the global project-documentation rule into every
# subagent, including agent types that do not inherit ~/.codex/AGENTS.md.
RULE_FILE="$HOME/.codex/AGENTS.md"
[ -r "$RULE_FILE" ] || exit 0

jq -Rs '{hookSpecificOutput:{hookEventName:"SubagentStart",additionalContext:.}}' \
  < "$RULE_FILE"
