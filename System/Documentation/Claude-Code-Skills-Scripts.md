---
title: Claude Code Skills & Scripts
tags: [system, claude-code, automation]
created: 2025-12-18
---

# Claude Code Skills & Scripts

このドキュメントは、SecondBrain運用のためのClaude Code Skills、ターミナルスクリプト、Hooksを説明します。

## 前提（使い分け）
- Claude Codeのプロジェクトルールは `CLAUDE.md` を正本とする
- `AGENTS.md` はCodex向け（重複運用しない）


---

## Skills（自動発動）

Skillsは特定のキーワードで自動的に発動します。明示的な呼び出しは不要です。

| Skill | トリガー | 機能 |
|-------|---------|------|
| `input-processor` | 「Input整理」「メモ整理」「振り分け」 | Calendar/inboxの自動整理 |
| `project-scaffold` | 「新規プロジェクト」「dev-init」 | 開発プロジェクト初期化 |
| `changelog-watcher` | 「最新機能」「アップデート確認」 | Claude Code更新チェック |
| `handoff` | 「handoff」「引き継ぎ」「ハンズオフ」「はんずおふ」「切替」 | repo直下 `handoff.md` の更新（quick/full/endwork） |
| `dev-handoff` | 「dev-handoff」「作業状況まとめ」「開発引き継ぎサマリ」 | 開発引き継ぎサマリ作成（長め） |
| `git-checkpoint` | 「差分固定」「チェックポイント」「git add -p」 | 差分を小さく固定 |
| `diff-review` | 「差分レビュー」「diff-review」 | ステージ差分（`git diff --staged`）のレビュー |
| `wrapup` | 「wrapup」「終了」「締め」 | 終了時の品質パック（`git add -p` → `endwork`） |
| `ops-maintenance` | 「最新化」「運用更新」「公式確認」 | 公式確認→運用更新→ログ記録 |

### 使用例

```
# input-processor が自動発動
「Calendar/inboxのメモを整理して」

# project-scaffold が自動発動
「新規プロジェクトを作成したい」

# changelog-watcher が自動発動
「Claude Codeの最新機能を教えて」

# dev-handoff が自動発動
「引き継ぎまとめて」

# handoff が自動発動
「handoffして」

# git-checkpoint が自動発動
「差分固定して」

# diff-review が自動発動
「差分レビューして」

# wrapup が自動発動（終了時の品質パック）
「wrapupして」

# ops-maintenance が自動発動
「運用を最新化して」
```

### Skillの場所
```
.claude/skills/
├── input-processor/
│   └── SKILL.md
├── project-scaffold/
│   └── SKILL.md
├── handoff/
│   └── SKILL.md
├── dev-handoff/
│   └── SKILL.md
├── git-checkpoint/
│   └── SKILL.md
├── diff-review/
│   └── SKILL.md
├── wrapup/
│   └── SKILL.md
├── ops-maintenance/
│   └── SKILL.md
└── changelog-watcher/
    └── SKILL.md
```

---

## ツール別の発動（チャット欄の入口）

- **Claude Code（CLI/Harness）**: トリガー語で自動発動（例: 「差分レビューして」「wrapupして」）。見つからない場合は `sync-claude-skills.sh` を実行。
- **Codex（CLI）**: `~/.codex/skills/` に同期されていれば、同名のスキルとして扱える（※挙動はエージェント判断）。見つからない場合は `sync-codex-skills.sh` を実行。
- **Cursor**:
  - Nightly + Agent Skills有効（この環境の標準）: 同様にスキルが使える（Import Settings）。
  - 安定版/無効時: `/wrapup` `/endwork` `/handoff` `/git-checkpoint` `/diff-review`（`.cursor/commands/` のラッパー）を使う。
- **最終フォールバック（全ツール共通）**: ターミナルで `handoff` / `endwork` / `wrapup` を実行（実体はここに集約）。

---

## Agent Skills（Skills中心運用）

**運用方針**: SKILL.md形式を原本として管理し、ツール別に配布する。

| ツール | 対応状況 | 配置場所 |
|--------|----------|----------|
| **Claude Code** | ✅ 対応 | `~/.claude/skills/`（推奨: `sync-claude-skills.sh`）。必要なら repo内 `.claude/skills/` でも可 |
| **Codex CLI** | ✅ 対応（デフォルト有効） | `~/.codex/skills/` |
| **Cursor** | ✅ 対応（Nightly / 要有効化） | Cursor Settings → Rules → Import Settings → Agent Skills |

> Codexは `skills = true` がデフォルト有効。明示的な設定は不要。

- CursorはNightlyチャネルのみ対応（`Cmd+Shift+J` → Beta → Nightly、必要なら再起動）
- スキルはエージェント判断で自動適用（常時/手動ルール化不可）
- Cursor公式Docsでは有効化導線のみ明記（Import Settings）。共有ディレクトリの自動読込は明記されていない
- このVaultはCursor Nightlyを前提に運用（`.cursor/commands/` は安定版フォールバックとして維持）

### 作成時の参照（必須）
- ルールと公式参照: [[AgentSkills-運用案]]
- **skill-creator**: 新規スキル作成用（`~/.claude/skills/skill-creator/`）

