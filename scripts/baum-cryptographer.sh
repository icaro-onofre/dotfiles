#!/usr/bin/env bash
#
# age-archive.sh
#
# Tars up a file/directory and encrypts it symmetrically with `age -p`
# (passphrase-based). Meant to be run inside an interactive terminal
# (e.g. launched by kitty from cron) since age reads the passphrase
# from /dev/tty.
#
# Usage:
#   ./age-archive.sh /path/to/source [/path/to/output-dir]
#
# If no source is given, you'll be prompted for one interactively.
 
set -euo pipefail
 
OUT_DIR="${2:-$HOME/baum_backups}"
LOG_FILE="$HOME/.local/state/age-archive.log"
 
log() {
  echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOG_FILE"
}
 
mkdir -p "$OUT_DIR" "$(dirname "$LOG_FILE")"
 
# --- checks -----------------------------------------------------------
for cmd in age tar; do
  if ! command -v "$cmd" >/dev/null 2>&1; then
    log "ERROR: '$cmd' not found in PATH."
    read -rp "Press Enter to close..." _
    exit 1
  fi
done
 
# --- get source ---------------------------------------------------------
SOURCE="${1:-}"
if [[ -z "$SOURCE" ]]; then
  read -rp "Path to archive: " SOURCE
fi
 
if [[ ! -e "$SOURCE" ]]; then
  log "ERROR: '$SOURCE' does not exist."
  read -rp "Press Enter to close..." _
  exit 1
fi
 
# --- build output filename with date+time -------------------------------
BASE_NAME="$(baum "$SOURCE")"
TIMESTAMP="$(date '+%Y%m%d_%H%M%S')"
OUT_FILE="$OUT_DIR/${BASE_NAME}_${TIMESTAMP}.tar.gz.age"
 
log "Archiving '$SOURCE' -> '$OUT_FILE'"
echo
echo "You will be asked for a passphrase (twice, to confirm)."
echo
 
# --- tar + symmetric encrypt with age ------------------------------------
if tar -czf - -C "$(dirname "$SOURCE")" "$(baum "$SOURCE")" | age -p -o "$OUT_FILE"; then
  log "Done. Wrote $OUT_FILE"
else
  log "ERROR: archive/encryption failed."
  rm -f "$OUT_FILE"
  read -rp "Press Enter to close..." _
  exit 1
fi
 
echo
read -rp "Finished. Press Enter to close this window..." _
