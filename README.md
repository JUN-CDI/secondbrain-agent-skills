# 🏠 SecondBrain - Welcome

このVaultは **ACEフレームワーク** に基づいて整理されています。

## 🗺️ 3つのエリア

### 📚 [[Atlas/🗺️ Atlas-MOC|Atlas]] - 時代を超えた知識
3ヶ月後も参照する長期知識を保存

- AI、ビジネス、教育、技術などの知識
- 再利用可能なテンプレート・パターン
- **MOCファイルで整理**（フォルダは最小限）

### 📅 [[Calendar/inbox|Calendar]] - 時間ベース
日々のメモ・一時的な情報

- `inbox/` - クイックキャプチャ（旧 03_Input）
- `2025-12/` - デイリーノート
- **週次で整理** → Atlas or Efforts へ振り分け

### 🎯 [[Efforts/🎯 Efforts-MOC|Efforts]] - 進行中プロジェクト
期限のある活動・プロジェクト

- （各プロジェクトのフォルダ） - プロジェクト運用ノート
- `archived/` - 完了プロジェクト

## 🔧 システム

- [[System/Documentation/運用ガイド-全体像|運用ガイド]] - システム全体像
- [[System/Documentation/運用フロー-2つの動線|運用フロー]] - 2つの主要動線
- [[AGENTS]] - 開発フロー定義
- [[CLAUDE]] - Vault運用ルール
- [[Plans]] - タスク管理

## 🚀 クイックスタート

### 新しいアイデアをメモしたい
```
1. Calendar/inbox/ に新規ファイル作成
2. 書く
3. 週末に整理して振り分け
```

### 新しいプロジェクトを始めたい
```
1. /dev-init <project-name>
2. /project-init <project-name>
3. Efforts/<project-name>/ にフォルダ作成
```

### 知識を探したい
```
1. Atlas/🗺️ Atlas-MOC を開く
2. カテゴリーのMOCを辿る
3. タグ検索 (#ai, #business など)
```

## 📖 運用フロー

- **インプット**: `Calendar/inbox/` → 週次整理 → `Atlas/` or `Efforts/`
- **開発**: `Workspaces/projects/` ← ローカル開発
- **完了**: `Efforts/` → `Efforts/archived/`

---

**ACE原則**: フォルダは後から必要になったときに作る。まずはMOCファイルでリンク。

最終更新: 2025-12-24（ACE移行）
