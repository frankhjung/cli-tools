#!/usr/bin/env bash

# sync-files.sh
#
# Synchronise skills and rules from an Ansible AI role into local files/,
# preserving directory structure as physical copies rather than links.
#
# Usage:
#   ./sync-files.sh

set -Eeuo pipefail
shopt -s inherit_errexit
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
readonly SCRIPT_DIR

readonly SRC_BASE="${HOME}/dev/ansible/debian/roles/antigravity/files"
readonly DEST_BASE="${SCRIPT_DIR}/files/gemini"
readonly TARGETS=(skills rules)

main() {
  local target src dst

  for target in "${TARGETS[@]}"; do
    src="${SRC_BASE}/${target}"
    dst="${DEST_BASE}/${target}"

    if [[ ! -d "${src}" ]]; then
      printf 'ERROR: Source directory not found: %s\n' "${src}" >&2
      exit 1
    fi

    mkdir -p "${dst}"
    printf 'Syncing %s -> %s\n' "${src}" "${dst}"
    rsync -av --delete "${src}/" "${dst}/"
    printf '\n'
  done
}

main "$@"
