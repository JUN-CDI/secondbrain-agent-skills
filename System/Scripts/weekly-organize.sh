#!/bin/bash
# weekly-organize.sh - 週次整理の自動実行
#
# 使い方:
#   ./weekly-organize.sh          # 標準実行
#   ./weekly-organize.sh --dry-run # ドライラン（実際には移動しない）
#
# 推奨: crontab に登録して日曜夜に自動実行
#   0 21 * * 0 /path/to/weekly-organize.sh >> ~/logs/weekly-organize.log 2>&1

set -e

VAULT_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"
INPUT_DIR="$VAULT_DIR/Calendar/inbox"
LOG_FILE="$HOME/logs/claude-weekly-$(date +%Y%m%d).log"
DRY_RUN=false

# Parse arguments
if [[ "$1" == "--dry-run" ]]; then
    DRY_RUN=true
    echo "🔍 Dry run mode - no files will be moved"
fi

# Create log directory
mkdir -p "$(dirname "$LOG_FILE")"

echo "========================================" | tee -a "$LOG_FILE"
echo "🗓️  Weekly Organize - $(date)" | tee -a "$LOG_FILE"
echo "========================================" | tee -a "$LOG_FILE"

# Count files in Calendar/inbox
FILE_COUNT=$(find "$INPUT_DIR" -type f -name "*.md" | wc -l | tr -d ' ')
echo "📁 Files in Calendar/inbox: $FILE_COUNT" | tee -a "$LOG_FILE"

if [[ "$FILE_COUNT" -eq 0 ]]; then
    echo "✅ No files to process" | tee -a "$LOG_FILE"
    exit 0
fi

# Run Claude Code for organization
if [[ "$DRY_RUN" == true ]]; then
    echo "🔍 Would run: claude -p \"Calendar/inboxを整理して振り分け先を提案\"" | tee -a "$LOG_FILE"
else
    echo "🤖 Running Claude Code..." | tee -a "$LOG_FILE"
    cd "$VAULT_DIR"
    claude -p "Calendar/inboxフォルダ内のファイルを整理してください。各ファイルの内容を読んで、適切なフォルダ（Atlas / Efforts / Efforts/archived）へ振り分けてください。迷ったものはCalendar/inboxのままでOKです。" \
        --max-turns 20 \
        2>&1 | tee -a "$LOG_FILE"
fi

echo "" | tee -a "$LOG_FILE"
echo "✅ Weekly organize completed at $(date)" | tee -a "$LOG_FILE"
