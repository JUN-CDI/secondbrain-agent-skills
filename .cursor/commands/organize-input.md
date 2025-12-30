# inbox整理・振り分け（移動まで実行）

## Description
`Calendar/inbox/` のファイルを読み、内容に応じて `Atlas/` または `Efforts/` に移動します。

## 使用するツール
- `read_file`: ファイル内容を読み込む（必ず全文）
- `run_terminal_cmd`: `mv` / `mkdir` で移動
- `list_dir`: `Efforts/` の既存プロジェクト確認

## Prompt
対象:
- 引数があればその1ファイル
- 省略時は `Calendar/inbox/` の全Markdown

ルール:
- **Atlasはフラット運用**（サブフォルダは作らない）
- **プロジェクトは `Efforts/<project>/` 直下**（`@Active/@Planning` は使わない）
- 迷ったら無理に動かさない（`Calendar/inbox/` に残す）

手順:
1. 対象ファイルを必ず全文読む
2. 振り分け判定
   - 3ヶ月後も参照 → `Atlas/`
   - 期限あり/進行中（プロジェクト） → `Efforts/<project>/`
   - 手順書/ナレッジ（再利用） → `Atlas/`
   - 完了/不要 → `Efforts/archived/`
   - 迷う/今週使う → `Calendar/inbox/`（残す）
3. 移動が必要なら `mkdir -p` → `mv`
4. 移動後の最小整形
   - frontmatterの `tags` を最小で追加
   - 重要概念の `[[links]]` を1〜2個提案
   - `Atlas/` に入れた場合は `Atlas/🗺️ Atlas-MOC.md` か該当MOCへ1リンク追加を提案
5. サマリ表を出す（移動/残し）

関連:
- [[System/Documentation/運用ガイド-全体像]]
- [[System/Workflows/inbox-processing-flow]]
- [[System/prompts/20250113_03_Input整理]]
