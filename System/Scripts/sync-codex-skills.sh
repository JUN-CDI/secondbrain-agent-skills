#!/bin/bash
# sync-codex-skills.sh - Sync Vault skills to Codex skills directory

set -euo pipefail

VAULT_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"
SRC_DIR="$VAULT_DIR/System/Skills"
DST_DIR="$HOME/.codex/skills"

if [[ ! -d "$SRC_DIR" ]]; then
  echo "Source not found: $SRC_DIR" >&2
  exit 1
fi

mkdir -p "$DST_DIR"

# Exclude authoring templates from Codex skills.
rsync -a --exclude '.git/' --exclude '.claude/' --exclude 'skill-template/' --exclude 'skill-creator/' "$SRC_DIR"/ "$DST_DIR"/

echo "Synced skills to $DST_DIR"
ls -1 "$SRC_DIR"
