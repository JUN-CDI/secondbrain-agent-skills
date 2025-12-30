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

覚えるのはこれだけ（最小）:
- **切替/中断**: `handoff quick`（Nextだけ）
- **終了（最小）**: `endwork`（`handoff.md` だけcommit）
- **終了（推奨・品質）**: `wrapup`（`git add -p` → `endwork`）

### 1) 実装（Claude Code）
- **起点はどこでもOK**（Vault直下のHarnessから開始してもよい）。ただし、実装対象の **repo内** で作業すること。
- Repo直下（またはrepo配下の任意ディレクトリ）で `claude` を起動
- ルールは **Repoの `CLAUDE.md`** を正本にする

> メモ: `handoff` / `endwork` は「今いるrepo」を対象に `handoff.md` を更新します。迷ったら `git rev-parse --show-toplevel` で対象repoを確認してから実行してください。

### 2) 差分固定（Git）
- `git-checkpoint`（Skill）または `git add -p` → `git diff --staged`（任意・品質）

### 3) レビュー/提案（Codex）
- Codex（CLI/拡張）でレビュー（または `diff-review`（Skill）でステージ差分をレビュー）（任意・品質）
- 指摘の要点は `docs/HANDOFF.md`（またはコミット前メモ）へ

### 4) 引き継ぎ（ツール横断の状態共有）
ツール横断の再開SSOTは、**対象repo直下の `handoff.md`** に統一します。

- 切替直前/不安時: `handoff quick`（Nextだけ入力すればOK）
- その日の終わり: `endwork`（`handoff full` + `handoff.md` のみcommit）

```bash
cd ~/Workspaces/projects/<repo>
handoff quick --next "cd backend && pytest -q"
endwork
```

補足:
- Harness（Claude CLI）も **引き継ぎは必要**。同一ツール内で完結する前提はない
- 他ツールへ渡す場合も、同じ `handoff` / `endwork` を使う（ターミナルの共通コマンド）

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
- **ツール横断の作業状態（再開SSOT）**: 各repo直下の `handoff.md`
