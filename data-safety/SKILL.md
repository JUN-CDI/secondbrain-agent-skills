---
name: data-safety
description: Prevent committing real data (CSV/XLSX) and outputs by checking git status and updating .gitignore safely.
---

# データ混入防止（Git）

目的: 実データや成果物がGitに入る事故を防ぐ。

## チェック項目
1. `git status` で未追跡/変更を確認
2. 以下のパス/拡張子が追跡対象になっていないか確認
   - `samples/`
   - `deliverables/`
   - `*.csv` / `*.xlsx`

## 対処
- `.gitignore` に除外ルールを追加
  - `samples/` と `deliverables/` は原則除外
- すでに追跡されている場合:
  - `git rm --cached <path>`（ローカルには残す）

## 注意
- `.gitignore` 追加後は `git status` で再確認
- 迷ったらデータは**追跡しない**
