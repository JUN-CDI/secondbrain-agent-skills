#!/bin/bash
# git-stage-ops.sh - 運用/ハーネス対象のみをステージする（A方針）
#
# 目的:
# - 個人ノート（Atlas/Calendar/Efforts）やログ類を誤ってGitに入れない
# - Hook/Checkpoint のステージ処理を1箇所に集約して保守性を上げる
#
# 使い方:
#   bash System/Scripts/git-stage-ops.sh
#   VAULT_DIR="..." bash System/Scripts/git-stage-ops.sh
#
# 仕様:
# - ステージ対象は固定（運用/ハーネスのみ）
# - 対象が存在しない場合はスキップ（削除ステージは tracked を見て判断）

set -euo pipefail

VAULT_DIR="${VAULT_DIR:-$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain}"

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  sed -n '1,120p' "$0"
  exit 0
fi

cd "$VAULT_DIR"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  echo "Error: not a git repository: $VAULT_DIR" >&2
  exit 1
fi

ADD_PATHS=(
  ".gitignore"
  "README.md"
  "AGENTS.md"
  "CLAUDE.md"
  "Plans.md"
  "CURSOR-COMMANDS-GUIDE.md"
  "claude-code-harness.config.json"
  "System"
  ".claude"
  ".cursor"
  ".vscode"
  ".obsidian/app.json"
)

has_tracked_under() {
  local path="$1"
  git ls-files -- "$path" | sed -n '1p' | grep -q .
}

should_stage() {
  local path="$1"
  [[ -e "$path" ]] || has_tracked_under "$path"
}

for path in "${ADD_PATHS[@]}"; do
  if should_stage "$path"; then
    git add -A -- "$path"
  fi
done

