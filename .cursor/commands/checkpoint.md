---
name: checkpoint
description: Save current work checkpoint (script)
---

# Checkpoint Command

## Instructions

```bash
bash "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain/System/Scripts/checkpoint.sh" "[Cursor]"
```

## Usage

1. Run this command from Cursor
2. 運用/ハーネス対象のみを安全にステージ→コミット
3. `checkpoint-<timestamp>` タグが作成される（ロールバック用）

## Rollback

```bash
git log --oneline -10
git reset --hard checkpoint-YYYY-MM-DD-HHMM
```
