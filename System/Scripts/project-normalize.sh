#!/usr/bin/env bash
set -euo pipefail

projects_root="/Users/donaichu/Workspaces/projects"
declare -a projects=()
mode_all=false
dry_run=false

usage() {
  cat <<'EOF'
Usage:
  project-normalize.sh [--projects-root PATH] (--all | --project NAME ...) [--dry-run]

What it does (minimal, safe):
  - Ensures minimal folders exist: src/ release/ docs/ tmp/
  - Moves standalone artifacts from repo root into src/
    - `.ps1` is always moved
    - `.html` is moved only when the repo is not Node-based (no `package.json` in root)
    - Uses git mv when possible to preserve history
  - Moves a small set of Markdown helpers into docs/
    - Keeps README.md / AGENTS.md / CLAUDE.md / handoff.md at root
    - Moves only: QUICK_REFERENCE.md, *引き継ぎ*.md, *使い方*.md, TEST_REPORT.md
  - Does NOT delete local data folders (samples/deliverables), only stops relying on them
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --projects-root) projects_root="$2"; shift 2 ;;
    --project) projects+=("$2"); shift 2 ;;
    --all) mode_all=true; shift ;;
    --dry-run) dry_run=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

if ! $mode_all && [ ${#projects[@]} -eq 0 ]; then
  echo "Pick --all or --project" >&2
  usage
  exit 2
fi

if $mode_all; then
  while IFS= read -r -d '' d; do
    projects+=("$(basename "$d")")
  done < <(find "$projects_root" -mindepth 1 -maxdepth 1 -type d -print0)
fi

ensure_dirs() {
  local dir="$1"
  for d in src release docs tmp; do
    if $dry_run; then
      echo "DRY: mkdir -p \"$dir/$d\""
    else
      mkdir -p "$dir/$d"
    fi
  done
  if ! $dry_run; then
    : > "$dir/src/.gitkeep"
    : > "$dir/release/.gitkeep"
    : > "$dir/docs/.gitkeep"
    : > "$dir/tmp/.gitkeep"
  fi
}

is_git_repo() {
  [ -d "$1/.git" ]
}

move_one() {
  local dir="$1"
  local from_rel="$2"
  local to_rel="$3"

  local from="$dir/$from_rel"
  local to="$dir/$to_rel"
  local to_dir
  to_dir="$(dirname "$to")"

  if [ ! -e "$from" ]; then
    return 0
  fi

  if $dry_run; then
    echo "DRY: move \"$from_rel\" -> \"$to_rel\""
    return 0
  fi

  mkdir -p "$to_dir"
  if is_git_repo "$dir" && git -C "$dir" ls-files --error-unmatch -- "$from_rel" >/dev/null 2>&1; then
    git -C "$dir" mv -f -- "$from_rel" "$to_rel"
  else
    mv -f "$from" "$to"
  fi
}

normalize_one() {
  local name="$1"
  local dir="$projects_root/$name"
  if [ ! -d "$dir" ]; then
    echo "SKIP(no dir): $name" >&2
    return 0
  fi

  echo "== normalize: $name =="
  ensure_dirs "$dir"

  local has_package_json=false
  if [ -f "$dir/package.json" ]; then
    has_package_json=true
  fi

  # Move root artifacts -> src/
  shopt -s nullglob
  for f in "$dir"/*.ps1; do
    move_one "$dir" "$(basename "$f")" "src/$(basename "$f")"
  done
  if ! $has_package_json; then
    for f in "$dir"/*.html; do
      move_one "$dir" "$(basename "$f")" "src/$(basename "$f")"
    done
  fi
  shopt -u nullglob

  # Move selected root Markdown -> docs (except core root docs)
  shopt -s nullglob
  for f in "$dir"/*.md; do
    base="$(basename "$f")"
    case "$base" in
      README.md|AGENTS.md|CLAUDE.md|handoff.md) continue ;;
    esac
    case "$base" in
      QUICK_REFERENCE.md|TEST_REPORT.md|*引き継ぎ*.md|*使い方*.md) move_one "$dir" "$base" "docs/$base" ;;
      *) ;;
    esac
  done
  shopt -u nullglob
}

had_error=false
for p in "${projects[@]}"; do
  if ! normalize_one "$p"; then
    had_error=true
  fi
done

$had_error && exit 1 || exit 0
