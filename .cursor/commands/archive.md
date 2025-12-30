# アーカイブ移動（Efforts/archived）

## Description
指定ファイルを `Efforts/archived/` に退避します（削除ではなく“保管”）。

## Prompt
引数:
- ファイル名（省略時は現在開いているファイル）

要件:
1. 現在日付から `YYYY-MM` を取得
2. `Efforts/archived/YYYY-MM/` フォルダを作成（存在しない場合）
3. 対象ファイルを `mv` で移動
4. 移動理由を1行で残す（移動先ファイルの先頭 or 末尾でOK）

注意事項:
- Vault内の運用は「捨てずに退避」が基本（検索できればOK）

関連:
- [[System/Documentation/運用ガイド-全体像]]
