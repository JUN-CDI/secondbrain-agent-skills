---
name: input-processor
description: Process and organize files in Calendar/inbox folder. Use when user mentions "Input整理", "メモ整理", "inbox", "振り分け", or asks to organize notes and memos.
allowed-tools: Read, Write, Edit, Glob, Grep, Bash(mv:*), Bash(mkdir:*)
---

# Input Processor Skill

`Calendar/inbox/` フォルダ内のファイルを自動的に整理・振り分けするスキルです。

## Instructions

### Step 1: Scan Calendar/inbox
```bash
ls -la "Calendar/inbox/"
```

### Step 2: Read and Analyze Each File
For each file:
1. Read the entire content (not just filename)
2. Understand the core topic/purpose
3. Extract key concepts

### Step 3: Determine Destination
Based on content analysis:

| Condition | Destination |
|---|---|
| 3ヶ月後も参照価値あり | `Atlas/` |
| 期限あり/進行中（プロジェクト） | `Efforts/` |
| 手順/納品物（参照版） | `Atlas/`（正本は `Finals(OneDrive)` 等に置いてリンク） |
| 日次記録 | `Calendar/YYYY-MM/` |
| 判断困難 / 迷う | `Calendar/inbox/`（残す） |
| 使い終わり | `Efforts/archived/` |

### Step 4: Move Files
```bash
# Example move command
mv "Calendar/inbox/filename.md" "Atlas/"
```

### Step 5: Update Metadata
After moving:
- Add appropriate tags in frontmatter
- Add relevant [[links]]
- If moved to `Atlas/`, update MOC links (minimum 1 link)
  - `Atlas/🗺️ Atlas-MOC.md`
  - and/or one of the domain MOCs below

### Step 6: Report Summary
Output a table summarizing all moves:

```markdown
| ファイル | 移動先 | 理由 |
|---------|--------|------|
| file1.md | Atlas/ | 長期で参照する知識 |
```

## Atlas MOCs (flat)
- `Atlas/_AI-MOC.md`
- `Atlas/_Business-MOC.md`
- `Atlas/_Education-MOC.md`
- `Atlas/_Personal-MOC.md`

## Important Rules
- ALWAYS read file content before deciding
- NEVER judge by filename alone
- Do NOT create deep subfolders in `Atlas/` (keep it flat)
