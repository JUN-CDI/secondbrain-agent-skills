#!/bin/bash
# session-init-mem.sh - SSOT（意思決定/パターン/ガードレール）をセッション開始時に要約表示する

set -euo pipefail

VAULT_DIR="${VAULT_DIR:-$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain}"

DECISIONS_FILE="$VAULT_DIR/Atlas/意思決定.md"
PATTERNS_FILE="$VAULT_DIR/Atlas/パターン.md"
GUARDS_FILE="$VAULT_DIR/Atlas/ガードレール.md"

LIMIT="${1:-3}"
if ! [[ "$LIMIT" =~ ^[0-9]+$ ]]; then
  LIMIT="3"
fi

extract_headings() {
  local file="$1"
  local prefix="$2"
  local label="$3"

  echo "$label"
  if [[ ! -f "$file" ]]; then
    echo "- （未作成）$file"
    return 0
  fi

  local out
  out="$(
    awk -v prefix="$prefix" -v limit="$LIMIT" '
      $0 ~ ("^## " prefix "[0-9][0-9]: ") {
        sub(/^## /, "- ")
        print
        count++
        if (count >= limit) exit
      }
    ' "$file"
  )"

  if [[ -z "$out" ]]; then
    echo "- （まだ登録なし）"
    return 0
  fi

  echo "$out"
}

echo ""
echo "========================================="
echo "📌 SSOT ダイジェスト（最新${LIMIT}件）"
echo "========================================="
extract_headings "$DECISIONS_FILE" "D" "📚 decision（意思決定）:"
echo ""
extract_headings "$PATTERNS_FILE" "P" "🐛 bugfix/pattern（パターン）:"
echo ""
extract_headings "$GUARDS_FILE" "G" "⚠️ guard（ガードレール）:"
echo "========================================="
echo ""

