---
title: コンテンツアイデア生成（最小）
tags: [cursor, command, content]
created: 2025-12-25
---

# コンテンツアイデア生成（最小）

## Description
フォルダを増やさず、**1ファイルにまとめて**コンテンツアイデアを出します（MOC寄せの思想に合わせる）。

- 出力先（おすすめ）: `Calendar/inbox/YYYY-MM-DD-コンテンツアイデア.md`
- 企画が固まったら: `Efforts/<project>/` を作って `00-概要.md` に落とす

## Prompt
次を守って、コンテンツアイデアを作成してください。

### 前提
- VaultはACE最小構成（`Atlas/` / `Calendar/` / `Efforts/` / `System/`）
- `Atlas/` はフラット（サブフォルダを作らない）
- 企画/運用の正本は `Workspaces`、Vault側は「要点・参照・意思決定ログ」

### 1) 参照するノート（最小）
必ず読んでください：
- `Atlas/00-note戦略.md`
- `Atlas/文章スタイルガイド.md`

余裕があれば確認：
- `Calendar/inbox/` の直近メモ（最新5〜10件）
- `Efforts/*/00-概要.md`（`archived/` は除外、現状の文脈合わせ）

### 2) 出力ファイル
新規に `Calendar/inbox/YYYY-MM-DD-コンテンツアイデア.md` を作成し、以下の形式で出力してください。

```markdown
---
title: YYYY-MM-DD-コンテンツアイデア
tags: [content, ideas]
created: YYYY-MM-DD
---

# YYYY-MM-DD-コンテンツアイデア

## 共通テーマ（今週/今月の軸）
- ...

## note（長文）
- タイトル案:
- 一行フック:
- 3つの論点:
- 参照リンク:

## YouTube（動画）
- 企画:
- 冒頭10秒:
- 章立て:
- 参照リンク:

## X（短文/スレッド）
- 1ツイート案 ×3:
- スレッド案 ×2:

## 次の一手（Top3）
1. ...
2. ...
3. ...
```

### 3) 仕上げ（最小）
- 必要なら `Atlas/🗺️ Atlas-MOC.md` または該当MOC（`Atlas/_Business-MOC.md` など）へリンク候補を1つ提示
- 企画が「期限あり」で走りそうなら、`/project-init <project> active` を提案
