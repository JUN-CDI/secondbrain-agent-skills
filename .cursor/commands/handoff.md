# Handoff（再開SSOTの更新）

## Description
ツール切替後に迷わず再開できるよう、**対象リポジトリ直下の `handoff.md`** を更新します。

正規の入口はターミナルの共通コマンドです：
- `handoff`（quick/full）
- `endwork`（full + `handoff.md` だけコミット）

> 旧方式（Vaultの `System/Documentation/引き継ぎ.md` への追記）は廃止しました。

## Prompt
次を実行してください（最短）。

1) 対象repoのルートで、ターミナルから `handoff` を実行（デフォルトはquick）
2) quickの場合、入力は基本 **Nextだけ**
   - Next = 「再開した瞬間に最初にやる1アクション（具体的なコマンド/ファイル/確認点）」
   - 例: `cd backend && pytest -q` / `app.py を開いて例外処理だけ直す`
3) その日の終わりは `endwork`（`handoff.md` だけをcommitする）

実行のきっかけ（迷ったらここ）:
- ツール/作業場所を切り替える前（Cursor ↔ Claude Code ↔ Codex）
- 30分以上中断する前
- PR/コミットの区切り直後
- 「次の一手」が固まった時

## メモ（コマンド例）

```bash
# quick（切替用）
handoff quick --next "cd backend && pytest -q"

# full + handoff.mdのみcommit（終了用）
endwork
```
