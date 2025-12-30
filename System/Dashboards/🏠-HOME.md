# 🏠 HOME Dashboard

**今日**:: `=date(today)`  
**週番号**:: `=this.week`  
**エネルギー**:: ☀️☀️☀️☀️☀️

## 🎯 今日のTop3
- [ ] ディープワーク: コンテンツ制作
- [ ] SURVIBE AI講座の仕込み
- [ ] 家族/メンテ作業


## 🧭 最小運用（迷ったらここ）
- [[System/Documentation/運用ガイド-全体像]]
- [[System/Workflows/運用フロー-2本柱]]
- [[System/Workflows/minimal-weekly]]
- [[System/prompts/00_最小運用-回し方]]
- [[System/Documentation/運用更新ログ]]
- [[System/Documentation/引き継ぎ-経過保存-トリガー]]

## ✅ 進行中タスク
```dataview
TASK
FROM "Calendar" OR "Efforts"
WHERE !completed
SORT priority DESC
```

## 📚 最近の学び
```dataview
LIST file.link + " – " + choice(summary, summary, "メモなし")
FROM "Atlas"
WHERE file.mtime >= date(today) - dur(2 days)
LIMIT 6
```

## 💧 エネルギーチェック
- 睡眠 : [ ] 7h以上
- 運動 : [ ] 有酸素または筋トレ
- 栄養 : [ ] 朝食/昼食/夕食
