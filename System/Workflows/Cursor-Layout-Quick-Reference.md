---
title: Cursorレイアウト - クイックリファレンス
tags: [cursor, quick-reference, cheatsheet]
created: 2025-12-16
type: reference
---

# ⚡ Cursorレイアウト - クイックリファレンス

## 🎯 基本レイアウト

```
Explorer (左) │ Editor (中央) │ Terminal (右)
              │               │ - claude
              │               │ - codex
```

---

## ⌨️ 必須ショートカット

| 操作 | macOS | Windows/Linux |
|------|-------|---------------|
| サイドバー切替 | `Cmd+B` | `Ctrl+B` |
| ターミナル開く | `Cmd+Shift+\`` | `Ctrl+Shift+\`` |
| ターミナル分割 | `Cmd+\` | `Ctrl+\` |
| AIチャット切替 | `Cmd+Shift+A` | `Ctrl+Shift+A` |
| コマンドパレット | `Cmd+Shift+P` | `Ctrl+Shift+P` |

---

## 🚀 3ステップセットアップ

### 1️⃣ Explorer表示
```
Cmd+B → Explorerクリック → ピン留め
```

### 2️⃣ ターミナルを右に
```
ターミナル開く → タイトルバーをドラッグ → 右端にドロップ
```

### 3️⃣ ターミナル分割
```
Cmd+\ で分割 → タブをリネーム (claude/codex)
```

---

## 🤖 自動セットアップ

### Tasks.json使用

```bash
# コマンドパレット (Cmd+Shift+P)
Tasks: Run Task → setup-ai-terminals
```

これで `claude` と `codex` ターミナルが自動起動！

---

## 💡 使い分け

### claude ターミナル
- 💬 AI会話
- 📝 プロンプト実行
- 🎨 コード生成

### codex ターミナル
- 🧪 テスト実行
- 🐛 デバッグ
- 🔧 コマンド実行

---

## 🔧 トラブル解決

### ターミナルが右に移動できない
```
View → Appearance → Panel Position → Right
```

### 分割がうまくいかない
```
全ターミナル閉じる → 新規作成 → Cmd+\ で分割
```

### レイアウトが保存されない
```
Cmd+Q で完全終了 → 再起動 → レイアウト再設定
```

---

## 📚 詳細ガイド

完全な手順は [[Cursor-Layout-Setup-実践手順]]（標準）/ [[Cursor-Layout-Setup-ウルトラワイド版]]（34インチ等）を参照

---

**最終更新:** 2025-12-16

