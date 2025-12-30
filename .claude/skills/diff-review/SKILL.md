---
name: diff-review
description: Review staged git diffs (git diff --staged) with prioritized findings and concrete fixes. Use after git-checkpoint.
allowed-tools: Read, Bash(git:*)
---

# Diff Review Skill

ステージ差分（`git diff --staged`）を前提に、短く具体的なレビューを返します。

## Instructions

### Step 0: Preconditions
- If there is no staged diff, recommend running `git-checkpoint` first (or `git add -p`).

### Step 1: Inspect staged diff
Run:
```bash
git status -sb
git diff --staged
git diff --staged --stat
```

### Step 2: Review output (short + concrete)
Return:
- 変更要約（1〜2行）
- 指摘（P0 → P1 → P2）
  - 理由（何が問題か）
  - 具体的な修正案（可能ならパッチ/擬似コード）
  - 影響範囲（どこが壊れうるか）
  - 確認手順（どう確認するか）
- データ混入チェック（`samples/`, `deliverables/`, `*.csv`, `*.xlsx`）
- 結論（Yes / No / 条件付き）

