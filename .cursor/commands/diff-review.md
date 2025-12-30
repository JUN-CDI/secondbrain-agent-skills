# diff-review（ステージ差分レビュー）

## Description
`git diff --staged` を前提に、短く具体的な差分レビューをします（P0/P1/P2で優先度付け）。

## Prompt
次を実行してください。

1) `git diff --staged` を用意（未ステージなら先に `/git-checkpoint`）
2) `git diff --staged` を確認して、レビューを出す
   - 指摘は P0/P1/P2 の順
   - 具体的な修正案（可能ならパッチ/擬似コード）
   - 影響範囲と確認手順
3) データ混入チェック（`samples/`, `deliverables/`, `*.csv`, `*.xlsx`）
4) 結論を Yes/No（条件付き可）で出す

