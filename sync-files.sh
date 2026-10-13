#!/usr/bin/env bash

# sync-files.sh
#
# Synchronise Gemini skills and rules from an Ansible AI role into
# files/gemini/, preserving directory structure as physical copies rather
# than links. Copilot files (files/copilot/) are managed in this repository
# and are never touched by this script.
#
# Usage:
#   [SYNC_SRC_BASE=/path/to/role/files] ./sync-files.sh

set -Eeuo pipefail
shopt -s inherit_errexit
IFS=$'\n\t'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
readonly SCRIPT_DIR

readonly DEFAULT_SRC_BASE="${HOME}/dev/ansible/debian/roles/antigravity/files"
readonly SRC_BASE="${SYNC_SRC_BASE:-${DEFAULT_SRC_BASE}}"
readonly GEMINI_DEST="${SCRIPT_DIR}/files/gemini"
readonly TARGETS=(skills rules)

require_tool() {
  command -v "$1" >/dev/null 2>&1 || {
    printf 'ERROR: Required tool not found: %s\n' "$1" >&2
    exit 1
  }
}

sync_target() {
  local -r target="$1"
  local -r src="${SRC_BASE}/${target}"
  local -r dst="${GEMINI_DEST}/${target}"

  if [[ ! -d "${src}" ]]; then
    printf 'ERROR: Source directory not found: %s\n' "${src}" >&2
    exit 1
  fi

  mkdir --parents "${dst}"
  printf 'Syncing %s -> %s\n' "${src}" "${dst}"
  rsync --archive --verbose --delete "${src}/" "${dst}/"
  printf '\n'
}

main() {
  local target

  require_tool rsync
  for target in "${TARGETS[@]}"; do
    sync_target "${target}"
  done
}

main "$@"
