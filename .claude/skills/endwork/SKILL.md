---
name: endwork
description: End a session by writing a full handoff entry and committing only handoff.md (no other files, index preserved).
allowed-tools: Read, Bash(git:*)
---

# endwork（終了: handoff full + handoff.mdだけcommit）

目的: セッション終了時に、再開SSOT（repo直下 `handoff.md`）を Git にミラーする（他ファイルは巻き込まない）。

## Instructions
1. 対象repoのルートで `endwork` を実行するよう案内する。
2. `endwork` が無い場合は、先に `install-handoff.sh` を実行してPATHに入れるよう案内する。
3. `endwork` 自体は push しないため、`push済み` と書くのは `git push` 成功後のみであることを伝える。
4. CLI で `--next` を渡す場合はバッククォートを使わない（必要なら単一引用符か対話入力）。

## 例
```bash
cd ~/Workspaces/projects/<repo>
endwork
```
