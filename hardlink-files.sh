#!/usr/bin/env bash

# hardlink-files.sh
#
# Create symbolic links for all files in the Ansible AI role files
# directory to the local files/ directory, preserving the
# directory structure.
#
# Symbolic links are used so destination entries point back to the
# source files. Edits to source files are reflected immediately.
#
# Usage:
#   ./hardlink-files.sh

set -euo pipefail
IFS=$'\n\t'

# --- Configuration -------------------------------------------
MAPPINGS=(
  "$HOME/dev/ansible/debian/roles/antigravity/files/skills|files/gemini/skills"
  "$HOME/dev/ansible/debian/roles/antigravity/files/rules|files/gemini/rules"
)

# die MESSAGE
# Print an error message to stderr and exit with status 1.
die() {
  printf 'ERROR: %s\n' "$*" >&2
  exit 1
}

# link_tree SOURCE_DIR DEST_DIR
# Symlink every regular file under SOURCE_DIR into DEST_DIR,
# preserving the relative path structure.
link_tree() {
  local source_dir="$1"
  local dest_dir="$2"
  local file_count

  if [[ ! -d "${source_dir}" ]]; then
    die "Source directory not found: ${source_dir}"
  fi

  mkdir -p "${dest_dir}"

  printf 'Source:      %s\n' "${source_dir}"
  printf 'Destination: %s\n' "${dest_dir}"

  # cp -a  : Archive mode (recursive, preserves attributes)
  # cp -s  : Create symbolic links instead of copying file data
  # cp -f  : Force overwrite if destination exists but is different
  cp -asf "${source_dir}/." "${dest_dir}/"

  file_count=$(find "${dest_dir}" -type f | wc -l | tr -d ' ')

  printf 'Tree linked successfully. (%s files in destination)\n' \
    "${file_count}"
  printf 'Files in %s:\n' "${dest_dir}"
  find "${dest_dir}" -type f -printf '  - %P\n' | sort
  printf '\n'
}

main() {
  local mapping

  for mapping in "${MAPPINGS[@]}"; do
    link_tree "${mapping%%|*}" "${mapping#*|}"
  done
}

main "$@"
