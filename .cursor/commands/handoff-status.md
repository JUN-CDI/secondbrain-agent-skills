---
name: handoff-status
description: Check handoff status for tool switching
---

# Handoff Status Check

## Instructions

```bash
bash "$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain/System/Scripts/handoff-check.sh"
```

This will show:
- Staged changes
- Unstaged changes
- Last commit
- Unpushed commits
- Next actions

## Quick Actions

**Continue work**: Just proceed

**Save checkpoint**: 
```bash
bash System/Scripts/checkpoint.sh "your message"
```

**Reset staging**:
```bash
git reset HEAD
```

**Push to remote**:
```bash
git push
```
