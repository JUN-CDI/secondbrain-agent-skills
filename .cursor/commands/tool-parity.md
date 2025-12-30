# tool-parity（ツール横断の運用保証）

## Description
新しいSkill/コマンドを追加したときに、Claude Code / Codex / Cursor で **同じ名前で呼べる**状態（入口の一致）を維持できているかをチェックします。

## Prompt
次を実行してください（ターミナル）。

```bash
cd ~/Library/Mobile\ Documents/iCloud~md~obsidian/Documents/SecondBrain
bash ./System/Scripts/tool-parity-check.sh
```

Missing が出たら、指示に従って以下のどれが欠けているかを埋めます：
- `System/Skills/<name>/SKILL.md`（原本）
- `.claude/skills/<name>/SKILL.md`（Claude Codeチャット入口）
- `.cursor/commands/<name>.md`（Cursor安定版フォールバック入口）
- `System/Scripts/<cmd>` + install（ターミナル実体）

