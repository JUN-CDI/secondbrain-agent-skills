#!/bin/bash
# handoff-add.sh (DEPRECATED)
#
# This script used to append a one-line entry to the Vault-wide log:
#   System/Documentation/引き継ぎ.md
#
# The handoff system has migrated to a per-repo SSOT:
#   repo-root handoff.md
# via tool-agnostic commands:
#   handoff / endwork
#
# This legacy script is intentionally disabled to prevent double-logging.

set -euo pipefail

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  sed -n '1,140p' "$0"
  exit 0
fi

cat >&2 <<'EOF'
This script is deprecated and disabled.

New handoff workflow:
  - Switch / uncertainty: run `handoff quick` inside the target repo
  - Session end: run `endwork` inside the target repo

Examples:
  cd ~/Workspaces/projects/<repo>
  handoff quick --next "cd backend && pytest -q"
  endwork
EOF

exit 2
