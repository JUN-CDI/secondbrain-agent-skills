#!/bin/bash
# tool-parity-check.sh - Verify cross-tool entrypoint parity (Skills / Commands / Scripts)
#
# Why:
#   When you add a new skill/command, it should be callable (same name) from:
#   - Terminal (if it has side effects): scripts + install
#   - Claude Code chat: ~/.claude/skills (or repo .claude/skills)
#   - Codex chat: ~/.codex/skills (via sync)
#   - Cursor chat: Agent Skills (Nightly) OR .cursor/commands fallback (stable)
#
# This script is offline and safe; it only checks files and prints actionable gaps.
#
# Usage:
#   bash ./System/Scripts/tool-parity-check.sh
#
# Optional:
#   VAULT_DIR=... bash ./System/Scripts/tool-parity-check.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_DIR="${VAULT_DIR:-$(cd "$SCRIPT_DIR/../.." && pwd)}"

fail=0

section() { printf "\n== %s ==\n" "$1"; }
ok() { printf "OK   %s\n" "$1"; }
warn() { printf "WARN %s\n" "$1"; }
miss() { printf "MISS %s\n" "$1"; fail=1; }

file_exists() {
  local p="$1"
  [[ -f "$p" ]]
}

dir_exists() {
  local p="$1"
  [[ -d "$p" ]]
}

contains() {
  local file="$1"
  local needle="$2"
  grep -Fq -- "$needle" "$file" 2>/dev/null
}

upper() {
  printf "%s" "$1" | tr '[:lower:]' '[:upper:]'
}

CORE_TERMINAL=(handoff endwork wrapup)
CORE_SKILLS=(handoff endwork wrapup git-checkpoint diff-review data-safety ops-maintenance tool-parity)
CORE_CURSOR_COMMANDS=(handoff endwork wrapup git-checkpoint diff-review tool-parity)
CORE_CLAUDE_SKILLS=(handoff endwork wrapup git-checkpoint diff-review ops-maintenance tool-parity)

section "Vault paths"
ok "VAULT_DIR=$VAULT_DIR"

section "Terminal scripts (System/Scripts)"
for cmd in "${CORE_TERMINAL[@]}"; do
  if file_exists "$VAULT_DIR/System/Scripts/$cmd"; then
    ok "System/Scripts/$cmd"
  else
    miss "System/Scripts/$cmd (missing)"
  fi
done

section "Installer parity (install-handoff.sh)"
INSTALL="$VAULT_DIR/System/Scripts/install-handoff.sh"
if file_exists "$INSTALL"; then
  for cmd in "${CORE_TERMINAL[@]}"; do
    cmd_upper="$(upper "$cmd")"
    if contains "$INSTALL" "SRC_${cmd_upper}=" || contains "$INSTALL" "/$cmd"; then
      ok "install-handoff.sh mentions $cmd"
    else
      miss "install-handoff.sh does not mention $cmd (should install ~/.handoff/bin/$cmd)"
    fi
  done
else
  miss "System/Scripts/install-handoff.sh (missing)"
fi

section "Vault Agent Skills (System/Skills)"
for s in "${CORE_SKILLS[@]}"; do
  if file_exists "$VAULT_DIR/System/Skills/$s/SKILL.md"; then
    ok "System/Skills/$s/SKILL.md"
  else
    miss "System/Skills/$s/SKILL.md (missing)"
  fi
done

section "Claude Code chat skills (.claude/skills)"
for s in "${CORE_CLAUDE_SKILLS[@]}"; do
  if file_exists "$VAULT_DIR/.claude/skills/$s/SKILL.md"; then
    ok ".claude/skills/$s/SKILL.md"
  else
    miss ".claude/skills/$s/SKILL.md (missing wrapper)"
  fi
done

section "Cursor chat fallbacks (.cursor/commands)"
for c in "${CORE_CURSOR_COMMANDS[@]}"; do
  if file_exists "$VAULT_DIR/.cursor/commands/$c.md"; then
    ok ".cursor/commands/$c.md"
  else
    miss ".cursor/commands/$c.md (missing Cursor command wrapper)"
  fi
done

section "Codex sync bootstrap (sync-codex-skills.sh)"
SYNC_CODEX="$VAULT_DIR/System/Scripts/sync-codex-skills.sh"
if file_exists "$SYNC_CODEX"; then
  # Only checks the offline bootstrap list (used when System/Skills is missing).
  if grep -Eq 'for skill in .*' "$SYNC_CODEX"; then
    ok "sync-codex-skills.sh has bootstrap list"
    for s in handoff endwork wrapup git-checkpoint diff-review; do
      if grep -Eq "for skill in .*\\b${s}\\b" "$SYNC_CODEX"; then
        ok "bootstrap list includes $s"
      else
        warn "bootstrap list does not include $s (optional; only affects --from-codex bootstrap)"
      fi
    done
  else
    warn "sync-codex-skills.sh bootstrap list not found (OK if not using --from-codex)"
  fi
else
  miss "System/Scripts/sync-codex-skills.sh (missing)"
fi

section "Docs entrypoints (minimal)"
DOC_CORE="$VAULT_DIR/System/Documentation/運用ガイド-全体像.md"
if file_exists "$DOC_CORE"; then
  if grep -Fq -- "wrapup" "$DOC_CORE" && grep -Fq -- "endwork" "$DOC_CORE" && grep -Fq -- "handoff quick" "$DOC_CORE"; then
    ok "運用ガイド-全体像.md mentions handoff/endwork/wrapup"
  else
    warn "運用ガイド-全体像.md may be missing handoff/endwork/wrapup"
  fi
else
  warn "運用ガイド-全体像.md not found"
fi

echo ""
if [[ "$fail" -eq 0 ]]; then
  echo "✅ tool-parity-check: OK (no missing entrypoints)"
else
  echo "❌ tool-parity-check: FAIL (missing items above)"
  echo ""
  echo "Fix flow (typical):"
  echo "  1) Add missing wrappers/files"
  echo "  2) Re-run: bash ./System/Scripts/tool-parity-check.sh"
  exit 1
fi
