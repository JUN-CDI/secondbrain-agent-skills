# MTG議事録作成

## Description
当日の `Calendar/` 配下に会議メモを作成します。

## Prompt
MTG議事録を作成してください。

引数:
- 議題: MTGのテーマ（ユーザーが指定）

要件:
- ファイル名: `Calendar/YYYY/YYYY-MM/YYYY-MM-DD/YYYY-MM-DD-打ち合わせ-[議題].md`（今日の日付を使用）
- MTGテンプレートを適用
- `#meeting` タグを追加
- 可能なら、同日のDaily（`YYYY-MM-DD-Daily.md`）の「🤝 Meetings」にリンクを1行追記

テンプレート:
```markdown
---
tags: [meeting]
created: YYYY-MM-DD
---

# YYYY-MM-DD-打ち合わせ-[議題]

## 参加者
- 

## 決定事項
- 

## 気づき
- 

## 宿題
- [ ] 

#meeting
```

手順:
1. 今日の日付を取得
2. `Calendar/YYYY/YYYY-MM/YYYY-MM-DD/` フォルダを作成（存在しない場合）
3. 上記テンプレートで会議ノートを作成
4. （任意）同日のDailyにリンク追記

使用例:
- `/mtg クライアントABC-定例`
