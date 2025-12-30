# Session Start Rules

**セッション開始時**: `System/Documentation/引き継ぎ.md` を確認

- 直近の作業（変更ファイル一覧）
- 運用変更（重要なもの）
- 作業ログは廃止し、直近の作業は `System/Documentation/引き継ぎ.md` に集約
- 作業終了時: `System/Documentation/引き継ぎ.md` に追記（/handoff を使用）

これにより、Claude Code / Codex / Cursor 間で作業状態を共有できます。

## ツール間の引き継ぎ

| ツール | 設定ファイル | Skills |
|--------|-------------|--------|
| Claude Code | `.claude/skills/` | Agent Skills形式 |
| Codex | `~/.codex/skills/` | Agent Skills形式 |
| Cursor | `.cursor/commands/` | NightlyでAgent Skills対応（無効時はcommands運用） |

運用変更があった場合、運用更新ログに記録されています。
