#!/usr/bin/env bash

# hardlink-files.sh
#
# Create soft links for all files in the Ansible AI role files
# directory to the local files/ directory, preserving the
# directory structure.
#
# Soft links are used so destination entries point back to the
# source files. Edits to source files are reflected immediately.
#
# Usage:
#   ./hardlink-files.sh

set -euo pipefail

# --- Configuration -------------------------------------------
MAPPINGS=(
  "$HOME/dev/ansible/debian/roles/antigravity/files/skills|files/gemini/skills"
)
# "$HOME/dev/ansible/debian/roles/vscode/files/prompts|files/code/prompts"
# -------------------------------------------------------------

# die MESSAGE
# Print an error message to stderr and exit with status 1.
die() {
  echo "ERROR: $*" >&2
  exit 1
}

# link_tree SOURCE_DIR DEST_DIR
# Soft-link every regular file under SOURCE_DIR into DEST_DIR,
# preserving the relative path structure.
link_tree() {
  local source_dir="$1"
  local dest_dir="$2"

  [[ -d "${source_dir}" ]] \
    || die "Source directory not found: ${source_dir}"

  mkdir -p "${dest_dir}"

  echo "Source:      ${source_dir}"
  echo "Destination: ${dest_dir}"

  # cp -a  : Archive mode (recursive, preserves attributes)
  # cp -s  : Create symbolic links instead of copying file data
  # cp -f  : Force overwrite if destination exists but is different
  cp -asf "${source_dir}/." "${dest_dir}/"

  local file_count
  file_count=$(find "${dest_dir}" -type f | wc -l)

  echo "Tree linked successfully. (${file_count} files in destination)"
  echo "Files in ${dest_dir}:"
  find "${dest_dir}" -type f -printf "  - %P\n" | sort
  echo
}

#
# MAIN
#

for mapping in "${MAPPINGS[@]}"; do
  link_tree "${mapping%%|*}" "${mapping#*|}"
done
