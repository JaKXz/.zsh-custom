#!/bin/sh
# SubagentStart hook — injects global rules into every subagent, including agent
# types that don't inherit ~/.claude/CLAUDE.md.
RULE_FILE="$HOME/.codex/AGENTS.md"
[ -r "$RULE_FILE" ] || exit 0

if command -v jq >/dev/null 2>&1; then
  jq -Rs '{hookSpecificOutput:{hookEventName:"SubagentStart",additionalContext:.}}' \
    < "$RULE_FILE"
else
  python3 -c 'import json,sys; print(json.dumps({"hookSpecificOutput":{"hookEventName":"SubagentStart","additionalContext":sys.stdin.read()}}))' \
    < "$RULE_FILE"
fi
