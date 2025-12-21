---
name: diff-review
description: Review staged git diffs with prioritized findings, concrete fixes, and data-safety checks before commit.
---

# 差分レビュー

目的: `git diff --staged` を前提に、短く具体的なレビューを返す。

## 進め方
1. `git status` と `git diff --staged` で差分を把握
2. 変更の意図を1〜2行で要約
3. 指摘は優先度順（P0/P1/P2）で列挙
   - 理由（何が問題か）
   - 具体的な修正案（可能ならパッチ/擬似コード）
   - 影響範囲（どこが壊れうるか）
   - 確認手順（どう確認するか）
4. 新規/更新ファイルは、命名・配置・責務の妥当性も確認
5. データ混入チェック（`samples/`, `deliverables/`, `*.csv`, `*.xlsx`）
6. 最後に「このまま進めて良いか」を Yes/No（条件付き可）で結論

## 制約
- 既存仕様を壊さない
- 不要な大規模リネーム/全体フォーマット変更はしない

## 出力フォーマット（推奨）
- 変更要約（1〜2行）
- 指摘（P0 → P1 → P2）
- リファクタ提案（軽め）
- 結論（Yes/No/条件付き）
