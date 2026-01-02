# プロジェクト正規化（Workspaces/projects）

## Description
Workspaces側の既存プロジェクトを「最小フォルダ構成」に寄せます。

- `src/ release/ docs/ tmp/` を作成
- ルート直下の単体HTML/スクリプト等を `src/` に移動
- ルート直下のMD（README/AGENTS/CLAUDE/handoff以外）を `docs/` に移動

実体は `System/Scripts/project-normalize.sh` を実行します。

## Prompt
例:
```bash
./System/Scripts/project-normalize.sh --project "CSVコンバートWEBアプリ"
./System/Scripts/project-normalize.sh --project "債権管理_v2"
./System/Scripts/project-normalize.sh --all
```

