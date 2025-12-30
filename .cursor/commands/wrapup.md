# Wrapup（終了時の品質パック）

## Description
作業終了時に「再開しやすい状態」を作ります。

- `git add -p` で差分を確定（レビュー/コミットしたい範囲だけステージ）
- `endwork` を実行（`handoff full` + `handoff.md` だけcommit）

> 補足: `wrapup` 自体は **コードのcommitはしません**（必要なら通常の `git commit` を別途実行）。
>
> これは Cursor のチャット欄から呼べる“入口”ですが、実体はツール非依存のターミナルコマンド `wrapup` です（Claude Code / Codex でも同じ動作をさせるため）。
> `git add -p` は対話が必要なので、実行はターミナルで行います（Cursorの統合ターミナルでOK）。

## Prompt
次を実行してください（ターミナル）。

1) 対象repoのルートへ移動
2) `wrapup` を実行
3) `git add -p` の対話でステージする差分を選ぶ
4) `handoff full` の入力では **Next（必須）** を具体的に入れる

```bash
cd <target-repo>
wrapup
```

### チェックポイントを飛ばす（`git add -p` なし）
```bash
wrapup --no-checkpoint
```

### コマンドが無い場合（1回だけ）
```bash
cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/SecondBrain
bash ./System/Scripts/install-handoff.sh
```

