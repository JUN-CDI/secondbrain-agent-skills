---
name: wrapup
description: End-of-session quality pack: stage intended changes (git add -p) and then run endwork to write full handoff and commit only handoff.md.
---

# wrapup（終了時の品質パック）

目的: セッション終了時に「再開しやすい状態」を作る。

## Instructions
1. ユーザーに「対象repoのルートに移動して `wrapup` を実行」するよう促す。
2. `wrapup` は `git add -p` で差分を確定してから `endwork` を実行する（`handoff.md` だけcommit）。
3. もしコードのcommitが必要なら、`wrapup` 後に通常の `git commit` を行うよう案内する（wrapup自体はコードcommitしない）。

## 例
```bash
cd ~/Workspaces/projects/<repo>
wrapup
```

