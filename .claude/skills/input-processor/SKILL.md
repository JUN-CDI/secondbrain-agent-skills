---
name: input-processor
description: Process and organize files in 03_Input folder. Use when user mentions "Input整理", "メモ整理", "03_Input", "振り分け", or asks to organize notes and memos.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(mv:*), Bash(mkdir:*)
---

# Input Processor Skill

03_Inputフォルダ内のファイルを自動的に整理・振り分けするスキルです。

## Instructions

### Step 1: Scan 03_Input
```bash
# List all files in 03_Input
ls -la "03_Input/"
```

### Step 2: Read and Analyze Each File
For each file:
1. Read the entire content (not just filename)
2. Understand the core topic/purpose
3. Extract key concepts

### Step 3: Determine Destination
Based on content analysis:

| Condition | Destination |
|-----------|-------------|
| 3ヶ月後も参照価値あり | `04_Memory/[category]/` |
| プロジェクト関連 | `05_Output/Projects/` |
| 継続活動関連 | `05_Output/Areas/` |
| 日次記録 | `02_Daily/YYYY/YYYY-MM/YYYY-MM-DD/` |
| 判断困難 | `99_Archive/` |
| 今週使う | `03_Input/`（残す） |

### Step 4: Move Files
```bash
# Example move command
mv "03_Input/filename.md" "04_Memory/AI/Tools/"
```

### Step 5: Update Metadata
After moving:
- Add appropriate tags in frontmatter
- Add relevant [[links]]
- Update MOC if moved to Memory

### Step 6: Report Summary
Output a table summarizing all moves:

```markdown
| ファイル | 移動先 | 理由 |
|---------|--------|------|
| file1.md | 04_Memory/AI/ | AI関連の長期知識 |
```

## Memory Subfolders
- `AI/` - AI関連（Tools, Techniques, Concepts）
- `Business/` - ビジネス関連
- `Education/` - 教育関連
- `Personal/` - 個人関連
- `Technical/` - 技術関連

## Important Rules
- ALWAYS read file content before deciding
- NEVER judge by filename alone
- Create subfolders if they don't exist
- Preserve original file dates where possible
