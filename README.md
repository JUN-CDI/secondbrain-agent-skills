# SecondBrain Agent Skills

This repository contains Agent Skills (`<skill>/SKILL.md`) for the SecondBrain knowledge management system.

## Skills (root)

- **data-safety**: Prevent committing real data outputs (CSV/XLSX, deliverables, etc.)
- **diff-review**: Review staged git diffs with concrete, prioritized findings
- **git-checkpoint**: Create clean checkpoints via `git add -p` → `git diff --staged`
- **ops-maintenance**: Check official docs/release notes and update local workflows/docs

## Legacy (Claude Code)

`/.claude/skills/` is kept for compatibility with older Claude Code setups. Cursor/Codex usage should prefer the root skill packages above.

## Installation

- **Cursor (Nightly)**: Settings → Rules → Import Settings → Agent Skills → add this GitHub repo URL
- **Codex CLI**: copy/sync skill directories into `~/.codex/skills/` (see your local `sync-codex-skills.sh`)

## Notes

- Do not commit secrets (SSH private keys, tokens, etc.) to this repository.
