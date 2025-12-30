#!/bin/bash
# check-updates.sh - Claude Code更新チェック
#
# 使い方:
#   ./check-updates.sh              # 更新確認
#   ./check-updates.sh --save       # レポートを保存
#
# 推奨: 月1回実行

set -e

VAULT_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"
REPORT_DIR="$VAULT_DIR/System/Documentation/Claude-Code-Updates"
SAVE_FLAG="${1:-}"
TODAY=$(date +%Y-%m-%d)

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}🔍 Claude Code Update Check - $TODAY${NC}"
echo "=========================================="

# Check Claude Code version
echo -e "${YELLOW}📌 Current Claude Code version:${NC}"
claude --version 2>/dev/null || echo "Claude Code not found in PATH"

# Run Claude to check for updates
echo ""
echo -e "${YELLOW}🤖 Checking for updates...${NC}"

PROMPT="Claude Codeの最新機能とアップデートを確認してください。
以下の点を調べてください：
1. 新しいSkills機能
2. 新しいHooksイベント
3. MCPの更新
4. CLIの新オプション
5. 破壊的変更

現在の運用フローへの影響を分析し、推奨される変更があれば提案してください。

出力形式:
- 新機能一覧（影響度付き）
- 推奨アクション
- 次回確認推奨日"

if [[ "$SAVE_FLAG" == "--save" ]]; then
    mkdir -p "$REPORT_DIR"
    REPORT_FILE="$REPORT_DIR/$TODAY-update.md"

    echo "---" > "$REPORT_FILE"
    echo "title: Claude Code Updates $TODAY" >> "$REPORT_FILE"
    echo "tags: [system, claude-code, updates]" >> "$REPORT_FILE"
    echo "created: $TODAY" >> "$REPORT_FILE"
    echo "---" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"
    echo "# Claude Code Updates - $TODAY" >> "$REPORT_FILE"
    echo "" >> "$REPORT_FILE"

    cd "$VAULT_DIR"
    claude -p "$PROMPT" --max-turns 5 >> "$REPORT_FILE" 2>&1

    echo -e "${GREEN}✅ Report saved to: $REPORT_FILE${NC}"
else
    cd "$VAULT_DIR"
    claude -p "$PROMPT" --max-turns 5
fi

echo ""
echo -e "${GREEN}✅ Update check completed${NC}"
echo ""
echo "次回確認推奨: $(date -v+1m +%Y-%m-%d)"