### 原本と同期
```
原本: System/Skills/ (SKILL.md形式)
    ↓
Claude Code: sync-claude-skills.sh → ~/.claude/skills/
Codex: sync-codex-skills.sh → ~/.codex/skills/
Cursor: NightlyでAgent Skillsを有効化（Import Settings）
Cursor（安定版/無効時）: .cursor/commands/ に変換
```
- 備考:
  - `skill-template` は同期から除外するのが推奨（作成用テンプレ）
- `skill-creator` は Codex同期では除外（作成用ツール）。Claude Codeでは必要なら同期してOK

## tool-parity（運用保証）

新しいSkill/コマンドを追加したら、ツール横断で「同名で呼べる」ことを必ず確認する。

```bash
bash ./System/Scripts/tool-parity-check.sh
```

### 収録スキル
- `git-checkpoint`（`git add -p` → `git diff --staged`）
- `diff-review`（ステージ差分のレビュー）
- `data-safety`（CSV/XLSX混入防止）
- `skill-creator`（公式の新規スキル作成ガイド）

---

## ターミナルスクリプト

シェルから直接実行できる自動化スクリプトです。

### 1. weekly-organize.sh（週次整理）

```bash
# 標準実行
./System/Scripts/weekly-organize.sh

# ドライラン（実際には移動しない）
./System/Scripts/weekly-organize.sh --dry-run
```

**機能:**
- Calendar/inboxのファイル数確認
- Claude Codeで自動整理実行
- ログファイル出力

**crontab設定（日曜夜21時に自動実行）:**
```cron
0 21 * * 0 ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/SecondBrain/System/Scripts/weekly-organize.sh
```

### 2. dev-init.sh（プロジェクト初期化）

```bash
# 汎用プロジェクト
./System/Scripts/dev-init.sh my-project

# Node.jsプロジェクト
./System/Scripts/dev-init.sh my-project node

# Python + GitHub連携
./System/Scripts/dev-init.sh my-project python --github

# テスト/一時用途（Gitなし）
./System/Scripts/dev-init.sh my-project --no-git
```

**機能:**
- ~/Workspaces/projects/ にフォルダ作成
- CLAUDE.md, AGENTS.md, README.md, .gitignore 生成
- Git初期化（対話時は確認あり。`--no-git` で無効化可能）
- GitHub リポジトリ作成（オプション）

### 3. check-updates.sh（更新チェック）

```bash
# 更新確認（画面出力のみ）
./System/Scripts/check-updates.sh

# レポートをファイル保存
./System/Scripts/check-updates.sh --save
```

**機能:**
- Claude Codeの最新機能確認
- 運用フローへの影響分析
- 推奨アクション提案

**保存先:**
- 詳細レポート: `System/Documentation/Claude-Code-Updates/`
- 要約ログ: `System/Documentation/運用更新ログ.md`

**推奨:** 月1回実行

### 4. sync-codex-skills.sh（Codex Skills同期）

```bash
# Vault側を原本として同期
./System/Scripts/sync-codex-skills.sh

# 初回セットアップ（System/Skills が無い場合）
# - Networkあり: 原本repoをcloneしてから同期
./System/Scripts/sync-codex-skills.sh --clone
#
# - Offline: 既存の ~/.codex/skills から原本を復元して同期
./System/Scripts/sync-codex-skills.sh --from-codex
```

**機能:**
- `System/Skills/` → `~/.codex/skills/` へ同期
- CodexのSkillを最新化

### 5. handoff / endwork（再開SSOT: repoの handoff.md）

```bash
# 1) 初回だけインストール（~/.handoff/bin に配置）
bash ./System/Scripts/install-handoff.sh

# 2) 使い方（対象repoで実行）
cd ~/Workspaces/projects/<repo>
handoff            # デフォルト: quick（Nextだけ入力）
endwork            # full + handoff.mdのみcommit（pushはしない）
```

**用途:**
- ツール切替後に迷わず再開するための **再開SSOT** を残す
- SSOTは **各repo直下の `handoff.md`**（ツール非依存）

> 旧方式の `handoff-add.sh`（Vaultの引き継ぎ.md追記）は廃止しました（参照専用）。

---

## Hooks（自動実行）

Claude Code操作時に自動実行されるアクションです。Hooksはユーザー定義のシェルコマンドで、Claude Codeのライフサイクル各ポイントで決定的な制御を提供します。

### 利用可能なHookイベント（10種類）

| イベント | 説明 | 用途例 |
|---------|------|--------|
| `PreToolUse` | ツール実行前（ブロック可能） | 機密ファイル保護、コマンド検証 |
| `PostToolUse` | ツール実行後 | 自動フォーマット、ログ記録 |
| `PermissionRequest` | 権限ダイアログ表示時 | 自動承認/拒否ルール |
| `UserPromptSubmit` | ユーザープロンプト送信時 | 入力検証、ログ記録 |
| `Notification` | 通知イベント | デスクトップ通知カスタマイズ |
| `Stop` | Claude Code応答完了時 | 完了通知、後処理 |
| `SubagentStop` | サブエージェント完了時 | サブタスク完了処理 |
| `PreCompact` | コンパクト処理前 | コンテキスト管理 |
| `SessionStart` | セッション開始/再開時 | 初期化処理、リマインド |
| `SessionEnd` | セッション終了時 | クリーンアップ、ログ保存 |

