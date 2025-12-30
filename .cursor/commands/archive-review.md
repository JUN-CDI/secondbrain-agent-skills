# アーカイブレビュー（提案のみ）

## Description
`Efforts/archived/` をスキャンして、残す/Atlas化/削除候補の提案をします。

## Prompt
`Efforts/archived/` 配下のMarkdownを俯瞰し、次を提案してください（実行はしない）。

- keep: そのままアーカイブ
- promote: `Atlas/` に昇華（長期で参照）
- delete-candidate: 重複/不要（※削除はユーザー確認必須）

出力形式:
```markdown
| ファイル | 判定 | 理由 | 次アクション |
|---|---|---|---|
```

関連:
- [[System/prompts/20250113_アーカイブレビュー]]
