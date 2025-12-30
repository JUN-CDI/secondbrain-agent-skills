# git-checkpoint（差分固定）

## Description
レビュー/コミットしたい差分だけをステージして、差分を「確定」します（WIPは未ステージのままでOK）。

## Prompt
対象repoのルートで、次の手順を実行してください（ターミナル）。

```bash
git status
git diff
git add -p
git diff --staged
```

