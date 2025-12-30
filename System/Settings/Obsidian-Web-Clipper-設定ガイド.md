---
title: Obsidian Web Clipper 設定ガイド
tags: [obsidian, web-clipper, settings, workflow]
created: 2025-12-16
type: settings
---

# 📎 Obsidian Web Clipper 設定ガイド

**目的:** AGENTS.mdのルールに基づいたWeb Clipperの設定

---

## 🎯 推奨設定

### 基本設定

| 項目 | 推奨値 | 理由 |
|------|--------|------|
| **ノートの場所** | `Calendar/inbox` | 何でも放り込む場所（入口） |
| **ノート名** | `{{title}}` | ページタイトルをそのまま使用 |
| **保管庫** | 最後に使用 | または、Obsidian Vaultを指定 |

---

## 📋 詳細設定

### テンプレート名
```
Default
```

### 動作
```
新規ノートを作成
```

### ノート名
```
{{title}}
```

**説明:** ページタイトルをそのままファイル名にします。後でCursorコマンド（`/organize-input`）で振り分けできます。

---

### ノートの場所
```
Calendar/inbox
```

**理由:**
- ✅ **摩擦ゼロ**: 5秒以内にクリップできる
- ✅ **整理不要**: 後でCursorで処理
- ✅ **AGENTS.mdの原則**: 「完璧主義を捨てる」「とりあえずCalendar/inboxに放り込む」

**注意:** まずは `Calendar/inbox` に保存される設定がおすすめです。

---

### 保管庫
```
最後に使用
```

または、Obsidian Vaultを明示的に指定してください。

---

### プロパティ

**推奨設定:**

| プロパティ名 | 値 | 説明 |
|------------|-----|------|
| `title` | `{{title}}` | ページタイトル |
| `source` | `{{url}}` | 元のURL |
| `author` | `{{author\|split:", "\|wikilink\|join}}` | 著者（複数の場合も対応） |
| `published` | `{{published}}` | 公開日 |
| `created` | `{{date}}` | クリップ日時 |
| `description` | `{{description}}` | ページの説明 |
| `tags` | `clippings` | 固定タグ（後で整理時に変更可能） |

**現在の設定で問題ありません。** このまま使用できます。

---

### ノートの内容

```
{{content}}
```

**説明:** ページの本文をそのまま挿入します。

---

## 🔄 ワークフロー

### 1. クリップ時（自動）

1. **Webページをクリップ**
   - `Cmd+Shift+O` (Mac) / `Alt+Shift+O` (Windows)
   - または: 右クリック → `Obsidian Web Clipper` → `Save this page`

2. **自動的に保存**
   - `Calendar/inbox/{{title}}.md` に保存される
   - プロパティが自動的に追加される

---

### 2. 整理時（週1回）

1. **Cursorコマンドで整理**
   ```bash
   /organize-input [ファイル名]
   ```
   - `Calendar/inbox` から適切なフォルダへ振り分け
   - タグ・リンク・ファイル名を整理

2. **週次レビューで振り分け**
   ```bash
   /organize-input
   ```
   - `Calendar/inbox` から適切なフォルダに振り分け
   - `Calendar/inbox` / `Atlas` / `Efforts` など

---

## 📝 設定の変更手順

### 現在の設定を変更する場合

1. **Obsidian Web Clipperの設定を開く**
   - Chrome拡張機能のアイコンをクリック
   - 設定（⚙️）を開く

2. **テンプレートを編集**
   - 「テンプレート」タブを選択
   - 「Default」テンプレートを選択

3. **「ノートの場所」を変更**
   - `Calendar/inbox` に変更

4. **保存**
   - 設定を保存

---

## ✅ 確認ポイント

### 設定後の確認

- [ ] ノートの場所が `Calendar/inbox` になっている（iPhoneでも見える場所）
- [ ] ノート名が `{{title}}` になっている
- [ ] プロパティが適切に設定されている
- [ ] 実際にクリップして動作確認

---

## 💡 使い方のコツ

### クリップ時の注意

- ✅ **完璧主義を捨てる**: とりあえずクリップする
- ✅ **整理は後で**: Cursorコマンドで一括処理
- ✅ **ファイル名は自動**: `{{title}}` で問題なし

### 整理のタイミング

- **週1回**: `/organize-input` を1回回して整理
- **理想は3日以内**: 新鮮なうちに `Calendar/inbox` へ

---

## 🔗 関連ドキュメント

- [[AGENTS]] - Brain System Rules
- [[.cursor/commands/README]] - Cursorコマンド一覧
- [[System/Workflows/weekly-workflow]] - 週次ワークフロー

---

**作成日:** 2025-12-16  
**バージョン:** 1.0
