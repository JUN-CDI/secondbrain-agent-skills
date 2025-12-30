---
name: project-scaffold
description: Initialize new development projects with standard structure. Use when user mentions "新規プロジェクト", "dev-init", "プロジェクト作成", "開発開始", or wants to create a new coding project.
allowed-tools: Read, Write, Bash(mkdir:*), Bash(git:*), Bash(gh:*)
---

# Project Scaffold Skill

新規開発プロジェクトをワンコマンドで初期化するスキルです。

## Instructions

### Step 1: Get Project Info
Ask user if not provided:
- Project name (required)
- Project type: `node` / `python` / `web` / `general`
- Git initialization: yes/no（テスト/プレイグラウンドならNO推奨）
- GitHub creation: yes/no

### Step 2: Create Folder Structure
```bash
PROJECT_DIR=~/Workspaces/projects/<project-name>

mkdir -p "$PROJECT_DIR"/{docs,samples,deliverables}
touch "$PROJECT_DIR/docs/.gitkeep"
touch "$PROJECT_DIR/samples/.gitkeep"
touch "$PROJECT_DIR/deliverables/.gitkeep"
```

### Step 3: Create Initial Files

#### CLAUDE.md
```markdown
# Claude Code Instructions (<project-name>)

- Work in small, reviewable steps.
- Never write secrets to files.
- Update docs/ when behavior changes.
- Ask before implementing ambiguous changes.

## Folder Structure
- docs/ - Design docs, specs
- samples/ - Sample inputs/fixtures
- deliverables/ - Output files (Git excluded)
```

#### AGENTS.md
```markdown
# Project Instructions (<project-name>)

## Goal
- <project goal>

## Workflow
- Small changes, frequent confirmation
- No secrets in commits
- Ask if unclear

## Repo Conventions
- docs/ - Documentation
- samples/ - Test data
- deliverables/ - Outputs
```

#### README.md
```markdown
# <project-name>

## 目的

## 使い方

## フォルダ構成
- docs/ - 仕様・設計メモ
- samples/ - サンプル入力
- deliverables/ - 成果物

## 関連
- Vault: Efforts/<project-name>/
```

#### .gitignore (by type)
```gitignore
# Common
.DS_Store
.env
.env.*
.vscode/
.idea/
*.log
/deliverables/*
!/deliverables/.gitkeep

# Node (if type=node or web)
node_modules/
dist/
.next/
out/

# Python (if type=python)
.venv/
__pycache__/
*.pyc
```

### Step 4: Initialize Git
If user chose Git initialization:
```bash
cd "$PROJECT_DIR"
git init
git add .
git commit -m "Initial commit"
```

### Step 5: Create GitHub Repo (if requested)
Only if Git was initialized:
```bash
gh repo create JUN-CDI/<project-name> --private --source=. --remote=origin --push
```

### Step 6: Report Completion
```markdown
## プロジェクト初期化完了

### 作成場所
~/Workspaces/projects/<project-name>/

### 作成ファイル
- CLAUDE.md
- AGENTS.md
- README.md
- .gitignore
- docs/, samples/, deliverables/

### 次のステップ
1. Vault側: /project-init <project-name> active
2. 00-概要.md にRepoパス記載
3. 開発開始
```

## Vault Integration
After local setup, remind user to run:
```
/project-init <project-name> active
```
Then link Vault notes to local repo path.
