---
title: Claude Code Harness-運用
tags: [system, workflow, claude-code]
created: 2025-12-22
---

# Claude Code Harness-運用（このVault向け）

## 結論（この環境での位置づけ）
- **基本運用は維持**: 「Claude Codeで実装」→「Codexでレビュー/提案」→（必要時だけ）Cursor
- **Harnessは“追加の管理レイヤー”**: Claude CLI（`claude`）内で、タスク管理（`Plans.md`）や運用の型を回しやすくするために使う
- **モードはSolo推奨**（このVaultの方針と整合）

> Cursorを“メインAI”にしなくても、Harnessは **Claude Code側** なのでコスト設計（Claude/Codex優先）と矛盾しません。

---

## どこで使う？

### Vault（SecondBrain）
- 目的: 運用タスク（整理、更新、引き継ぎ、スクリプト実行補助）を **Claude側** で回す
- 入口: Vault直下で `claude` を起動

### 開発Repo（Workspaces/projects）
- 原則: 既存の `dev-init` / `CLAUDE.md` / `AGENTS.md` / `docs/HANDOFF.md` を正本にする
- Harnessは「どうしても欲しい機能がある場合だけ」導入（ファイル生成が増えるため）

---

## 最短ループ（推奨ワークフロー）

### 1) 実装（Claude Code）
- Repo直下で `claude` を起動
- ルールは **Repoの `CLAUDE.md`** を正本にする

### 2) 差分固定（Git）
- `git add -p` → `git diff --staged`

### 3) レビュー/提案（Codex）
- Codex（CLI/拡張）でレビュー
- 指摘の要点は `docs/HANDOFF.md`（またはコミット前メモ）へ

### 4) 引き継ぎ（ツール横断の状態共有）
共通の作業状態は **Vaultの `System/Documentation/引き継ぎ.md`** に集約します。

- Claude Code: Hooksでファイル変更が自動追記される（`.claude/settings.local.json`）
- Codex/拡張/外部ターミナル: `handoff-add.sh` で1行追記（Cursor AIを使わずに済む）

```bash
cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/SecondBrain
./System/Scripts/handoff-add.sh "~/Workspaces/projects/<repo>" "Codexレビュー完了（指摘はdocs/HANDOFF.mdへ）"
```

補足:
- Harness（Claude CLI）も **引き継ぎは必要**。同一ツール内で完結する前提はない
- 他ツールへ渡す場合は `handoff-add.sh` を最優先（ツール非依存で確実）

---

## Harness（Claude CLI）側のタスク管理

- **`Plans.md`**: タスクの入口（Vault直下）
- Claude CLI内で `Plans.md` を回す（コマンドはHarnessの仕様に従う）

> 注意: Harnessの初期化（`/harness-init`）は、既存の `AGENTS.md` / `CLAUDE.md` がある環境では“上書き/重複”に注意。

---

## 併用時の“正本”ルール（迷い防止）

- **開発Repoの実装ルール**: Repoの `CLAUDE.md`
- **開発Repoのレビュー観点**: Repoの `AGENTS.md`（Codex向け）
- **Skillsの原本**: Vaultの `System/Skills/`
  - Codexへ同期: `./System/Scripts/sync-codex-skills.sh` → `~/.codex/skills/`
- **ツール横断の作業状態**: Vaultの `System/Documentation/引き継ぎ.md`
