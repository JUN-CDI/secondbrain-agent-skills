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
