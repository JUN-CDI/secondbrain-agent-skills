#!/bin/bash
# sync-claude-skills.sh - Sync Vault skills "原本" to Claude Code skills directory
#
# Goal: make Skills available regardless of where you start (Vault / any repo).
# Default destination is ~/.claude/skills.
#
# Usage:
#   ./System/Scripts/sync-claude-skills.sh
#   ./System/Scripts/sync-claude-skills.sh --dest "$HOME/.claude/skills"
#   ./System/Scripts/sync-claude-skills.sh --include-template
#   ./System/Scripts/sync-claude-skills.sh --dry-run
#
# Notes:
# - By default, excludes authoring templates (skill-template/) to keep runtime skills lean.
# - `skill-creator/` is included by default (it's useful in Claude Code). Use --exclude-creator to skip.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_DIR="${VAULT_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
SRC_DIR="${SRC_DIR:-$VAULT_DIR/System/Skills}"
DST_DIR="${DST_DIR:-$HOME/.claude/skills}"

INCLUDE_TEMPLATE=0
EXCLUDE_CREATOR=0
DRY_RUN=0

usage() {
  cat <<'EOF'
Usage: sync-claude-skills.sh [options]

Sync Agent Skills from the Vault "原本" to Claude Code skills directory.

Default:
  source: <Vault>/System/Skills
  dest:   ~/.claude/skills

Options:
  --source <dir>        Source directory (default: <Vault>/System/Skills)
  --dest <dir>          Destination directory (default: ~/.claude/skills)
  --include-template    Also sync skill-template/ (authoring template)
  --exclude-creator     Do NOT sync skill-creator/
  --dry-run             Show what would be copied (rsync -n)
  -h, --help            Show help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --source)
      SRC_DIR="${2:-}"
      shift 2
      ;;
    --dest)
      DST_DIR="${2:-}"
      shift 2
      ;;
    --include-template)
      INCLUDE_TEMPLATE=1
      shift
      ;;
    --exclude-creator)
      EXCLUDE_CREATOR=1
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

has_any_skill() {
  local dir="$1"
  [[ -d "$dir" ]] || return 1
  find "$dir" -maxdepth 2 -name 'SKILL.md' -print -quit | grep -q .
}

if ! has_any_skill "$SRC_DIR"; then
  echo "Source not found or empty: $SRC_DIR" >&2
  echo "This folder is the skills \"原本\" (Vault)." >&2
  exit 1
fi

mkdir -p "$DST_DIR"

rsync_args=(-a)
if [[ "$DRY_RUN" -eq 1 ]]; then
  rsync_args+=(-n)
fi

exclude_args=(--exclude '.git/')
if [[ "$INCLUDE_TEMPLATE" -ne 1 ]]; then
  exclude_args+=(--exclude 'skill-template/')
fi
if [[ "$EXCLUDE_CREATOR" -eq 1 ]]; then
  exclude_args+=(--exclude 'skill-creator/')
fi

rsync "${rsync_args[@]}" "${exclude_args[@]}" "$SRC_DIR"/ "$DST_DIR"/

if [[ "$DRY_RUN" -eq 1 ]]; then
  echo "Dry-run complete. (No files were copied.)"
else
  echo "Synced skills to $DST_DIR"
fi

ls -1 "$SRC_DIR"

