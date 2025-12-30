#!/bin/bash
# install-handoff.sh - install/link handoff + endwork (+ wrapup) into ~/.handoff/bin
#
# Usage:
#   bash System/Scripts/install-handoff.sh
#
# Notes:
# - This script does NOT modify your shell rc automatically; it prints PATH instructions.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SRC_HANDOFF="${SCRIPT_DIR}/handoff"
SRC_ENDWORK="${SCRIPT_DIR}/endwork"
SRC_WRAPUP="${SCRIPT_DIR}/wrapup"

if [[ ! -f "$SRC_HANDOFF" || ! -f "$SRC_ENDWORK" || ! -f "$SRC_WRAPUP" ]]; then
  echo "Error: expected scripts not found in $SCRIPT_DIR" >&2
  exit 1
fi

chmod +x "$SRC_HANDOFF" "$SRC_ENDWORK" "$SRC_WRAPUP" || true

DEST_DIR="${HOME}/.handoff/bin"
mkdir -p "$DEST_DIR"

link_or_copy() {
  local src="$1"
  local dest="$2"
  # Prefer symlink (keeps single source of truth). Fallback to copy.
  if ln -sf "$src" "$dest" 2>/dev/null; then
    return 0
  fi
  cp -f "$src" "$dest"
}

link_or_copy "$SRC_HANDOFF" "${DEST_DIR}/handoff"
link_or_copy "$SRC_ENDWORK" "${DEST_DIR}/endwork"
link_or_copy "$SRC_WRAPUP" "${DEST_DIR}/wrapup"

echo "OK: installed:"
echo "  - ${DEST_DIR}/handoff"
echo "  - ${DEST_DIR}/endwork"
echo "  - ${DEST_DIR}/wrapup"
echo ""
echo "Add to PATH (zsh):"
echo "  echo 'export PATH=\"${HOME}/.handoff/bin:$PATH\"' >> ~/.zshrc"
echo "  source ~/.zshrc"
echo ""
echo "Quick test:"
echo "  handoff --help"

