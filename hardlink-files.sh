#!/usr/bin/env bash
#
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
#

set -euo pipefail

# --- Configuration -------------------------------------------
SOURCE_DIR="/home/frank/dev/ansible/debian/roles/ai/files"
DEST_DIR="$(cd "$(dirname "$0")" && pwd)/files"
# -------------------------------------------------------------

# Verify source directory exists.
if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "ERROR: Source directory not found: ${SOURCE_DIR}" >&2
  exit 1
fi

# Check that source and destination are on the same filesystem.
src_dev=$(stat --format='%d' "${SOURCE_DIR}")
dst_dev=$(stat --format='%d' "${DEST_DIR}")
if [[ "${src_dev}" != "${dst_dev}" ]]; then
  echo "ERROR: Source and destination are on different" \
    "filesystems." >&2
  echo "  Hard links cannot span filesystems." >&2
  echo "  Source device: ${src_dev}" >&2
  echo "  Dest device:   ${dst_dev}" >&2
  exit 1
fi

echo "Source:      ${SOURCE_DIR}"
echo "Destination: ${DEST_DIR}"
echo

# Find all regular files under SOURCE_DIR, create matching
# directory structure, and hard link each file.
created=0
skipped=0

while IFS= read -r -d '' src_file; do
  # Compute the relative path from the source directory.
  rel_path="${src_file#"${SOURCE_DIR}"/}"

  # Build the destination path.
  dest_file="${DEST_DIR}/${rel_path}"

  # Create the destination directory if it doesn't exist.
  dest_parent="$(dirname "${dest_file}")"
  mkdir -p "${dest_parent}"

  # If destination already exists and is already a hard link
  # to the source (same inode), skip it.
  if [[ -f "${dest_file}" ]]; then
    src_inode=$(stat --format='%i' "${src_file}")
    dst_inode=$(stat --format='%i' "${dest_file}")
    if [[ "${src_inode}" == "${dst_inode}" ]]; then
      echo "  SKIP (already linked): ${rel_path}"
      ((skipped++)) || :
      continue
    fi
    # Different inode — remove and re-link.
    echo "  REPLACE: ${rel_path}"
    rm -f "${dest_file}"
  else
    echo "  LINK:    ${rel_path}"
  fi

  # Create the hard link.
  ln "${src_file}" "${dest_file}"
  ((created++)) || :

done < <(find "${SOURCE_DIR}" -type f -print0 | sort -z)

echo
echo "Done. Created ${created} hard link(s)," \
  "skipped ${skipped}."
