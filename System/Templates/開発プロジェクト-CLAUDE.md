# Claude Code Instructions ({{project}})

## Overview
- Project: {{project}}
- Type: {{type}}
- Created: {{date}}

## Guidelines

### General
- Work in small, reviewable steps.
- Make diffs obvious: checkpoint often with `git add -p` and review via `git diff --staged`.
- Never write secrets to files (API keys, passwords, tokens).
- If a change is ambiguous, ask before implementing.

### Documentation
- Keep design docs and specs in `docs/`.
- Update `README.md` when behavior changes.
- Add comments for non-obvious logic.

### Code Style
- Follow existing patterns in the codebase.
- Prefer readability over cleverness.
- Use meaningful variable and function names.

### Testing
- Test changes before committing.
- Use sample data from `samples/` for testing (excluded from Git by default).

### Handoff
- Resume SSOT is repo-root `handoff.md`:
  - Switch / uncertainty: `handoff quick`
  - Session end: `endwork` (commits only `handoff.md`)
- For longer-form handoff notes, use `System/Documentation/引き継ぎ-開発作業.md`.
- Provide `git status -sb`, `git diff --staged --stat`, and the handoff summary when needed.

## Folder Structure
```
.
├── CLAUDE.md        # This file
├── AGENTS.md        # Codex instructions
├── README.md        # Project overview
├── .gitignore       # Git exclusions
├── docs/            # Design docs, specs
├── samples/         # Sample inputs/fixtures (excluded from Git by default)
└── deliverables/    # Output files (excluded from Git by default)
```

## Related
- Vault management notes: `Efforts/{{project}}/`
