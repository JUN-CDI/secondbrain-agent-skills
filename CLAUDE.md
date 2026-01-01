# Claude Code 設定

このファイルは Claude Code のプロジェクト固有の設定と運用ガイドラインを記載します。

## プロジェクト概要

SecondBrain は Obsidian を利用した個人知識管理システムです。

**プロジェクトタイプ**: Markdown/知識管理
**主要ツール**: Obsidian, Claude Code, Cursor

## ディレクトリ構造（ACEフレームワーク準拠）

```
SecondBrain/
├── Atlas/             # 時代を超えた知識（旧 04_Memory）
│   ├── 🗺️ Atlas-MOC.md
│   ├── _AI-MOC.md
│   ├── _Business-MOC.md
│   ├── _Education-MOC.md
│   ├── _Personal-MOC.md
│   └── (ノートは基本フラット)
├── Calendar/          # 時間ベース（旧 03_Input）
│   ├── inbox/         # クイックキャプチャ
│   └── 2025-12/       # デイリーノート
├── Efforts/           # 進行中プロジェクト（旧 05_Output, 99_Archive）
│   ├── 🎯 Efforts-MOC.md
│   ├── <project>/      # プロジェクトごとにフォルダ
│   └── archived/
├── System/           # システム設定（旧 07_System, 06_Templates, 08_prompts）
│   ├── Documentation/
│   ├── Scripts/
│   ├── Skills/
│   ├── Settings/
│   ├── Workflows/
│   ├── Dashboards/
│   ├── Templates/
│   └── prompts/
├── .claude/           # Claude Code 設定
│   ├── settings.json
│   ├── skills/
│   ├── state/
│   └── memory/        # decisions.md, patterns.md
├── AGENTS.md          # エージェント運用ガイド
├── CLAUDE.md          # 本ファイル
├── Plans.md           # タスク管理
└── README.md          # Vault入口
```

## Claude Code の役割

### Solo モード運用

このプロジェクトは **Solo モード** で運用します：
- Claude Code が直接タスクを実行
- Plans.md でタスク管理
- 必要に応じて Cursor と連携

### 主なタスク

1. **知識整理**: Calendar/inbox/ のメモを整理 → Atlas or Efforts へ振り分け
2. **コンテンツ作成**: テンプレートを使った文書作成（System/Templates/）
3. **プロジェクト管理**: `Efforts/` の運用・更新
4. **システム最適化**: Obsidian 設定の調整
5. **スキル開発**: カスタムスキルの作成・改善

## 開発ガイドライン

### ファイル操作

- **慎重に編集**: .obsidian/ 配下（Obsidian設定。基本は触らない）
- **自由に編集可**: Calendar/inbox/, Efforts/, Plans.md
- **慎重に編集**: System/, Atlas/, AGENTS.md

### コミットルール

- Markdown ファイル: 変更内容を明確に記載
- システムファイル: バックアップを取ってから変更
- スキル: テスト後にコミット

## よく使うコマンド

### スキル実行
```
claude skill dev-handoff          # 開発引き継ぎ作成
claude skill input-processor      # Input整理
claude skill ops-maintenance      # 運用メンテナンス
```

> メモ: スキルの編集は原則 `System/Skills/`（原本。別Git repo）で行い、実行環境（`~/.claude/skills/` や repo の `.claude/skills/`）へは `System/Scripts/sync-claude-skills.sh` で同期します。

### ワークフロー
```
/sync-status                      # 現在の状態確認
/work                             # Plans.md のタスク実行
/cleanup                          # ファイル整理
```

## 注意事項

- Obsidian の設定ファイル（`.obsidian/`）は基本触らない（必要ならバックアップしてから）
- 大量のファイル操作前にバックアップを確認
- スキル実行時は必ず結果を確認

## 参考リンク

- [AGENTS.md](./AGENTS.md) - エージェント運用ガイド
- [.claude/skills/](./.claude/skills/) - カスタムスキル一覧
- [.cursor/commands/](./.cursor/commands/) - Cursor カスタムコマンド
