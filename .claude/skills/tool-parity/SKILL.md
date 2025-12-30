---
name: tool-parity
description: Check and enforce cross-tool entrypoints parity (Claude/Codex/Cursor) for skills/commands.
allowed-tools: Read, Bash
---

# tool-parity（ツール横断の運用保証）

## Instructions
1. 追加/変更した Skill/コマンドが「全ツールで同名で呼べる」状態かを確認する。
2. 次を実行して結果を貼ってもらう（または実行案内する）:

```bash
cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/SecondBrain
bash ./System/Scripts/tool-parity-check.sh
```

3. Missing があれば、`System/Skills/`, `.claude/skills/`, `.cursor/commands/`, `System/Scripts/` の不足を埋める方針で修正する。

