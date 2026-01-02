# 配布zip作成（Workspaces/projects）

## Description
各プロジェクトの `release/` から **配布用zip** を生成します（サンプル同梱なし）。

実体は `System/Scripts/project-release.sh` を実行します。

## 使用するツール
- `run_terminal_cmd`: スクリプト実行

## Prompt
手順:
1. Vaultルートで `./System/Scripts/project-release.sh --project "<name>" --zip` を実行
2. 生成されたzipパスを返す（どこにできたか）

例:
```bash
./System/Scripts/project-release.sh --project "債権管理_v2" --zip
./System/Scripts/project-release.sh --project "emax-practice-game" --zip

# 全件（releaseがあるもの）
./System/Scripts/project-release.sh --all --zip
```

