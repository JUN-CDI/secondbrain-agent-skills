# Cursor Commands for Obsidian Vault

このフォルダには、Obsidian Vault管理用のCursor AIコマンドが含まれています。

> 現行は **Cursor Nightly + Agent Skills** が主運用。ここは安定版/無効時のフォールバックとして維持します。

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
**説明**: 再開SSOT（repo直下 `handoff.md`）を更新する手順を案内（実体はターミナルの `handoff` / `endwork`）

### /tool-parity
**説明**: 新しいSkill/コマンドがツール横断で同名で呼べる状態かチェック（`tool-parity-check.sh`）

### /wrapup
**説明**: 終了時の品質パック（`git add -p` → `endwork`）。再開効果を最大化したい時に使う

### /endwork
**説明**: 終了（`handoff full` + `handoff.md` だけcommit）。stagingを汚さず再開SSOTだけ残す

### /git-checkpoint
**説明**: 差分固定（`git add -p` → `git diff --staged`）。レビュー対象を確定したい時に使う

### /diff-review
**説明**: ステージ差分レビュー（`git diff --staged` 前提）。P0/P1/P2で短く具体的にレビューする

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