### 設定済みHooks（この環境）

| イベント | 動作 |
|---------|------|
| `SessionStart` | セッション開始ログ + ops-maintenance月次リマインド + SSOT（D/P/G）ダイジェスト表示 |
| `PostToolUse` (Write/Edit) | ファイル変更をログ記録 |

### MEM（観測→昇格）の置き場（SSOT）

- 意思決定（decision）: `Atlas/意思決定.md`（D01...）
- パターン（bugfix/pattern）: `Atlas/パターン.md`（P01...）
- ガードレール（guard）: `Atlas/ガードレール.md`（G01...）
- セッション開始時の自動表示: `System/Scripts/session-init-mem.sh`（`.claude/settings.local.json` の SessionStart から実行）

### ツール間引き継ぎの仕組み

全ツール共通で「対象repo直下の `handoff.md`」をSSOTとし、ターミナルの共通コマンドで更新する。

| ツール | 設定場所 | 確認タイミング |
|--------|----------|----------------|
| Claude Code | ルール/スキル | repo作業開始時に `handoff.md` を確認し、必要なら `handoff` / `endwork` |
| Codex | AGENTS.md | 同上 |
| Cursor | `.cursor/rules/session-start.md` | 同上（NightlyはAgent Skillsで補助） |

**共通SSOT**: `handoff.md`（各repo直下）

### Hook設定例

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {
            "type": "command",
            "command": "jq -r '.tool_input.command' >> ~/.claude/bash-log.txt"
          }
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Edit|Write",
        "hooks": [
          {
            "type": "command",
            "command": "npx prettier --write \"$(jq -r '.tool_input.file_path')\""
          }
        ]
      }
    ]
  }
}
```

### ログファイル

```
~/.claude/session.log       # セッション履歴
~/.claude/file-changes.log  # ファイル変更履歴
```

### 設定ファイル

`.claude/settings.local.json`

### Hooks詳細ガイド
- 公式ドキュメント: https://code.claude.com/docs/en/hooks-guide

---

## クイックリファレンス

### 日常使い

| やりたいこと | 方法 |
|-------------|------|
| メモ整理 | 「Input整理して」（Skill自動発動） |
| 新規プロジェクト | 「新規プロジェクト作りたい」または `./dev-init.sh` |
| 更新確認 | 「Claude Codeの最新機能教えて」 |
| 引き継ぎ作成 | 「引き継ぎまとめて」 |
| 差分固定 | 「差分固定して」 |
| 運用の最新化 | 「運用を最新化して」 |

### ターミナルから直接

```bash
# Vaultディレクトリに移動
cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/SecondBrain

# 週次整理
./System/Scripts/weekly-organize.sh

# 新規プロジェクト
./System/Scripts/dev-init.sh my-app node --github

# 更新チェック
./System/Scripts/check-updates.sh --save

# Codex Skills 同期
./System/Scripts/sync-codex-skills.sh
```

### Claude Code CLIオプション

```bash
# 非対話型実行
claude -p "Calendar/inboxを整理して"

# 出力をJSON形式で
claude -p "分析して" --output-format json

# ターン数制限
claude -p "簡潔に" --max-turns 3

# セッション継続
claude --continue "続き"
```

---

## コマンド早見表（主要8個）

| コマンド | 用途 | 頻度 |
|---------|------|------|
| `/organize-input` | inbox振り分け（移動まで実行） | 週1 |
| `/inbox-review` | inbox分析（提案のみ） | 週1 |
| `/dev-init` | 開発フォルダ作成（ローカル） | 随時 |
| `/project-init` | プロジェクトノート作成（Vault） | 随時 |
| `/make-memory` | Input→Memory昇華 | 随時 |
| `/optimize-tag-links` | タグ・リンク最適化 | 随時 |
| `/research` | テーマ調査 | 随時 |
| `/self-analysis` | 自己分析会議 | 月1 |

詳細: [[.cursor/commands/README]]

---

## プロンプト早見表

| カテゴリ | 主なプロンプト | 用途 |
|---------|--------------|------|
| 01_整理系 | inbox整形、inbox整理 | メモ整理 |
| 02_生成系 | 開発プロンプト | コンテンツ生成 |
| 03_レビュー系 | 品質チェック、アーカイブレビュー | 振り返り |
| 04_学習系 | 技術調査 | 知識収集 |
| 05_改善系 | コマンド改善、フォルダ管理 | システム改善 |
| 06_一括作業系 | 全量作業、承認不要処理 | バッチ処理 |

詳細: [[System/prompts/README]]

---

## 関連ドキュメント

- [[System/Documentation/運用ガイド-全体像]] - システム全体像
- [[System/Documentation/運用フロー-2つの動線]] - 運用フロー全体
- [[.cursor/commands/README]] - Cursorコマンド一覧
- [[System/prompts/README]] - プロンプト集
