#!/bin/bash
# dev-init.sh - 新規開発プロジェクト初期化
#
# 使い方:
#   ./dev-init.sh my-project           # 汎用プロジェクト
#   ./dev-init.sh my-project node      # Node.jsプロジェクト
#   ./dev-init.sh my-project python    # Pythonプロジェクト
#   ./dev-init.sh my-project node --github  # GitHub連携
#   ./dev-init.sh my-project --no-git       # テスト/一時用途（Gitなし）

set -e

# Arguments (positional)
PROJECT_NAME="${1:-}"
PROJECT_TYPE="${2:-general}"
shift $(( $# > 0 ? 1 : 0 )) || true
shift $(( $# > 0 ? 1 : 0 )) || true

# Flags (default: preserve existing behavior for non-interactive)
GITHUB=false
FORCE_GIT=""
NO_COMMIT=false
REPO_VISIBILITY="--private"

while [[ $# -gt 0 ]]; do
    case "$1" in
        --github)
            GITHUB=true
            shift
            ;;
        --git)
            FORCE_GIT="true"
            shift
            ;;
        --no-git)
            FORCE_GIT="false"
            shift
            ;;
        --no-commit)
            NO_COMMIT=true
            shift
            ;;
        --public)
            REPO_VISIBILITY="--public"
            shift
            ;;
        --private)
            REPO_VISIBILITY="--private"
            shift
            ;;
        *)
            echo -e "${RED}Error: Unknown option: $1${NC}"
            echo "Usage: ./dev-init.sh <project-name> [type] [--github] [--git|--no-git] [--no-commit] [--public|--private]"
            exit 1
            ;;
    esac
done

# Paths
WORKSPACE_DIR="$HOME/Workspaces/projects"
PROJECT_DIR="$WORKSPACE_DIR/$PROJECT_NAME"
VAULT_DIR="$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain"
TEMPLATE_DIR="$VAULT_DIR/System/Templates"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Validate
if [[ -z "$PROJECT_NAME" ]]; then
    echo -e "${RED}Error: Project name is required${NC}"
    echo "Usage: ./dev-init.sh <project-name> [type] [--github] [--git|--no-git] [--no-commit] [--public|--private]"
    echo "Types: general, node, python, web"
    exit 1
fi

if [[ -d "$PROJECT_DIR" ]]; then
    echo -e "${RED}Error: Directory already exists: $PROJECT_DIR${NC}"
    echo "Suggested alternative: ${PROJECT_NAME}-2"
    exit 1
fi

echo -e "${GREEN}🚀 Creating project: $PROJECT_NAME${NC}"
echo "   Type: $PROJECT_TYPE"
echo "   Location: $PROJECT_DIR"

# Decide Git initialization behavior
INIT_GIT=true
if [[ "$FORCE_GIT" == "true" ]]; then
    INIT_GIT=true
elif [[ "$FORCE_GIT" == "false" ]]; then
    INIT_GIT=false
else
    # If interactive, ask; otherwise preserve previous default (git init).
    if [[ -t 0 ]]; then
        read -r -p "Initialize Git repository? [Y/n] " reply || true
        if [[ "$reply" =~ ^[Nn]$ ]]; then
            INIT_GIT=false
        fi
    fi
fi

if [[ "$GITHUB" == "true" && "$INIT_GIT" != "true" ]]; then
    echo -e "${YELLOW}⚠️  --github was requested but Git init is disabled. Skipping GitHub creation.${NC}"
    GITHUB=false
fi

# Create directories (minimal by default)
echo -e "${YELLOW}📁 Creating folder structure...${NC}"
mkdir -p "$PROJECT_DIR"/{src,release,docs,tmp,.vscode}
mkdir -p "$PROJECT_DIR/.cursor"/{commands,rules}
touch "$PROJECT_DIR/src/.gitkeep"
touch "$PROJECT_DIR/tmp/.gitkeep"
touch "$PROJECT_DIR/release/.gitkeep"
touch "$PROJECT_DIR/docs/.gitkeep"

# Create release README (distribution SSOT)
cat > "$PROJECT_DIR/release/README-配布手順.md" << EOF
# 配布手順（$PROJECT_NAME）

