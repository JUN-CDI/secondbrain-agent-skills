# プロジェクトビュー（Vault側）

## Description
指定プロジェクトの Vault 側ノート（`Efforts/<project>/`）をスキャンし、現状を統合表示します。

## Prompt
引数:
- プロジェクト名（必須）: 例 `Receivables-Management`

手順:
1. `Efforts/` 配下（`archived/` を除く）から該当プロジェクトフォルダを特定
2. 可能なら `00-概要.md` を最優先で読み、status/workspace/次の一手を抽出
3. 他のノートを `file.mtime` の新しい順に最大10件読み、要点をまとめる
4. 出力:
   - 現在のstatus
   - 次の一手（Top3）
   - 重要ノート（リンク付き）
   - 未完了タスク（あれば）

注意:
- Workspaces側が正本。Vault側は要点・意思決定ログ・参照の入口に徹する。
