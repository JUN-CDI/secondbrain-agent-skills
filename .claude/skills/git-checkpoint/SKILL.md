---
name: git-checkpoint
description: Stage only intended changes with git add -p and review via git diff --staged to keep diffs small and clear. Use when user mentions "差分固定", "チェックポイント", or "git add -p".
allowed-tools: Read, Bash(git:*)
---

# Git Checkpoint Skill

差分を小さく固定し、レビューしやすい状態にします。

## Instructions

### Step 1: Confirm repo context
Ask if missing:
- Repo path
- Whether to stage changes now

### Step 2: Inspect working tree
```bash
git status -sb
git diff
```

### Step 3: Stage only intended changes
If user agrees:
```bash
git add -p
git diff --staged
```

### Step 4: Safety check
Warn if tracked data is present:
- `samples/`, `deliverables/`, `*.csv`, `*.xlsx`

Suggest remediation:
```bash
git rm --cached <path>
```

### Step 5: Report
Return a short summary:
- staged files
- unstaged files
- next recommended action (review or commit)
