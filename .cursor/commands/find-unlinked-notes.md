# 孤立ノート検出（Atlas中心）

## Description
`Atlas/` 内のノートがMOCからリンクされているかを確認し、リンク追加候補を提示します。

## Prompt
次の方針で進めてください。

1. `Atlas/` 内のMarkdownを列挙（MOC系: `🗺️ Atlas-MOC.md`, `_*-MOC.md` は除外）
2. MOCファイル（`Atlas/🗺️ Atlas-MOC.md` と `_*-MOC.md`）を読み、リンク済みノート名を抽出
3. 「MOC未リンク」ノートを一覧化し、どのMOCに入れるべきか提案

出力形式:
```markdown
## MOC未リンク（候補）
- [[note-name]] → 追加先候補: [[Atlas/_AI-MOC]]
```
