#!/usr/bin/env bash
set -euo pipefail

# --- CONFIG ---

# Repository + password (prefer env vars or files in practice)
export RESTIC_REPOSITORY="${RESTIC_REPOSITORY:-sftp://delta//tank/runderwood/backups/voyager}"
export RESTIC_PASSWORD_FILE="${RESTIC_PASSWORD_FILE:-$HOME/.config/restic/password}"

# Backup sources
BACKUP_PATHS=(
    "$HOME/Documents"
    "$HOME/Pictures"
    "$HOME/Videos"
    "$HOME/Zotero"
    "$HOME/git"
    "$HOME/scratch"
)

# Exclude file
EXCLUDES_FILE="${HOME}/.config/restic/excludes.txt"

# Host tag (useful if you run on multiple machines)
HOST_TAG="$(hostname)"

# --- RUN ---

{
    echo "===== $(date) ====="

    # Backup
    restic backup \
        --read-concurrency 5 \
        --exclude-file="$EXCLUDES_FILE" \
        --exclude-caches \
        --one-file-system \
        --tag "auto" \
        --tag "$HOST_TAG" \
        "${BACKUP_PATHS[@]}" \

    # Retention policy
    restic forget \
        --keep-daily 7 \
        --keep-weekly 4 \
        --keep-monthly 6 \
        --prune

    echo "Backup completed successfully."
}
