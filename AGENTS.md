# SecondBrain Rules（AI向け）

> セッション開始時: 対象repo直下の `handoff.md` を確認（再開SSOT）
> セッション終了時: 対象repoで `endwork`（`handoff.md` のみコミット）
> 運用変更があった場合: `System/Documentation/運用更新ログ.md` の最新エントリを確認
> 開発の起点（Harness/Cursor/Codex）は自由。ただし `handoff` / `endwork` は **対象repo内** で実行する（別repoの `handoff.md` を更新しないため）

## 1. 基本原則
- 記録優先。迷ったら `Calendar/inbox/`
- 情報は流す: Calendar → Atlas/Efforts → Efforts/archived
- リンクで価値を作る（重要概念のみ）

## 2. フォルダ構成
```
Atlas/
Calendar/
Efforts/
System/
```

### ワークスペース構成
- **SecondBrain (iCloud Vault)**: メインのSecondBrainフォルダ（上記フォルダ構成）
- **Workspaces (Local)**: ローカルワークスペース
- **Finals(OneDrive)**: 完成したプロジェクトの保管庫（OneDrive上）。完成品のみドラッグ&ドロップで移動

### 外部ワークスペース（特化不要のデフォルト）
- SecondBrain（iCloud Vault）配下以外は「外部」とみなし、原則読み取りのみ（書き込み/移動はユーザーが明示した場合のみ）
- 外部フォルダはSecondBrainの振り分けフロー対象外。保存先に迷ったらVault内 `Calendar/inbox/`
- 外部フォルダは“SecondBrainの運用ログ”対象外（必要なら対象repoの `handoff.md` に記録）

## 3. 振り分け判定フロー
```
今週使う？ → Calendar
3ヶ月後も参照？ → Atlas
期限あり/進行中？ → Efforts
完了/終了？ → Efforts/archived
不明 → Calendar
```

## 4. フォルダ別ルール（最小）
- Calendar: 一時置き場。寿命1週間〜1ヶ月。週次で `Atlas` / `Efforts` へ振り分け
- Atlas: 3ヶ月後も価値がある知識。必要ならMOCへリンク
- Efforts:
  - archived: 完了プロジェクト
- System: システム・運用（Documentation/Templates/prompts/Scripts/Skills）
- **Finals(OneDrive)**: 完成したプロジェクトの保管庫。SecondBrainの運用フローとは独立。完成品のみ保存

## 5. 命名規則（必須）
- フォルダ名は英語（kebab-case or underscore）
- ファイル名は日本語、スペース禁止、区切りはハイフン
- 禁止文字: `/ \ : * ? " < > |`
- 例: `2025-01-13-クライアントABCとの打ち合わせ.md`, `Cursor-キーボードショートカット.md`

## 6. タグルール（最小）
- 階層タグ: `#ai/tools/cursor`
- ステータス/優先度/時系列: `#status/todo` `#priority/high` `#2025` `#2025-01` `#2025-W02`
- frontmatterは `tags: [cursor, ai-tool, tips]` 形式

## 7. リンクルール
- 重要概念/前提/関連のみリンク
- 1文あたり1〜2個まで

## 8. AIへの指示（保存時チェック）
- 判定フローで保存先を決め、迷ったら `Calendar/inbox/`
- 命名規則を厳守
- 必要なら関連ノートへ1〜2件リンク
- 新しいSkill/コマンドを追加した場合は `tool-parity`（`tool-parity-check.sh`）で入口整合を確認
- セッション終了時は、作業しているrepoで `handoff` / `endwork` を使って `handoff.md` を更新
