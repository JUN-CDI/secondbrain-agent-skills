# SecondBrain Rules（AI向け）

> セッション開始時: `System/Documentation/引き継ぎ.md` を確認（直近の作業・運用変更）
> セッション終了時: `System/Documentation/引き継ぎ.md` に変更ファイルを追記（Claude Codeは自動、Codex/Cursorは /handoff）

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
attachments/
```

### ワークスペース構成
- **SecondBrain (iCloud Vault)**: メインのSecondBrainフォルダ（上記フォルダ構成）
- **Workspaces (Local)**: ローカルワークスペース
- **Finals(OneDrive)**: 完成したプロジェクトの保管庫（OneDrive上）。完成品のみドラッグ&ドロップで移動

### 外部ワークスペース（特化不要のデフォルト）
- SecondBrain（iCloud Vault）配下以外は「外部」とみなし、原則読み取りのみ（書き込み/移動はユーザーが明示した場合のみ）
- 外部フォルダはSecondBrainの振り分けフロー対象外。保存先に迷ったらVault内 `Calendar/inbox/`
- 外部フォルダを操作した場合のみ、`引き継ぎ.md` にも併記（通常はVault内の変更だけ記録）

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
- セッション終了時に `引き継ぎ.md` へ変更ファイルを追記
