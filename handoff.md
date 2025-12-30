# Handoff (resume SSOT)

This file is the single source of truth for resuming work in this repo.

- Switch / uncertainty: run `handoff quick`
- Session end: run `endwork`


### 2025-12-29 20:22 - Tool: cursor - Mode: full

- Purpose: 運用変更: 引き継ぎSSOTを repo直下 handoff.md に統一（handoff/endwork）
- Now: Docs/設定/スクリプトを新方式へ更新済み。旧 引き継ぎ.md は参照専用。
- Next: cd "/Users/donaichu/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain" && git status -sb
- Risk: 運用の正本は SecondBrain。迷ったら System/Documentation/運用更新ログ.md を確認。
- Decision: Vault-wide 引き継ぎ.md への自動追記を停止し、repo handoff.md に集約
- Tried/Result: grepで旧導線の現行指示を排除。履歴/分析は冒頭に旧方式注記を追加

#### Auto (git)
- Repo: /Users/donaichu/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain
- GitBranch: main
- GitStatus (top 20 lines):
```text
## main...origin/main [ahead 2, behind 3]
A  .claude/memory/archive/Plans-2025-12-28.md
MM .claude/settings.local.json
 M .claude/skills/dev-handoff/SKILL.md
 M .cursor/commands/README.md
 M .cursor/commands/handoff.md
 M .cursor/rules/session-start.md
M  .obsidian/app.json
 M AGENTS.md
M  Plans.md
 M "System/Documentation/AgentSkills-\351\201\213\347\224\250\346\241\210.md"
 M "System/Documentation/Claude-Code-Harness-\351\201\213\347\224\250.md"
 M System/Documentation/Claude-Code-Skills-Scripts.md
 M "System/Documentation/\343\203\227\343\203\255\343\202\270\343\202\247\343\202\257\343\203\210\347\264\240\346\235\220-\344\277\235\345\255\230\346\226\271\351\207\235.md"
 M "System/Documentation/\345\274\225\343\201\215\347\266\231\343\201\216-\347\265\214\351\201\216\344\277\235\345\255\230-\343\203\210\343\203\252\343\202\254\343\203\274.md"
 M "System/Documentation/\345\274\225\343\201\215\347\266\231\343\201\216-\351\226\213\347\231\272\344\275\234\346\245\255.md"
 M "System/Documentation/\351\201\213\347\224\250\343\202\254\343\202\244\343\203\211-\345\205\250\344\275\223\345\203\217.md"
 M "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274-2\343\201\244\343\201\256\345\213\225\347\267\232.md"
AM "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274\345\210\206\346\236\220-Claude-Code-vs-Codex.md"
AM "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274\346\267\261\346\216\230\343\202\212\345\210\206\346\236\220.md"
```
- GitDiffStat (unstaged, top 20 lines):
```text
 .claude/settings.local.json                        |  8 ---
 .claude/skills/dev-handoff/SKILL.md                |  6 +--
 .cursor/commands/README.md                         |  2 +-
 .cursor/commands/handoff.md                        | 49 ++++++++++--------
 .cursor/rules/session-start.md                     | 10 ++--
 AGENTS.md                                          |  9 ++--
 ...Skills-\351\201\213\347\224\250\346\241\210.md" | 14 +++++-
 ...laude-Code-Harness-\351\201\213\347\224\250.md" | 15 +++---
 System/Documentation/Claude-Code-Skills-Scripts.md | 37 +++++++++-----
 ...277\235\345\255\230\346\226\271\351\207\235.md" |  1 +
 ...203\210\343\203\252\343\202\254\343\203\274.md" | 30 +++++------
 ...226\213\347\231\272\344\275\234\346\245\255.md" | 13 +++--
 ...03\211-\345\205\250\344\275\223\345\203\217.md" |  6 +--
 ...201\244\343\201\256\345\213\225\347\267\232.md" | 14 ++++--
 ...45\210\206\346\236\220-Claude-Code-vs-Codex.md" |  4 ++
 ...216\230\343\202\212\345\210\206\346\236\220.md" |  4 ++
 ...233\264\346\226\260\343\203\255\343\202\260.md" | 27 +++++++---
 System/Scripts/dev-init.sh                         | 27 ++++++++++
 System/Scripts/handoff-add.sh                      | 58 ++++++++--------------
 System/Scripts/sync-codex-skills.sh                |  2 +-
```
- GitDiffStat (staged, top 20 lines):
```text
 .claude/memory/archive/Plans-2025-12-28.md         |  209 ++++
 .claude/settings.local.json                        |   41 +-
 .obsidian/app.json                                 |    4 +-
 Plans.md                                           |  395 +++++++-
 ...45\210\206\346\236\220-Claude-Code-vs-Codex.md" |  268 +++++
 ...216\230\343\202\212\345\210\206\346\236\220.md" | 1023 ++++++++++++++++++++
 6 files changed, 1926 insertions(+), 14 deletions(-)
```
- ChangedFiles (top 20):
  - .claude/memory/archive/Plans-2025-12-28.md
  - .claude/settings.local.json
  - .claude/skills/dev-handoff/SKILL.md
  - .cursor/commands/README.md
  - .cursor/commands/handoff.md
  - .cursor/rules/session-start.md
  - .obsidian/app.json
  - AGENTS.md
  - Plans.md
  - "System/Documentation/AgentSkills-\351\201\213\347\224\250\346\241\210.md"
  - "System/Documentation/Claude-Code-Harness-\351\201\213\347\224\250.md"
  - System/Documentation/Claude-Code-Skills-Scripts.md
  - "System/Documentation/\343\203\227\343\203\255\343\202\270\343\202\247\343\202\257\343\203\210\347\264\240\346\235\220-\344\277\235\345\255\230\346\226\271\351\207\235.md"
  - "System/Documentation/\345\274\225\343\201\215\347\266\231\343\201\216-\347\265\214\351\201\216\344\277\235\345\255\230-\343\203\210\343\203\252\343\202\254\343\203\274.md"
  - "System/Documentation/\345\274\225\343\201\215\347\266\231\343\201\216-\351\226\213\347\231\272\344\275\234\346\245\255.md"
  - "System/Documentation/\351\201\213\347\224\250\343\202\254\343\202\244\343\203\211-\345\205\250\344\275\223\345\203\217.md"
  - "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274-2\343\201\244\343\201\256\345\213\225\347\267\232.md"
  - "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274\345\210\206\346\236\220-Claude-Code-vs-Codex.md"
  - "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274\346\267\261\346\216\230\343\202\212\345\210\206\346\236\220.md"
  - "System/Documentation/\351\201\213\347\224\250\346\233\264\346\226\260\343\203\255\343\202\260.md"
  - ... (+6 more)

