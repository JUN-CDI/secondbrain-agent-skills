# 引き継ぎログ更新

## Description
Claude Code / Codex / Cursor の引き継ぎを揃えるため、`System/Documentation/引き継ぎ.md` に手動追記します。

## Prompt
次を実行してください。

1) `System/Documentation/引き継ぎ.md` を開く
2) 今日の日付（YYYY-MM-DD）の見出しがなければ追加
3) 追記フォーマット:
   - `- HH:MM <変更ファイルパス> - <一言>`
   - 一言は任意（無ければ省略）
4) 変更が多い場合は3〜10件に要約
5) 追記のきっかけ（迷ったらここ）:
   - ツール/作業場所を切り替える前（Cursor ↔ Claude Code ↔ Codex）
   - 30分以上中断する前
   - PR/コミットの区切りを付けた直後
   - 「次やること」が1つに固まった時（次アクションを書いておく）
5) 追記後に「完了」と伝える

## メモ（Cursorを使わない場合）
ターミナルから1行追記するなら、これでもOKです：

```bash
cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/SecondBrain
./System/Scripts/handoff-add.sh "<場所 or ファイル>" "<一言>"
```
