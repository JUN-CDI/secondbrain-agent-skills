# Cursor Commands for Obsidian Vault

このフォルダには、Obsidian Vault管理用のCursor AIコマンドが含まれています。

## 📖 使い方

### コマンドの実行方法

#### 方法1: Cursor Chat (Cmd/Ctrl + L)
チャットを開いて、`/コマンド名` を入力します。

#### 方法2: インライン (Cmd/Ctrl + K)
インライン編集で `/コマンド名` を入力します。

#### 方法3: コンポーザー (Cmd/Ctrl + I)
コンポーザーで `/コマンド名` を入力します。

---

## 🛠️ 利用可能なコマンド（主に使う）

### /inbox-review
**説明**: `Calendar/inbox/` を分析して整理案を提示（提案のみ）

### /organize-input
**説明**: `Calendar/inbox/` を整理して `Atlas/` / `Efforts/` へ振り分け（移動まで実行）

### /make-memory [ファイル名]
**説明**: 指定ノートを `Atlas/` 用に整えて移動（MOCリンクも追加）

### /project-init [プロジェクト名] [planning|active]
**説明**: Vault側入口 `Efforts/<project>/00-概要.md` を作成

### /dev-init [プロジェクト名] [タイプ] [--github]
**説明**: ローカル（`~/Workspaces/projects/`）に開発フォルダを作成（`System/Scripts/dev-init.sh` を実行）

### /handoff
**説明**: 引き継ぎログを更新

---

## 🔄 よく使う組み合わせ

### 週次のルーティン
```
1. /organize-input
2. /create-dashboards weekly（任意）
3. /find-unlinked-notes（任意）
4. /archive（必要に応じて）
```

---

## 📚 関連リソース

- **プロンプト集**: [[System/prompts/README]]
- **Brain System Rules**: [[AGENTS]]
- **運用の入口**: [[System/Documentation/運用ガイド-全体像]]

詳細は各コマンドファイル（`.md`）を参照してください。
