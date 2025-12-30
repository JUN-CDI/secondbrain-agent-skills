#!/bin/bash
# handoff-check.sh - ツール間引き継ぎ確認スクリプト

set -euo pipefail

VAULT_DIR="/Users/donaichu/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"

cd "$VAULT_DIR"

echo "========================================="
echo "🔄 Handoff Status Check"
echo "========================================="
echo ""

echo "📦 ステージング済み変更:"
if git diff --cached --quiet; then
  echo "  なし"
else
  git diff --cached --stat
fi

echo ""
echo "📝 未ステージ/未追跡の変更:"
UNSTAGED="$(git status --porcelain | awk 'substr($0,2,1)!=" "')"
if [[ -z "$UNSTAGED" ]]; then
  echo "  なし"
else
  echo "$UNSTAGED"
fi

echo ""
echo "💡 前回のコミット:"
git log -1 --oneline --decorate

echo ""
echo "🔢 未プッシュのコミット:"
UNPUSHED=$(git log @{u}.. --oneline 2>/dev/null | wc -l | xargs)
if [ "$UNPUSHED" -eq 0 ]; then
  echo "  なし"
else
  echo "  ${UNPUSHED}件"
  git log @{u}.. --oneline
fi

echo ""
echo "========================================="
echo "次のアクション:"
echo "  - 続行: そのまま作業"
echo "  - コミット: bash System/Scripts/checkpoint.sh '<message>'"
echo "  - リセット: git reset HEAD"
echo "  - プッシュ: git push"
echo "========================================="
