#!/usr/bin/env bash

# hardlink-files.sh
#
# Create hard links for all files in the Ansible AI role files
# directory to the local files/ directory, preserving the
# directory structure.
#
# Hard links are used so that both paths refer to the same
# inode on disk. Edits to either path are reflected in both.
#
# NOTE: Hard links require both directories to be on the same
#       filesystem.
#
# Usage:
#   ./hardlink-files.sh

set -euo pipefail

# --- Configuration -------------------------------------------
MAPPINGS=(
  "$HOME/dev/ansible/debian/roles/antigravity/files/skills|files/gemini/skills"
  "$HOME/dev/ansible/debian/roles/vscode/files/prompts|files/code/prompts"
)
# -------------------------------------------------------------

# die MESSAGE
# Print an error message to stderr and exit with status 1.
die() {
  echo "ERROR: $*" >&2
  exit 1
}

# link_tree SOURCE_DIR DEST_DIR
# Hard-link every regular file under SOURCE_DIR into DEST_DIR,
# preserving the relative path structure. Files already linked
# to the same inode are skipped; all others are force-linked.
link_tree() {
  local source_dir="$1"
  local dest_dir="$2"
  local src_dev dst_dev

  [[ -d "${source_dir}" ]] \
    || die "Source directory not found: ${source_dir}"

  mkdir -p "${dest_dir}"
  src_dev=$(stat --format='%d' "${source_dir}")
  dst_dev=$(stat --format='%d' "${dest_dir}")
  [[ "${src_dev}" == "${dst_dev}" ]] \
    || die "Source and destination are on different filesystems."

  echo "Source:      ${source_dir}"
  echo "Destination: ${dest_dir}"

  # cp -a  : Archive mode (recursive, preserves attributes)
  # cp -l  : Hard link files instead of copying
  # cp -f  : Force overwrite if destination exists but is a different file
  cp -alf "${source_dir}/." "${dest_dir}/"

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
