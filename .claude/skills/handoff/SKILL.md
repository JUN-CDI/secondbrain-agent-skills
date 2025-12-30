---
name: handoff
description: Update repo-root handoff.md (resume SSOT) before switching tools. Default is quick (Next-only). Use endwork at session end.
allowed-tools: Read, Write, Bash(git:*), Bash(cd:*)
---

# Handoff（再開SSOT: handoff.md）

目的: ツール切替後に迷わず再開できるよう、対象repo直下の `handoff.md` を更新する。

## 使い分け
- 切替直前 / 不安時: `handoff`（デフォルト quick）
- その日の終わり: `endwork`（full + `handoff.md` のみcommit）

## 手順（最短）
1) 対象repoへ移動（不明ならrepoパスを確認する）
2) quickの場合、**Nextだけ**1行で入力する
   - Next = 再開した瞬間に最初にやる1アクション（具体的なコマンド/ファイル/確認点）
3) 以下のコマンドを実行する

```bash
handoff quick --next "<Next>"
```

## 終了（full）
```bash
endwork
```

## 注意
- `docs/HANDOFF.md` は任意（長文の補助）。再開SSOTは `handoff.md` のみ。
