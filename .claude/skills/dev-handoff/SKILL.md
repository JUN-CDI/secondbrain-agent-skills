---
name: dev-handoff
description: Create a concise development handoff summary. Use when user mentions "引き継ぎ", "handoff", "作業状況まとめ", or "引き渡し".
allowed-tools: Read, Write, Bash(git:*)
---

# Dev Handoff Skill

開発作業の引き継ぎを、短く正確にまとめるスキルです。

## Instructions

### Step 1: Confirm scope
Ask if missing:
- Repo path
- Branch name
- Whether to stage changes (`git add -p`) or keep as-is

### Step 2: Collect status
Run the minimum commands:
```bash
git status -sb
git diff
git diff --staged
```

If the user wants to stage:
```bash
git add -p
git diff --staged
```

### Step 3: Data safety check
Flag any tracked data files:
- `samples/`
- `deliverables/`
- `*.csv` / `*.xlsx`

If found, suggest:
```bash
git rm --cached <path>
```
and update `.gitignore`.

### Step 4: Produce handoff summary
Output the summary using this template:
```markdown
# 引き継ぎサマリ

## 目的
- 何を達成する変更か（1〜2行）

## Repo / Branch
- Repo: <path>
- Branch: <branch-name>

## 変更の範囲
- ステージ済み: <files / 概要>
- 未ステージ: <files / 概要>

## 重要な判断/合意
- <決定事項>
- <除外事項/運用ルール>

## 実行した確認
- <テスト/手動確認/結果>

## 次にやること
- <次の作業>

## 不明点/質問
- <確認したいこと>
```

### Step 5: What to pass next
Ask the user to paste:
- `git status -sb`
- `git diff --staged --stat`
- the handoff summary above
