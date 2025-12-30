---
name: ops-maintenance
description: Check official docs/release notes for Claude Code, Codex, Cursor, and Agent Skills; update local workflows and docs. Use when user mentions "最新化", "運用更新", or "公式確認".
allowed-tools: Read, Write, Bash(rg:*), Bash(git:*), Bash(curl:*), Bash(gh:*)
---

# Ops Maintenance Skill

公式情報を確認して、運用ドキュメントと実装内容を最新化するスキルです。

## Instructions

### Step 1: Confirm scope
Ask if missing:
- Which tools to check (Claude Code / Codex / Cursor / Agent Skills)
- Time window (last 1-3 months, etc.)
- Whether to apply changes or only propose

### Step 2: Load current local context
Read these files first:
- `System/Documentation/運用ガイド-全体像.md`
- `System/Documentation/Claude-Code-Skills-Scripts.md`
- `System/Documentation/運用フロー-2つの動線.md`
- `System/Workflows/運用フロー-2本柱.md`
- `System/Skills/` (Codex skills)
- `.claude/skills/` (Claude Code skills)

Summarize current assumptions and workflows.

### Step 3: Ask for network permission
This step requires network access. Ask the user to approve before running:
- official docs or release notes for Claude Code
- official docs or release notes for Codex CLI
- official docs or release notes for Cursor
- Agent Skills specification (agentskills)

### Step 4: Compare & propose updates
Identify mismatches between current docs and official updates.
Provide a brief list of:
- required changes
- optional improvements
- deprecations or risks

### Step 5: Apply updates (if approved)
Edit the relevant docs and templates:
- `System/Documentation/*.md`
- `System/Templates/*`
- `.claude/skills/*` / `System/Skills/*`

### Step 6: Sync Codex skills (if changed)
If `System/Skills/` changed, run:
```
./System/Scripts/sync-codex-skills.sh
```

### Step 7: Record last run
Update the timestamp used by the monthly reminder hook:
```bash
date +%s > ~/.claude/ops-maintenance.last
```

### Output format
- Summary of findings
- Proposed edits
- Changes applied
- Next check date
