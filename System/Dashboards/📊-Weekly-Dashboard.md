# 📊 Weekly Dashboard

## 🗓 今週の視点
- 重点テーマ: Cursor動画 / SURVIBE演習 / プロンプト改善
- リスク: スケジュール過密、体力低下

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
