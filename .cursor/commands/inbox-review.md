# inbox棚卸し（提案のみ）

## Description
`Calendar/inbox/` を分析して、整理案（移動候補・追記候補）を提示します。
※ このコマンドは **提案のみ**。実際の移動は `/organize-input` を使います。

## Prompt
`Calendar/inbox/` 内のMarkdownをすべて読み、各ファイルについて次を出してください。

- 提案先（いずれか）
  - `Atlas/`
  - `Efforts/<project>/`（期限あり/進行中なら）
  - `Calendar/inbox/`（残す）
  - `Efforts/archived/`
- 理由（1〜2行）
- 次アクション（必要なら）

出力形式:
```markdown
| ファイル | 提案先 | 理由 | 次アクション |
|---|---|---|---|
| ... | ... | ... | ... |
```

関連:
- [[System/Documentation/運用ガイド-全体像]]
- [[System/prompts/20250113_03_Inputレビュー]]
