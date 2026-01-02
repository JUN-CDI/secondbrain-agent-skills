#!/usr/bin/env bash
set -euo pipefail

projects_root="/Users/donaichu/Workspaces/projects"
declare -a projects=()
mode_all=false
mode_zip=false
keep_history=false
dry_run=false

usage() {
  cat <<'EOF'
Usage:
  project-release.sh [--projects-root PATH] (--all | --project NAME ...) [--zip] [--keep-history] [--dry-run]

Notes:
  - Creates a zip for distribution.
  - Default behavior keeps exactly 1 zip per project: `release/<project>.zip`
    - Use `--keep-history` to keep timestamped zips.
  - Packages: README + payload
    - Prefer `release/app/` or `release/web/` if present
    - Otherwise auto-prepares from `src/` (-> app/) or `dist/` (-> web/) if present
  - Never includes samples (it only packages release/app|web or src|dist).
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --projects-root) projects_root="$2"; shift 2 ;;
    --project) projects+=("$2"); shift 2 ;;
    --all) mode_all=true; shift ;;
    --zip) mode_zip=true; shift ;;
    --keep-history) keep_history=true; shift ;;
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

copy_payload_from_src() {
  local src_dir="$1"
  local out_dir="$2"

  mkdir -p "$out_dir"

  # Files: keep a conservative allowlist for distribution.
  find "$src_dir" -maxdepth 1 -type f \
    \( -name '*.html' -o -name '*.css' -o -name '*.js' -o -name '*.mjs' -o -name '*.json' -o -name '*.ps1' \) \
    -print0 \
    | while IFS= read -r -d '' f; do
        cp -f "$f" "$out_dir/$(basename "$f")"
      done

  # Common asset folders (if present)
  for sub in assets css js img images; do
    if [ -d "$src_dir/$sub" ]; then
      cp -R "$src_dir/$sub" "$out_dir/$sub"
    fi
  done
}

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
  local has_package_json=false
  if [ -f "$dir/package.json" ]; then
    has_package_json=true
  fi

  # Prefer generating payload from source/build output to avoid stale release/app|web.
  if ! $has_package_json && [ -d "$dir/src" ] && find "$dir/src" -maxdepth 1 -type f \( -name '*.html' -o -name '*.ps1' \) | grep -q .; then
    payload="app:src"
  elif [ -d "$dir/dist" ]; then
    payload="web:dist"
  elif [ -d "$release_dir/web" ]; then
    payload="web"
  elif [ -d "$release_dir/app" ]; then
    payload="app"
  else
    payload=""
  fi

  local safe_name
  safe_name="$(printf '%s' "$name" | tr ' ' '_' )"
  local out_zip
  if $keep_history; then
    out_zip="$release_dir/${safe_name}-${timestamp}.zip"
  else
    out_zip="$release_dir/${safe_name}.zip"
  fi

  if ! $mode_zip; then
    echo "OK: $name (zip disabled)"
    return 0
  fi

  if $dry_run; then
    echo "DRY: create $out_zip from $release_dir (payload=${payload:-README-only})"
    return 0
  fi

  if $keep_history; then
    rm -f "$out_zip"
  else
    # Keep exactly one zip per project by default.
    rm -f "$release_dir/${safe_name}.zip"
  fi

  local tmpdir
  tmpdir="$(mktemp -d)"
  if [ -f "$readme" ]; then
    cp -f "$readme" "$tmpdir/README.md"
  fi
  case "$payload" in
    app|web)
      cp -R "$release_dir/$payload" "$tmpdir/$payload"
      ;;
    web:dist)
      mkdir -p "$tmpdir/web"
      cp -R "$dir/dist/"* "$tmpdir/web/" 2>/dev/null || true
      ;;
    app:src)
      copy_payload_from_src "$dir/src" "$tmpdir/app"
      ;;
    "")
      ;;
    *)
      echo "WARN: unknown payload selector: $payload" >&2
      ;;
  esac

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
