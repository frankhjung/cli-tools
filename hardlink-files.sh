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
# Accumulates counts into the caller-scoped total_created and
# total_skipped variables.
link_tree() {
  local source_dir="$1"
  local dest_dir="$2"
  local created=0
  local skipped=0
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
  echo

  while IFS= read -r -d '' src_file; do
    local rel_path dest_file

    rel_path="${src_file#"${source_dir}"/}"
    dest_file="${dest_dir}/${rel_path}"
    mkdir -p "$(dirname "${dest_file}")"

    if [[ -f "${dest_file}" && "${src_file}" -ef "${dest_file}" ]]; then
      echo "  SKIP: ${rel_path}"
      ((skipped++)) || :
      continue
    fi

    ln -f "${src_file}" "${dest_file}"
    echo "  LINK: ${rel_path}"
    ((created++)) || :
  done < <(find "${source_dir}" -type f -print0 | sort -z)

  echo
  echo "Created ${created} hard link(s), skipped ${skipped}."
  echo

  total_created=$((total_created + created))
  total_skipped=$((total_skipped + skipped))
}

#
# MAIN
#

total_created=0
total_skipped=0

# Process each mapping
for mapping in "${MAPPINGS[@]}"; do
  link_tree "${mapping%%|*}" "${mapping#*|}"
done

echo "Created ${total_created} hard link(s), skipped ${total_skipped}."
