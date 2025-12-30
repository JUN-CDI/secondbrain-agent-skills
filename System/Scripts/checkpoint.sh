#!/bin/bash
# checkpoint.sh - 手動チェックポイント作成スクリプト

set -euo pipefail

VAULT_DIR="/Users/donaichu/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"
MESSAGE="${1:-checkpoint}"
TIMESTAMP=$(date +%Y-%m-%d-%H%M)

cd "$VAULT_DIR"

# ステージング（運用/ハーネスのみ）
VAULT_DIR="$VAULT_DIR" bash "$VAULT_DIR/System/Scripts/git-stage-ops.sh"

# 変更があるか確認（untrackedも含む）
if git diff --cached --quiet; then
  echo "⚠️  変更なし（チェックポイント不要）"
  exit 0
fi

# コミット
git commit -m "checkpoint: $TIMESTAMP - $MESSAGE" --no-verify

# 結果表示
echo "✅ Checkpoint saved: checkpoint-$TIMESTAMP"
echo ""
echo "📊 コミット内容:"
git show HEAD --stat --oneline

# タグ作成（rollback用）
git tag "checkpoint-$TIMESTAMP" 2>/dev/null || true
echo ""
echo "📍 Rollback: git reset --hard checkpoint-$TIMESTAMP"
