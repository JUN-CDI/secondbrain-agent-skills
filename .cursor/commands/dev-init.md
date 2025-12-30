# 開発プロジェクト初期化（Workspaces側）

## Description
ローカルの `~/Workspaces/projects/` に開発フォルダを作成し、必要な初期ファイルを生成します。

実体は `System/Scripts/dev-init.sh` を実行します。

## 使用するツール
- `run_terminal_cmd`: スクリプト実行

## Prompt
引数:
- プロジェクト名（必須）: 例 `my-web-app`
- プロジェクトタイプ（任意）: `web` / `python` / `node` / `general`（デフォルト: general）
- オプション（任意）:
  - `--github`（GitHub repoも作る）
  - `--no-git`（Git initしない。テスト/プレイグラウンド向け）
  - `--public` / `--private`

手順:
1. Vaultルートで `./System/Scripts/dev-init.sh <project> <type> [flags]` を実行
2. 結果を要約し、次のステップとして `/project-init <project> <status>` を案内

例:
```bash
./System/Scripts/dev-init.sh my-web-app node --github
./System/Scripts/dev-init.sh sandbox general --no-git
```
