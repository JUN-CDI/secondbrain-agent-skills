---
name: changelog-watcher
description: Check for Claude Code updates and new features. Use when user asks about "最新機能", "アップデート", "新機能", "Claude Code更新", or wants to know about recent changes and improvements.
allowed-tools: WebFetch, WebSearch, Read, Write
---

# Changelog Watcher Skill

Claude Codeの最新アップデートを確認し、運用フローへの影響を分析するスキルです。

## Instructions

### Step 1: Fetch Latest Information
Check these sources:
1. Claude Code official changelog
2. Anthropic engineering blog
3. GitHub releases (if available)

```
WebSearch: "Claude Code changelog 2025"
WebSearch: "Anthropic Claude Code new features"
WebFetch: https://docs.anthropic.com/en/docs/claude-code
```

### Step 2: Analyze Updates
For each new feature/change:
- What is it?
- How does it work?
- Is it relevant to our workflow?

### Step 3: Compare with Current Setup
Check current configuration:
```
Read: ~/.claude/settings.json
Read: .claude/settings.local.json
Read: .claude/skills/*/SKILL.md
```

### Step 4: Generate Report
Create a structured report:

```markdown
# Claude Code アップデートレポート

## 確認日時
YYYY-MM-DD HH:MM

## 新機能・変更点

### 機能1: [名前]
- **概要**:
- **影響度**: 高/中/低
- **推奨アクション**:

### 機能2: [名前]
...

## 現在の設定との比較

| 機能 | 現状 | 推奨 |
|------|------|------|
| Skills | 3個 | 追加推奨 |
| Hooks | 未設定 | 設定推奨 |

## 推奨される運用フロー変更

1. [具体的な変更提案]
2. [具体的な変更提案]

## 次回確認推奨日
YYYY-MM-DD（1ヶ月後）
```

### Step 5: Save Report (Optional)
If user wants to save:
```
Write: 07_System/Documentation/Claude-Code-Updates/YYYY-MM-DD-update.md
```

## Update Check Schedule
Recommend checking:
- Monthly (routine)
- After major Anthropic announcements
- When encountering unexpected behavior

## Key Areas to Monitor
1. **Skills**: New capabilities, syntax changes
2. **Hooks**: New event types, security updates
3. **MCP**: New servers, protocol changes
4. **CLI**: New flags, deprecated options
5. **Permissions**: Security model changes

## Integration with Workflow
When significant updates found:
1. Update relevant Skills
2. Modify Hooks if needed
3. Update documentation in 07_System/
4. Notify user of breaking changes
