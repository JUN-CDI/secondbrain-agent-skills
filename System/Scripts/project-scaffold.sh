#!/usr/bin/env bash
set -euo pipefail

projects_root="/Users/donaichu/Workspaces/projects"
name=""
type=""
dry_run=false

usage() {
  cat <<'EOF'
Usage:
  project-scaffold.sh --name NAME --type TYPE [--projects-root PATH] [--dry-run]

TYPE:
  static-html       # standalone HTML in release/app
  vite-web          # build-based web (release/web)
  python-streamlit  # Streamlit app (release has README only)
  python-cli        # Python CLI (release has README only)
  fullstack-docker  # Docker-compose based service (release has README only)
  docs-only         # documents/deliverables only
EOF
}

while [ $# -gt 0 ]; do
  case "$1" in
    --projects-root) projects_root="$2"; shift 2 ;;
    --name) name="$2"; shift 2 ;;
    --type) type="$2"; shift 2 ;;
    --dry-run) dry_run=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2 ;;
  esac
done

if [ -z "$name" ] || [ -z "$type" ]; then
  usage
  exit 2
fi

dir="$projects_root/$name"

if $dry_run; then
  echo "DRY: mkdir -p \"$dir\""
else
  mkdir -p "$dir"
fi

mk() {
  if $dry_run; then
    echo "DRY: mkdir -p \"$1\""
  else
    mkdir -p "$1"
  fi
}

write_file() {
  local path="$1"
  local content="$2"
  if $dry_run; then
    echo "DRY: write $path"
  else
    printf "%s\n" "$content" > "$path"
  fi
}

mk "$dir/docs"
mk "$dir/scripts"
mk "$dir/tests"
mk "$dir/tmp"
mk "$dir/release"
if $dry_run; then :; else : > "$dir/release/.gitkeep"; fi

case "$type" in
  static-html)
    mk "$dir/release/app"
    ;;
  vite-web)
    mk "$dir/release/web"
    ;;
  python-streamlit|python-cli|fullstack-docker|docs-only)
    ;;
  *)
    echo "Unknown type: $type" >&2
    usage
    exit 2
    ;;
esac

readme_path="$dir/release/README-配布手順.md"
template=$(
  cat <<EOF
# 配布手順（$name）

## 配布物
- \`release/\` をzip化して配布します（サンプル同梱なし）

## 使い方（受け手）
- TODO: 最短手順を書く

## 備考
- このプロジェクト種別: \`$type\`
EOF
)
write_file "$readme_path" "$template"

echo "OK: $dir"

