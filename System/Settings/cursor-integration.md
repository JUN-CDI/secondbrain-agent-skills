# 🤖 Cursor統合設定

**最終更新**: 2025-01-13

---

## 🎯 Cursorとの統合

このObsidian Vaultは、Cursor AIエディタと統合して使用することを前提としています。

---

## 📁 Cursorコマンド

### コマンドの場所
`.cursor/commands/` フォルダに各種コマンドが定義されています。

### 主要コマンド
- `/organize-input` - Calendar/inbox 整理・振り分け
- `/inbox-review` - Calendar/inbox 棚卸し（軽め）
- `/create-dashboards` - ダッシュボード作成

---

## 🔧 Cursor設定

### ワークスペース設定
- **ワークスペースパス**: `/path/to/second-brain-vault`
- **デフォルトエディタ**: Cursor

### AI設定
- **モデル**: Claude Sonnet 4（推奨）
- **コンテキスト**: システム全体のルールを参照

---

## 📝 プロンプト管理

### プロンプトの場所
`System/prompts/` フォルダにカテゴリ別にプロンプトを保存。

### カテゴリ
- `01_整理系/` - inbox整理、Atlasノート作成
- `02_生成系/` - 生成・コンテンツ作成
- `03_レビュー系/` - ノート品質チェック
- `04_学習系/` - 技術調査
- `05_改善系/` - 改善作業用
- `06_一括作業系/` - 全量作業

---

## 🤖 AIへの指示

### システムルールの参照
Cursorに作業を依頼する際は、以下のファイルを参照させます：
- `AGENTS.md` - Brain System Rules
- `System/Documentation/運用ガイド-全体像.md` - システム概要

### コマンドの実行
Cursorコマンドは `/コマンド名` の形式で実行します。

---

## 🔄 ワークフロー統合

### 週次ルーティン
1. `/organize-input` - Calendar/inbox 整理
2. `/create-dashboards weekly` - 週次ダッシュボード更新

---

## 📚 関連ドキュメント

- [[../Documentation/運用ガイド-全体像]] - システム概要
- [[../../.cursor/commands/README]] - コマンド一覧
- [[../../prompts/README]] - プロンプト集

---

**最終更新**: 2025-01-13
