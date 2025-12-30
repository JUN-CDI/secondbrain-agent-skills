# Session Start Rules

**セッション開始時**:

- 対象repoを開いたら、まず repo直下の `handoff.md` を確認（再開SSOT）
- ツール切替/不安時は `handoff quick`、終わるときは `endwork`

> 旧方式（Vaultの `System/Documentation/引き継ぎ.md`）は廃止しました。

## MEM（観測→昇格）運用（SSOT）

- 永続化するものは Atlas のSSOTへ昇格: `Atlas/意思決定.md` / `Atlas/パターン.md` / `Atlas/ガードレール.md`
- Claude Codeはセッション開始時にSSOTの最新項目を自動表示（`.claude/settings.local.json` → `System/Scripts/session-init-mem.sh`）

## ツール間の引き継ぎ

| ツール | 設定ファイル | Skills |
|--------|-------------|--------|
| Claude Code | `.claude/skills/` | Agent Skills形式 |
| Codex | `~/.codex/skills/` | Agent Skills形式 |
| Cursor | `.cursor/commands/` | NightlyでAgent Skills対応（無効時はcommands運用） |

運用変更があった場合、運用更新ログに記録されています。
