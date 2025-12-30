# ダッシュボード作成/更新

## Description
`System/Dashboards/` 配下のダッシュボードを作成・更新します。

## Prompt
引数:
- ダッシュボード名（省略可）:
  - `home` / `🏠` - HOME
  - `projects` / `🎯` - Projects
  - `weekly` / `📊` - Weekly
  - `analytics` / `📈` - Analytics
  - `focus` / `🔥` - Active Focus
  - `all` - 全て

手順:
1. `System/Dashboards/` が無ければ作成
2. 対象ダッシュボードを作成（既存があれば **上書き前に確認**）

### 🏠 HOME（System/Dashboards/🏠-HOME.md）
```markdown
# 🏠 HOME Dashboard

**今日**:: `=date(today)`  
**週番号**:: `=this.week`  
**エネルギー**:: ☀️☀️☀️☀️☀️

## 🎯 今日のTop3
- [ ]
- [ ]
- [ ]

## 🧭 最小運用（迷ったらここ）
- [[System/Documentation/運用ガイド-全体像]]
- [[System/Workflows/運用フロー-2本柱]]
- [[System/Workflows/minimal-weekly]]

## ✅ 進行中タスク
```dataview
TASK
FROM "Calendar" OR "Efforts"
WHERE !completed
SORT priority DESC
```

## 📚 最近の学び
```dataview
LIST file.link
FROM "Atlas"
WHERE file.mtime >= date(today) - dur(2 days)
LIMIT 6
```
```

### 🎯 Projects（System/Dashboards/🎯-Projects-Dashboard.md）
```markdown
# 🎯 Projects Dashboard

## 進行中（Vault側の入口）
```dataview
TABLE status, due, workspace
FROM "Efforts"
WHERE file.name = "00-概要" AND !contains(file.path, "archived/")
SORT status ASC, due ASC
```

## ブロッカー
- （あればここにメモ）

## 次アクション
1. （次の一手）
2. （次の一手）
3. （次の一手）
```

### 📊 Weekly（System/Dashboards/📊-Weekly-Dashboard.md）
```markdown
# 📊 Weekly Dashboard

## 📥 Calendar/inbox
```dataview
TABLE file.ctime as 追加日, length(file.tasks) as Tasks
FROM "Calendar/inbox"
SORT file.ctime DESC
LIMIT 15
```

## 🚀 Projects（Vault側）
```dataview
TABLE status, workspace
FROM "Efforts"
WHERE file.name = "00-概要" AND !contains(file.path, "archived/")
SORT status ASC, file.folder ASC
```

## 🧠 学びログ（7日）
```dataview
LIST
FROM "Atlas"
WHERE file.mtime >= date(today) - dur(7 days)
LIMIT 10
```
```

### 📈 Analytics（System/Dashboards/📈-Analytics-Dashboard.md）
```markdown
# 📈 Analytics Dashboard

```dataview
TABLE trend, notes
FROM "Efforts"
WHERE contains(file.tags, "analytics")
SORT file.mtime DESC
```
```

### 🔥 Active Focus（System/Dashboards/🔥-Active-Focus.md）
```markdown
# 🔥 Active Focus Dashboard

## 集中テーマ
- 
- 
- 
```

関連:
- [[System/Dashboards]]