## 方針
- 配布物は \`release/\` に集約します
- サンプルは同梱しません
- 配布時は \`release/\` から zip を作って渡します

## 配布物（中身）
- TODO: \`release/app/\` または \`release/web/\` に「渡すもの」を入れる

## 使い方（受け手）
- TODO: 最短手順を書く
EOF

# Create handoff SSOT
cat > "$PROJECT_DIR/handoff.md" << 'EOF'
# Handoff (resume SSOT)

This file is the single source of truth for resuming work in this repo.

- Switch / uncertainty: `handoff quick` (Next only)
- Session end: `wrapup` (recommended) or `endwork` (minimal)

EOF

# Create VSCode/Cursor helpers
echo -e "${YELLOW}🤖 Creating VSCode/Cursor helpers...${NC}"
cat > "$PROJECT_DIR/.vscode/tasks.json" << 'EOF'
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "claude-terminal",
      "type": "shell",
      "command": "claude",
      "presentation": {
        "reveal": "always",
        "focus": false,
        "panel": "dedicated",
        "group": "ai-terminals",
        "clear": false,
        "showReuseMessage": false
      },
      "problemMatcher": []
    },
    {
      "label": "codex-terminal",
      "type": "shell",
      "command": "codex",
      "presentation": {
        "reveal": "always",
        "focus": false,
        "panel": "dedicated",
        "group": "ai-terminals",
        "clear": false,
        "showReuseMessage": false
      },
      "problemMatcher": []
    },
    {
      "label": "setup-ai-terminals",
      "dependsOn": [
        "claude-terminal",
        "codex-terminal"
      ],
      "dependsOrder": "parallel",
      "problemMatcher": []
    }
  ]
}
EOF

cat > "$PROJECT_DIR/.cursor/rules/ai-workflow.md" << 'EOF'
# AI Workflow Rules

## Core
- Keep changes small and reviewable.
- Prefer clear, boring code over cleverness.
- If requirements are unclear, ask before implementing.

## Data & Git
- Do **not** commit real data (CSV/Excel) by default.
- Do **not** commit distribution artifacts (`release/*.zip`).
- If a data file accidentally became tracked, remove it from Git index (keep local file): `git rm --cached <path>`.
- Make diffs obvious: checkpoint often with `git add -p` and review via `git diff --staged` (leave WIP unstaged).

## Review loop (recommended)
1. Implement (Cursor / Claude Code).
2. Checkpoint: `git status` → `git diff` → `git add -p` → `git diff --staged`.
3. Ask Codex to review (prefer staged diff): start `codex` and run `/review`.
4. Apply fixes and re-check diff.

## Handoff (resume SSOT)
- SSOT is repo-root `handoff.md`.
  - Switch / uncertainty: `handoff quick` (Next only)
  - Session end: `wrapup` (recommended) / `endwork` (minimal; commits only `handoff.md`)
EOF

cat > "$PROJECT_DIR/.cursor/commands/codex-review.md" << 'EOF'
# Codex差分レビュー（開発Repo）

## Description
このリポジトリの差分を **Codex CLI** でレビューする段取りを固定化します。

## Prompt
1. `git status` で変更/未追跡を確認
2. `git diff` で未ステージ差分を確認
3. レビュー対象の変更だけを `git add -p`（または `git add <file>`）でステージ（WIPは未ステージのままでOK）
4. `git diff --staged` でレビュー対象の差分を確定
5. 実データ（CSV/Excel）や `release/*.zip` が追跡されていないか確認（混入は除外）
6. `codex` を起動して `/review`（ステージ差分を中心に）を実行
7. 指摘を反映して、再度 `git diff --staged` / `git diff` で確認
EOF

cat > "$PROJECT_DIR/.cursor/commands/git-checkpoint.md" << 'EOF'
# Gitチェックポイント（差分を小さくする）

## Description
こまめにステージして差分を“確定”し、レビュー/コミットをしやすくします。

## Prompt
1. `git status` で変更/未追跡を確認
2. `git diff` で作業中の差分を確認
3. まとまった変更だけを `git add -p`（または `git add <file>`）でステージ
4. `git diff --staged` で「いま確定した差分」だけを確認
5. （必要なら）`git restore --staged <file>` でステージを戻す
6. 実データ（`*.csv`, `*.xlsx`）や `release/*.zip` が追跡されていないか確認
EOF

cat > "$PROJECT_DIR/.cursor/commands/diff-review.md" << 'EOF'
# 差分レビュー（ステージ差分）

## Description
`git diff --staged` を前提に、短く具体的なレビューを返します（P0/P1/P2）。

## Prompt
次を実行してください。

1. `git status` と `git diff --staged` で差分を把握
2. 変更の意図を1〜2行で要約
3. 指摘は優先度順（P0/P1/P2）で列挙
   - 理由（何が問題か）
   - 具体的な修正案（可能ならパッチ/擬似コード）
   - 影響範囲（どこが壊れうるか）
   - 確認手順（どう確認するか）
4. 新規/更新ファイルは、命名・配置・責務の妥当性も確認
5. データ混入チェック（`*.csv`, `*.xlsx`, `release/*.zip`）
6. 最後に「このまま進めて良いか」を Yes/No（条件付き可）で結論
EOF

cat > "$PROJECT_DIR/.cursor/commands/handoff.md" << 'EOF'
# Handoff（再開SSOTの更新）

## Description
ツール切替後に迷わず再開できるよう、**repo直下の `handoff.md`** を更新します。

## Prompt
対象repoで `handoff` を実行してください（デフォルト quick）。

```bash
handoff quick --next "<next action>"
```

Nextは「再開した瞬間に最初にやる1アクション」を具体的に（コマンド/ファイル/確認点）。
EOF

cat > "$PROJECT_DIR/.cursor/commands/endwork.md" << 'EOF'
# Endwork（終了: handoff full + handoff.mdだけcommit）

## Description
セッション終了時に、`handoff full` を残してから **`handoff.md` だけ**をcommitします（他ファイルを巻き込まない）。
`endwork` 自体は push しません（`push済み` と書くのは `git push` 成功後のみ）。

## Prompt
対象repoで `endwork` を実行してください。

```bash
endwork
```
EOF

cat > "$PROJECT_DIR/.cursor/commands/wrapup.md" << 'EOF'
# Wrapup（終了時の品質パック）

## Description
終了時に「再開しやすい状態」を作ります。

- `git add -p` で差分を確定（レビュー/コミットしたい範囲だけステージ）
- `endwork` を実行（`handoff full` + `handoff.md` だけcommit）

## Prompt
対象repoで `wrapup` を実行してください。

```bash
wrapup
```

チェックポイントを飛ばすなら:
```bash
wrapup --no-checkpoint
```
EOF

# Create CLAUDE.md
echo -e "${YELLOW}📝 Creating CLAUDE.md...${NC}"
cat > "$PROJECT_DIR/CLAUDE.md" << EOF
# Claude Code Instructions ($PROJECT_NAME)

## Overview
- Project: $PROJECT_NAME
- Type: $PROJECT_TYPE
- Created: $(date +%Y-%m-%d)

## Guidelines

### General
- Work in small, reviewable steps.
- Never write secrets to files (API keys, passwords, tokens).
- If a change is ambiguous, ask before implementing.

### Documentation
- Keep design docs and specs in \`docs/\`.
- Update \`README.md\` when behavior changes.

### Handoff (resume SSOT)
- SSOT is repo-root \`handoff.md\`.
  - Switch / uncertainty: \`handoff quick\` (Next only)
  - Session end: \`wrapup\` (recommended) / \`endwork\` (minimal; commits only \`handoff.md\`)

### Code Style
- Follow existing patterns in the codebase.
- Prefer readability over cleverness.

## Folder Structure
\`\`\`
.
├── CLAUDE.md        # This file
├── AGENTS.md        # Codex instructions
├── README.md        # Project overview
├── .gitignore       # Git exclusions
├── src/             # Source of truth (editable)
├── docs/            # Documentation (optional)
├── tmp/             # Throwaway / scratch (optional)
└── release/         # Distribution (untracked; zip from here)
\`\`\`

## Related
- Vault management notes: \`Efforts/$PROJECT_NAME/00-概要.md\`
EOF

# Create AGENTS.md
echo -e "${YELLOW}📝 Creating AGENTS.md...${NC}"
cat > "$PROJECT_DIR/AGENTS.md" << EOF
# Project Instructions ($PROJECT_NAME)

## Goal
- Develop and maintain the $PROJECT_NAME project.

## Workflow
- Prefer small changes and confirm behavior frequently.
- Do not add or commit secrets (API keys, tokens, passwords).
- Ask for clarification if requirements are unclear.

## Handoff (resume SSOT)
- SSOT is repo-root \`handoff.md\`.
  - Switch / uncertainty: \`handoff quick\` (Next only)
  - Session end: \`wrapup\` (recommended) / \`endwork\` (minimal; commits only \`handoff.md\`)

## Repo Conventions

### Folder Structure
- \`src/\` - Source of truth (editable)
- \`release/\` - Distribution (untracked; zip from here)
- \`docs/\` - Documentation (optional)
- \`tmp/\` - Throwaway / scratch (optional)

### Git Practices
- Commit small, focused changes
- Write clear commit messages
- Never commit secrets

## Tech Stack
- $PROJECT_TYPE

## Related
- Vault project notes: \`Efforts/$PROJECT_NAME/00-概要.md\`
EOF

# Create README.md
echo -e "${YELLOW}📝 Creating README.md...${NC}"
cat > "$PROJECT_DIR/README.md" << EOF
# $PROJECT_NAME

## 目的


## 使い方


## フォルダ構成
- src/ - 実装
- release/ - 配布物（Git管理しない。zipはここから作る）
- docs/ - 仕様・設計メモ（必要な時だけ）
- tmp/ - 一時作業

## 関連
- Vault側管理ノート: \`Efforts/$PROJECT_NAME/00-概要.md\`
EOF

# Create .gitignore based on type
echo -e "${YELLOW}📝 Creating .gitignore...${NC}"
cat > "$PROJECT_DIR/.gitignore" << EOF
# macOS
.DS_Store

# Environment
.env
.env.*

# IDE
.vscode/
.idea/

# Logs
*.log

# Release (distribution package)
/release/*.zip
/release/*
!/release/README-配布手順.md
!/release/.gitkeep
EOF

# Add type-specific ignores
if [[ "$PROJECT_TYPE" == "node" || "$PROJECT_TYPE" == "web" ]]; then
    cat >> "$PROJECT_DIR/.gitignore" << EOF

# Node.js
node_modules/
dist/
.next/
out/
EOF
fi

if [[ "$PROJECT_TYPE" == "python" ]]; then
    cat >> "$PROJECT_DIR/.gitignore" << EOF

# Python
.venv/
__pycache__/
*.pyc
*.pyo
EOF
fi

cd "$PROJECT_DIR"
if [[ "$INIT_GIT" == "true" ]]; then
    echo -e "${YELLOW}🔧 Initializing Git...${NC}"
    git init
    git add .
    if [[ "$NO_COMMIT" == "true" ]]; then
        echo -e "${YELLOW}⏭️  Skipping initial commit (--no-commit)${NC}"
    else
        git commit -m "Initial commit"
    fi
else
    echo -e "${YELLOW}⏭️  Skipping Git init (--no-git)${NC}"
fi

# Create GitHub repo if requested
if [[ "$GITHUB" == "true" ]]; then
    if ! command -v gh >/dev/null 2>&1; then
        echo -e "${RED}Error: gh (GitHub CLI) is not installed, cannot create repo automatically.${NC}"
        echo "Install gh or create the repository manually, then add remote origin."
        exit 1
    fi
    echo -e "${YELLOW}🐙 Creating GitHub repository...${NC}"
    gh repo create "JUN-CDI/$PROJECT_NAME" "$REPO_VISIBILITY" --source=. --remote=origin --push
    GITHUB_URL="https://github.com/JUN-CDI/$PROJECT_NAME"
    echo -e "${GREEN}   GitHub: $GITHUB_URL${NC}"
fi

# Summary
echo ""
echo -e "${GREEN}✅ Project initialized successfully!${NC}"
echo ""
echo "📁 Location: $PROJECT_DIR"
echo "🔧 Git: $([[ \"$INIT_GIT\" == \"true\" ]] && echo \"enabled\" || echo \"disabled\")"
echo ""
echo "📋 Created files:"
echo "   - CLAUDE.md"
echo "   - AGENTS.md"
echo "   - handoff.md"
echo "   - README.md"
echo "   - .gitignore"
echo "   - .vscode/tasks.json (local)"
echo "   - .cursor/rules/ai-workflow.md"
echo "   - .cursor/commands/codex-review.md"
echo "   - .cursor/commands/git-checkpoint.md"
echo "   - .cursor/commands/diff-review.md"
echo "   - .cursor/commands/handoff.md"
echo "   - .cursor/commands/endwork.md"
echo "   - .cursor/commands/wrapup.md"
echo "   - docs/"
echo "   - src/"
echo "   - release/"
echo "   - tmp/"
echo ""
echo -e "${YELLOW}🔗 Next steps:${NC}"
echo "   1. Vault側の管理ノートを作成:"
echo "      /project-init $PROJECT_NAME active"
echo ""
echo "   2. 00-概要.md に以下を記入:"
echo "      - Repo: $PROJECT_DIR"
if [[ -n "$GITHUB_URL" ]]; then
echo "      - GitHub: $GITHUB_URL"
fi
echo ""
echo "   3. 開発開始:"
echo "      code $PROJECT_DIR"
