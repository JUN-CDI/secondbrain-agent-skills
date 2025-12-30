---
title: AgentSkills-運用案
tags: [system, workflow, codex, cursor]
created: 2025-12-19
---

# AgentSkills-運用案

## 目的
- Agent Skillsの仕様に沿って「再利用できる手順」を整理し、**複数ツール間で共有**する運用を作る
- 差分レビュー/データ混入防止/チェックポイント（`git add -p`）を標準化する

## 対応状況（2025年12月更新）

| ツール | 対応状況 | 配置場所 |
|--------|----------|----------|
| **Claude Code** | ✅ 対応 | `.claude/skills/` |
| **Codex CLI** | ✅ 対応（デフォルト有効） | `~/.codex/skills/` |
| **Cursor** | ✅ 対応（Nightly / 要有効化） | Cursor Settings → Rules → Import Settings → Agent Skills |

> Codexは `skills = true` がデフォルト有効になったため、明示的な設定は不要。

## 確認結果（agentskills/agentskills）
- **仕様・ドキュメント・参照SDK**のみ（サンプルスキルは含まれない）
- スキルは `skill-name/` 配下に `SKILL.md` を置く形式
- `name` は **小文字+ハイフンのみ**、フォルダ名と一致が必須
- `SKILL.md` は「短く・必要なら `references/` へ分割」が推奨

## 公式参照（作成時は必ず確認）
- https://agentskills.io/llms.txt（全体の入口）
- https://agentskills.io/specification.md（仕様）
- https://agentskills.io/what-are-skills.md（概念）
- https://agentskills.io/integrate-skills.md（統合ガイド）
- https://github.com/agentskills/agentskills（公式リポジトリ）

## 作成時の必須ルール（この運用）
1. **構造**
   - `skill-name/SKILL.md` が必須
   - 追加は `scripts/`, `references/`, `assets/` のみ（深い階層は避ける）
2. **SKILL.md frontmatter**
   - 必須: `name`, `description`
   - `name` 制約: 1-64文字 / 小文字英数字+ハイフン / 先頭末尾ハイフン不可 / `--` 不可 / フォルダ名一致
   - `description` 制約: 1-1024文字 / 何をするか+いつ使うかを明記
3. **本文の長さ**
   - 500行以下を推奨（長い内容は `references/` へ分割）
4. **参照ファイル**
   - 参照は skill ルートからの相対パス
   - 参照は1階層で止める（深い参照チェーンは避ける）
5. **任意フィールド**
   - `license`, `compatibility`, `metadata`, `allowed-tools`（必要なときのみ）
6. **検証**
   - `skills-ref validate <skill-dir>` を必要に応じて実行

## 方針（この環境の最適解）
1. **スキルの原本はVaultに置く**（編集しやすさ優先）
2. **Codex用は `~/.codex/skills` に同期**
3. **Cursor用はNightlyでAgent Skillsを有効化。安定版/無効時は `.cursor/commands/` に変換して配布**

## 推奨ディレクトリ（Vault側の原本）
```
System/Skills/
├── git-checkpoint/
│   └── SKILL.md
├── diff-review/
│   └── SKILL.md
└── data-safety/
    └── SKILL.md
└── skill-template/
    └── SKILL.md
```

> `skill-template` は作成用テンプレ。Codex同期の対象外。

### スキル内容
1. **git-checkpoint**
   - `git add -p` → `git diff --staged` で差分を確定する
2. **diff-review**
   - `git diff --staged` を前提にレビュー指示を出す
3. **data-safety**
   - `samples/` / `deliverables/` / `*.csv` / `*.xlsx` をコミットしない
4. **ops-maintenance**
   - 公式情報を確認して運用ドキュメント/テンプレを更新する
   - 記録先: `System/Documentation/運用更新ログ.md`
5. **skill-creator**（公式）
   - 新規スキル作成用ガイド（Anthropic公式）
   - `scripts/init_skill.py` で雛形生成
   - Codex同期対象外（作成用ツール）

## Codexへの落とし方（同期）
**選択肢A: 手動コピー（最小）**
```
cp -R System/Skills/git-checkpoint ~/.codex/skills/
cp -R System/Skills/diff-review ~/.codex/skills/
cp -R System/Skills/data-safety ~/.codex/skills/
```

**選択肢B: 同期スクリプト**
- `./System/Scripts/sync-codex-skills.sh` で同期（実装済み）
- 変更時はこのスクリプトだけ回す

## Cursorへの落とし方

### Nightly（Agent Skills）
1. Cursor Settings（`Cmd+Shift+J`）→ Beta → 更新チャネルを Nightly に設定（必要なら再起動）
2. Cursor Settings → Rules → Import Settings → Agent Skills をON
3. スキルは `SKILL.md` 形式。リポジトリで管理し、GitHub リポジトリリンク経由で導入可能
4. スキルはエージェント判断で自動適用（常時/手動ルール化不可）

### 安定版/無効時（フォールバック）
Vault側の `SKILL.md` をベースに、以下の2コマンドを標準配布:
```
.cursor/commands/codex-review.md
.cursor/commands/git-checkpoint.md
```

> CursorはNightlyでAgent Skills対応。安定版は**コマンド化**が最短。

## 既存Repoへの適用（チェックリスト）
- `.cursor/rules/ai-workflow.md` を追加（運用ルール）
- `.cursor/commands/codex-review.md` を追加（差分レビュー）
- `.cursor/commands/git-checkpoint.md` を追加（差分の固定）
- `.gitignore` に `/samples/*` を追加（データ混入防止）
- `samples/.gitkeep` を追加（フォルダ維持）

## 補足（検証ツール）
`skills-ref` は参照実装（デモ用途）。必要なら以下で検証:
```
skills-ref validate <skill-dir>
skills-ref to-prompt <skill-dir>...
```
