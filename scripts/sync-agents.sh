#!/usr/bin/env bash
# sync-agents.sh — Generate .claude/agents/*.md from .github/agents/*.md
# Transforms Copilot frontmatter to Claude Code format:
#   - Remaps model names
#   - Strips handoffs: block
#   - Preserves name: and description: as-is
#   - Copies markdown body unchanged

set -euo pipefail

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
SRC_DIR="$REPO_ROOT/.github/agents"
DST_DIR="$REPO_ROOT/.claude/agents"

mkdir -p "$DST_DIR"

for src_file in "$SRC_DIR"/*.md; do
  filename="$(basename "$src_file")"

  # Skip files without YAML frontmatter (e.g. notes)
  if ! head -1 "$src_file" | grep -q '^---$'; then
    echo "Skipping $filename (no frontmatter)"
    continue
  fi

  echo "Syncing $filename"

  # Split into frontmatter and body
  # frontmatter is between first and second '---'
  awk '
    BEGIN { fm=0; printed_end=0 }
    /^---$/ && fm==0 { fm=1; next }
    /^---$/ && fm==1 { fm=2; next }
    fm==1 { print }
  ' "$src_file" > /tmp/agent_fm.yml

  awk '
    BEGIN { fm=0 }
    /^---$/ && fm==0 { fm=1; next }
    /^---$/ && fm==1 { fm=2; next }
    fm==2 { print }
  ' "$src_file" > /tmp/agent_body.md

  # Transform frontmatter:
  # 1. Remap model names
  # 2. Strip handoffs block (multi-line YAML)
  transformed_fm=$(awk '
    BEGIN { in_handoffs=0 }
    /^handoffs:/ { in_handoffs=1; next }
    in_handoffs==1 && /^[^ ]/ { in_handoffs=0 }
    in_handoffs==1 { next }
    /^model:/ {
      if ($0 ~ /Claude Sonnet 4\.5/) { print "model: sonnet"; next }
      if ($0 ~ /Claude Haiku 3\.5/)  { print "model: haiku"; next }
      if ($0 ~ /Claude Opus 4\.6/)   { print "model: opus"; next }
      # fallback: keep as-is
      print; next
    }
    { print }
  ' /tmp/agent_fm.yml)

  # Write output
  {
    echo "---"
    echo "$transformed_fm"
    echo "---"
    cat /tmp/agent_body.md
  } > "$DST_DIR/$filename"
done

rm -f /tmp/agent_fm.yml /tmp/agent_body.md
echo "Done. Generated agents in $DST_DIR"
