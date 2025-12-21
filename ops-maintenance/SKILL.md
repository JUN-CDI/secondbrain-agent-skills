---
name: ops-maintenance
description: Check official docs/release notes for Claude Code, Codex, Cursor, and Agent Skills; update local workflows and docs when needed.
---

# Ops Maintenance

公式情報を確認して、運用ドキュメントと実装内容を最新化する。

## 手順
1. 現状の前提を読み取る
   - `07_System/Documentation/運用ガイド-全体像.md`
   - `07_System/Documentation/Claude-Code-Skills-Scripts.md`
   - `07_System/Documentation/運用フロー-2つの動線.md`
   - `07_System/Workflows/運用フロー-2本柱.md`

2. 公式情報の確認（ネットワーク許可が必要）
   - Claude Code / Codex / Cursor の公式ドキュメント・リリースノート
   - Agent Skills 仕様（agentskills.io / GitHub）
     - 入口: https://agentskills.io/llms.txt
     - 仕様: https://agentskills.io/specification.md

3. 差分を比較し、更新提案を作成
   - 必須の修正
   - 任意の改善
   - 影響やリスク

4. 承認後にドキュメント/テンプレを更新
   - `07_System/Documentation/*.md`
   - `06_Templates/Projects/*`
   - `.claude/skills/*` / `07_System/Skills/*`

5. 運用更新ログに記録
   - `07_System/Documentation/運用更新ログ.md`
   - 詳細レポート: `07_System/Documentation/Claude-Code-Updates/`

6. Codex Skills を同期（必要時）
```
./07_System/Scripts/sync-codex-skills.sh
```
