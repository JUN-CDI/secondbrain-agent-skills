# Endwork（終了: handoff full + handoff.mdだけcommit）

## Description
セッション終了時に、再開SSOT（repo直下 `handoff.md`）を **Gitにミラー**します。

- `handoff full` を実行（Next必須、Decision/Triedは任意）
- `handoff.md` だけcommit（他ファイルを巻き込まない / stagingを汚さない）

> これは Cursor のチャット欄から呼べる“入口”ですが、実体はツール非依存のターミナルコマンド `endwork` です（Claude Code / Codex でも同じ動作をさせるため）。

## Prompt
対象repoのルートで、次を実行してください（ターミナル）。

```bash
cd <target-repo>
endwork
```

> 推奨: 終了時は `wrapup`（`git add -p` → `endwork`）の方が「再開効果」が高いです。

