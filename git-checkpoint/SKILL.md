---
name: git-checkpoint
description: Stage only the intended changes with git add -p, review with git diff --staged, and keep WIP unstaged for clean diffs.
---

# Gitチェックポイント

目的: 差分を小さく「確定」して、レビュー/コミットの粒度を保つ。

## 手順
1. `git status` で変更/未追跡を確認
2. `git diff` で作業中の差分を確認
3. まとまった変更だけを `git add -p`（または `git add <file>`）でステージ
4. `git diff --staged` で**確定した差分だけ**を確認
5. 必要なら `git restore --staged <file>` でステージを戻す
6. 未ステージのWIPはそのまま残してOK

## 注意
- サンプル/成果物（`samples/`, `deliverables/`, `*.csv`, `*.xlsx`）が混入していないか確認
- レビュー対象は基本 `git diff --staged`

## 完了条件
- `git diff --staged` が「レビューしたい範囲」だけを含んでいる
