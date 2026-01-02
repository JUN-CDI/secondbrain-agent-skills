#!/usr/bin/env bash
set -euo pipefail

projects_root="/Users/donaichu/Workspaces/projects"
declare -a projects=()
mode_all=false
mode_zip=false
dry_run=false

usage() {
  cat <<'EOF'
Usage:
  project-release.sh [--projects-root PATH] (--all | --project NAME ...) [--zip] [--dry-run]

Notes:
  - Creates a zip from each project's `release/` folder.
  - Packages: `release/README-配布手順.md` + (`release/app/` or `release/web/` if present).
  - Does not include samples (because it only reads from `release/`).
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --projects-root) projects_root="$2"; shift 2 ;;
    --project) projects+=("$2"); shift 2 ;;
    --all) mode_all=true; shift ;;
    --zip) mode_zip=true; shift ;;
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

timestamp="$(date '+%Y%m%d-%H%M')"

zip_one() {
  local name="$1"
  local dir="$projects_root/$name"
  local release_dir="$dir/release"
  local readme="$release_dir/README-配布手順.md"

  if [ ! -d "$release_dir" ]; then
    echo "SKIP(no release/): $name"
    return 0
  fi

  if [ ! -f "$readme" ]; then
    echo "WARN(no README-配布手順.md): $name"
  fi

  local payload=""
  if [ -d "$release_dir/app" ]; then
    payload="app"
  elif [ -d "$release_dir/web" ]; then
    payload="web"
  else
    payload=""
  fi

  local safe_name
  safe_name="$(printf '%s' "$name" | tr ' ' '_' )"
  local out_zip="$release_dir/${safe_name}-${timestamp}.zip"

  if ! $mode_zip; then
    echo "OK: $name (zip disabled)"
    return 0
  fi

  if $dry_run; then
    echo "DRY: create $out_zip from $release_dir (payload=${payload:-README-only})"
    return 0
  fi

  rm -f "$out_zip"

  local tmpdir
  tmpdir="$(mktemp -d)"
  if [ -f "$readme" ]; then
    cp -f "$readme" "$tmpdir/README.md"
  fi
  if [ -n "$payload" ]; then
    cp -R "$release_dir/$payload" "$tmpdir/$payload"
  fi

  if command -v zip >/dev/null 2>&1; then
    (cd "$tmpdir" && zip -rq "$out_zip" .)
  elif command -v ditto >/dev/null 2>&1; then
    ditto -c -k --sequesterRsrc "$tmpdir" "$out_zip"
  else
    rm -rf "$tmpdir"
    echo "ERROR: need zip or ditto" >&2
    return 2
  fi

  rm -rf "$tmpdir"

  echo "ZIP: $out_zip"
}

had_error=false
for p in "${projects[@]}"; do
  if ! zip_one "$p"; then
    had_error=true
  fi
done

$had_error && exit 1 || exit 0
