#!/bin/bash
# sync-codex-skills.sh - Sync Vault skills to Codex skills directory

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_DIR="${VAULT_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}"
SRC_DIR="${SRC_DIR:-$VAULT_DIR/System/Skills}"
DST_DIR="${DST_DIR:-$HOME/.codex/skills}"
SKILLS_REPO_URL="${SKILLS_REPO_URL:-https://github.com/JUN-CDI/secondbrain-agent-skills.git}"

usage() {
  cat <<'EOF'
Usage: sync-codex-skills.sh [--clone] [--from-codex] [--source <dir>] [--dest <dir>]

Sync Agent Skills from the Vault "原本" to Codex skills directory.

Default:
  source: <Vault>/System/Skills
  dest:   ~/.codex/skills

If the source directory is missing, this script can bootstrap it:
  --from-codex  Copy from existing ~/.codex/skills (offline)
  --clone       Clone the skills repo into System/Skills (network)
EOF
}

BOOTSTRAP_CLONE=0
BOOTSTRAP_FROM_CODEX=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    --clone)
      BOOTSTRAP_CLONE=1
      shift
      ;;
    --from-codex)
      BOOTSTRAP_FROM_CODEX=1
      shift
      ;;
    --source)
      SRC_DIR="${2:-}"
      shift 2
      ;;
    --dest)
      DST_DIR="${2:-}"
      shift 2
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

bootstrap_from_codex() {
  if [[ ! -d "$DST_DIR" ]]; then
    return 1
  fi

  mkdir -p "$SRC_DIR"

  local copied=0
  for skill in data-safety diff-review git-checkpoint ops-maintenance; do
    if [[ -d "$DST_DIR/$skill" ]]; then
      mkdir -p "$SRC_DIR/$skill"
      rsync -a "$DST_DIR/$skill/" "$SRC_DIR/$skill/"
      copied=1
    fi
  done

  [[ "$copied" -eq 1 ]]
}

bootstrap_by_clone() {
  if [[ -d "$SRC_DIR" ]]; then
    return 0
  fi
  if ! command -v git >/dev/null 2>&1; then
    return 1
  fi
  mkdir -p "$(dirname "$SRC_DIR")"
  git clone "$SKILLS_REPO_URL" "$SRC_DIR"
}

if ! has_any_skill "$SRC_DIR"; then
  if [[ "$BOOTSTRAP_CLONE" -eq 1 ]]; then
    bootstrap_by_clone || true
  fi

  if ! has_any_skill "$SRC_DIR"; then
    # Default is offline bootstrap unless explicitly disabled.
    if [[ "$BOOTSTRAP_FROM_CODEX" -eq 1 || "$BOOTSTRAP_CLONE" -eq 0 ]]; then
      bootstrap_from_codex || true
    fi
  fi
fi

if ! has_any_skill "$SRC_DIR"; then
  echo "Source not found or empty: $SRC_DIR" >&2
  echo "" >&2
  echo "This folder is the skills \"原本\". If it's missing, bootstrap it with one of:" >&2
  echo "  - Offline: $0 --from-codex" >&2
  echo "  - Clone:   $0 --clone   (repo: $SKILLS_REPO_URL)" >&2
  exit 1
fi

mkdir -p "$DST_DIR"

# Exclude authoring templates from Codex skills.
rsync -a --exclude '.git/' --exclude '.claude/' --exclude 'skill-template/' --exclude 'skill-creator/' "$SRC_DIR"/ "$DST_DIR"/

echo "Synced skills to $DST_DIR"
ls -1 "$SRC_DIR"
