# プロジェクト初期化（Vault側）

## Description
Obsidian Vault内に **最小のプロジェクト入口** を作成します。

- 作成先: `Efforts/<project>/00-概要.md`
- 実装（コード）や実データは `~/Workspaces/projects/` 側を正本にして、Vault側は参照/意思決定ログ中心にします。

## 使用するツール
- `write`: 初期ノート作成
- `run_terminal_cmd`: フォルダ作成（mkdir）
- `glob_file_search`: 既存プロジェクト名の重複確認

## Prompt
引数:
- プロジェクト名（必須）: 例 `my-web-app`（フォルダ名は英語・ハイフン推奨）
- ステータス（任意）: `planning` / `active`（デフォルト: planning）

手順:
1. `Efforts/<project>/` が既に存在するか確認
   - 存在する場合は止めて、別名候補（末尾に `-2` など）を提案
2. フォルダ作成: `mkdir -p Efforts/<project>/`
3. `Efforts/<project>/00-概要.md` を作成
   - テンプレ参照: `System/Templates/プロジェクト概要テンプレート.md`
4. `Efforts/Projects-MOC.md` の該当セクション（Active/Planning）にリンクを1行追加

### 作成する `00-概要.md` の最低限フォーマット
```markdown
---
title: <project>（概要）
tags: [efforts, project]
status: planning
workspace: ~/Workspaces/projects/<project>
created: YYYY-MM-DD
---

# <project>（概要）

## 📁 作業フォルダ（ローカル/外部）
- Repo（コード）:
- GitHub:
- Finals(OneDrive):

## 🎯 次の一手
- [ ]
```

## 使用例
```
/project-init my-web-app
/project-init my-web-app active
```