### 2025-12-30 09:46 - Tool: wrapup - Mode: full

- Purpose: 運用整理: Cursor Nightly前提とtool-parity必須を反映
- Now: AGENTS/運用ガイド/Skills docs/.cursor README/運用更新ログに追記済み
- Next: cd "/Users/donaichu/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain" && git status -sb
- Risk: SecondBrainの変更が大量に未整理。commit範囲を誤る恐れ

#### Auto (git)
- Repo: /Users/donaichu/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain
- GitBranch: main
- GitStatus (top 20 lines):
```text
## main...origin/main [ahead 2, behind 3]
A  .claude/memory/archive/Plans-2025-12-28.md
MM .claude/settings.local.json
M  .claude/skills/dev-handoff/SKILL.md
MM .cursor/commands/README.md
M  .cursor/commands/handoff.md
M  .cursor/rules/session-start.md
M  .obsidian/app.json
MM AGENTS.md
M  Plans.md
MM "System/Documentation/AgentSkills-\351\201\213\347\224\250\346\241\210.md"
M  "System/Documentation/Claude-Code-Harness-\351\201\213\347\224\250.md"
MM System/Documentation/Claude-Code-Skills-Scripts.md
M  "System/Documentation/\343\203\227\343\203\255\343\202\270\343\202\247\343\202\257\343\203\210\347\264\240\346\235\220-\344\277\235\345\255\230\346\226\271\351\207\235.md"
M  "System/Documentation/\345\274\225\343\201\215\347\266\231\343\201\216-\347\265\214\351\201\216\344\277\235\345\255\230-\343\203\210\343\203\252\343\202\254\343\203\274.md"
M  "System/Documentation/\345\274\225\343\201\215\347\266\231\343\201\216-\351\226\213\347\231\272\344\275\234\346\245\255.md"
MM "System/Documentation/\351\201\213\347\224\250\343\202\254\343\202\244\343\203\211-\345\205\250\344\275\223\345\203\217.md"
M  "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274-2\343\201\244\343\201\256\345\213\225\347\267\232.md"
A  "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274\345\210\206\346\236\220-Claude-Code-vs-Codex.md"
A  "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274\346\267\261\346\216\230\343\202\212\345\210\206\346\236\220.md"
```
- GitDiffStat (unstaged, top 20 lines):
```text
 .claude/settings.local.json                        |  3 ++
 .cursor/commands/README.md                         |  2 +
 AGENTS.md                                          |  1 +
 ...Skills-\351\201\213\347\224\250\346\241\210.md" | 17 ++++++-
 System/Documentation/Claude-Code-Skills-Scripts.md | 13 ++++-
 ...03\211-\345\205\250\344\275\223\345\203\217.md" |  4 +-
 ...233\264\346\226\260\343\203\255\343\202\260.md" |  8 +++
 System/Scripts/handoff-add.sh                      | 58 ++++++++--------------
 System/Scripts/sync-codex-skills.sh                |  2 +-
 ...\343\202\247\343\202\257\343\203\210-CLAUDE.md" |  7 ++-
 System/Workflows/project-management-flow.md        |  2 +-
 ...3\255\343\203\274-2\346\234\254\346\237\261.md" | 15 +++++-
 System/prompts/README.md                           |  2 +
 13 files changed, 86 insertions(+), 48 deletions(-)
```
- GitDiffStat (staged, top 20 lines):
```text
 .claude/memory/archive/Plans-2025-12-28.md         |  209 ++++
 .claude/settings.local.json                        |   49 +-
 .claude/skills/dev-handoff/SKILL.md                |    6 +-
 .cursor/commands/README.md                         |   17 +-
 .cursor/commands/handoff.md                        |   49 +-
 .cursor/rules/session-start.md                     |   10 +-
 .obsidian/app.json                                 |    4 +-
 AGENTS.md                                          |   10 +-
 Plans.md                                           |  395 +++++++-
 ...Skills-\351\201\213\347\224\250\346\241\210.md" |   36 +-
 ...laude-Code-Harness-\351\201\213\347\224\250.md" |   29 +-
 System/Documentation/Claude-Code-Skills-Scripts.md |   68 +-
 ...277\235\345\255\230\346\226\271\351\207\235.md" |    1 +
 ...203\210\343\203\252\343\202\254\343\203\274.md" |   30 +-
 ...226\213\347\231\272\344\275\234\346\245\255.md" |   13 +-
 ...03\211-\345\205\250\344\275\223\345\203\217.md" |   20 +-
 ...201\244\343\201\256\345\213\225\347\267\232.md" |   14 +-
 ...45\210\206\346\236\220-Claude-Code-vs-Codex.md" |  272 ++++++
 ...216\230\343\202\212\345\210\206\346\236\220.md" | 1027 ++++++++++++++++++++
 ...233\264\346\226\260\343\203\255\343\202\260.md" |   28 +-
```
- ChangedFiles (top 20):
  - .claude/memory/archive/Plans-2025-12-28.md
  - .claude/settings.local.json
  - .claude/skills/dev-handoff/SKILL.md
  - .cursor/commands/README.md
  - .cursor/commands/handoff.md
  - .cursor/rules/session-start.md
  - .obsidian/app.json
  - AGENTS.md
  - Plans.md
  - "System/Documentation/AgentSkills-\351\201\213\347\224\250\346\241\210.md"
  - "System/Documentation/Claude-Code-Harness-\351\201\213\347\224\250.md"
  - System/Documentation/Claude-Code-Skills-Scripts.md
  - "System/Documentation/\343\203\227\343\203\255\343\202\270\343\202\247\343\202\257\343\203\210\347\264\240\346\235\220-\344\277\235\345\255\230\346\226\271\351\207\235.md"
  - "System/Documentation/\345\274\225\343\201\215\347\266\231\343\201\216-\347\265\214\351\201\216\344\277\235\345\255\230-\343\203\210\343\203\252\343\202\254\343\203\274.md"
  - "System/Documentation/\345\274\225\343\201\215\347\266\231\343\201\216-\351\226\213\347\231\272\344\275\234\346\245\255.md"
  - "System/Documentation/\351\201\213\347\224\250\343\202\254\343\202\244\343\203\211-\345\205\250\344\275\223\345\203\217.md"
  - "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274-2\343\201\244\343\201\256\345\213\225\347\267\232.md"
  - "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274\345\210\206\346\236\220-Claude-Code-vs-Codex.md"
  - "System/Documentation/\351\201\213\347\224\250\343\203\225\343\203\255\343\203\274\346\267\261\346\216\230\343\202\212\345\210\206\346\236\220.md"
  - "System/Documentation/\351\201\213\347\224\250\346\233\264\346\226\260\343\203\255\343\202\260.md"
  - ... (+7 more)

### 2025-12-30 11:17 - Tool: codex - Mode: full

- Purpose: 運用更新（handoff/endwork/wrapup）、rebase+push、handoff一覧拡張
- Now: 全変更コミット済み・push済み、repo clean
- Next: 必要な新作業が出たら着手（まず ## main...origin/main で確認）
- Risk: なし
- Decision: handoff一覧は status --porcelain を採用、README/.gitignore は ACE 版で解決
- Tried/Result: git pull --rebase → conflict解消 → push 完了

#### Auto (git)
- Repo: /Users/donaichu/Library/Mobile Documents/iCloud~md~obsidian/Documents/SecondBrain
- GitBranch: main
- GitStatus (top 20 lines):
```text
## main...origin/main
 M handoff.md
```
- GitDiffStat (unstaged, top 20 lines):
```text
 handoff.md | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
```
- GitDiffStat (staged, top 20 lines):
```text
```
- ChangedFiles (top 20):
  -  M handoff.md
