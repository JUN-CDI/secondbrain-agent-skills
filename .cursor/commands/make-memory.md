# Atlasノート作成支援（/make-memory）

## Description
指定ノート（多くは `Calendar/inbox/`）を、`Atlas/` 用に整えて移動します（フラット運用）。MOCリンクも追加します。

## Prompt
引数:
- ファイル名（省略時は現在開いているファイル）

手順:
1. 対象ノートを全文読む
2. 1ノート1テーマに整形し、frontmatter（title/tags/created）を最小で付与
3. ユーザーに確認: 「Atlasに移しますか？」（YES/NO）
4. YESなら `Atlas/` に移動（サブフォルダは作らない）
5. `Atlas/🗺️ Atlas-MOC.md` か該当MOC（`Atlas/_AI-MOC.md` 等）に1リンク追加
6. 変更サマリを出す

関連:
- [[System/prompts/20250113_Memory-Note作成支援]]
