# Project Instructions ({{project}})

## Goal

## Scope
- This file is for Codex. For Claude Code, follow `CLAUDE.md`.

- {{goal}}

## Workflow
- Prefer small changes and confirm behavior frequently.
- Do not add or commit secrets (API keys, tokens, passwords).
- Ask for clarification if requirements are unclear.

## Repo Conventions

### Folder Structure
- `docs/` - Design documents, specifications, and technical notes
- `samples/` - Sample inputs, fixtures, and test data (exclude from Git by default)
- `deliverables/` - Output files (exclude from Git by default)

### File Naming
- Use lowercase with hyphens for folders and files
- Be descriptive: `user-authentication-flow.md` instead of `auth.md`

### Git Practices
- Commit small, focused changes
- Write clear commit messages
- Never commit secrets or credentials
- Do not commit real data (CSV/Excel); keep them under `samples/` or `deliverables/`
- Make diffs obvious: checkpoint often with `git add -p` and review via `git diff --staged`

## Review Loop (Recommended)
1. Implement changes (small steps)
2. Checkpoint: `git status` → `git diff` → `git add -p` → `git diff --staged`
3. Ask Codex to review (`codex` → `/review`)
4. Apply fixes and re-check diff

## Tech Stack
- {{tech_stack}}

## Key Files
- `CLAUDE.md` - Claude Code specific instructions
- `README.md` - Project overview and setup

## Related
- Vault project notes: `Efforts/{{project}}/`
