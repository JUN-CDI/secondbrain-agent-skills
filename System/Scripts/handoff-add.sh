#!/bin/bash
# handoff-add.sh - System/Documentation/引き継ぎ.md に1行追記する（ツール非依存）
#
# 使い方:
#   ./System/Scripts/handoff-add.sh "<変更ファイルパス|作業場所|メモ>" ["一言"]
#
# 例:
#   ./System/Scripts/handoff-add.sh "~/Workspaces/projects/my-app" "Codexレビューを実施（指摘はdocs/HANDOFF.mdへ）"
#   ./System/Scripts/handoff-add.sh "SecondBrain" "運用ドキュメント更新"
#
# 目的:
# - Cursorの /handoff を使わない場面（Codex拡張/CLI、外部ターミナル等）でも、
#   共通の作業状態（引き継ぎ.md）を1分で更新できるようにする。

set -euo pipefail

VAULT_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"
LOG_FILE="$VAULT_DIR/System/Documentation/引き継ぎ.md"

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  sed -n '1,120p' "$0"
  exit 0
fi

TARGET="${1:-}"
NOTE="${2:-}"

if [[ -z "$TARGET" ]]; then
  echo "Usage: $0 \"<path|place|note>\" [\"comment\"]" >&2
  exit 2
fi

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Error: log file not found: $LOG_FILE" >&2
  exit 1
fi

TODAY="$(date +%Y-%m-%d)"
NOW="$(date +%H:%M)"

# Ensure today's heading exists (current format uses '## YYYY-MM-DD')
if ! grep -q "^## ${TODAY}\$" "$LOG_FILE" 2>/dev/null; then
  printf "\n## %s\n\n" "$TODAY" >> "$LOG_FILE"
fi

LINE="- ${NOW} ${TARGET}"
if [[ -n "$NOTE" ]]; then
  LINE="${LINE} - ${NOTE}"
fi

echo "$LINE" >> "$LOG_FILE"
echo "OK: appended to 引き継ぎ.md -> $LINE"
