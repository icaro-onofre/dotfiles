#!/usr/bin/env bash
#
# backup-keys.sh
#
# Exports all GPG secret keys (plus public keys and ownertrust) and copies
# ~/.ssh into a single tarball, encrypted symmetrically with `age -p`.
# You'll be prompted for the age passphrase (twice) on the terminal, and
# gpg may ask for your key passphrase via pinentry.
#
# Usage:
#   ./backup-keys.sh [output-file]
#
# Default output: ./keys_<timestamp>.tar.gz.age
#
# Restore:
#   age -d keys_XXXX.tar.gz.age | tar -xzf - -C /tmp/restore
#   gpg --import /tmp/restore/gpg/secret-keys.asc
#   gpg --import-ownertrust /tmp/restore/gpg/ownertrust.txt
#   cp -a /tmp/restore/.ssh/. ~/.ssh/

set -euo pipefail
umask 077

SSH_DIR="${SSH_DIR:-$HOME/.ssh}"
OUT_FILE="${1:-$PWD/keys_$(date '+%Y%m%d_%H%M%S').tar.gz.age}"

die() { echo "ERROR: $*" >&2; exit 1; }

# --- checks -----------------------------------------------------------
for cmd in age gpg tar; do
  command -v "$cmd" >/dev/null 2>&1 || die "'$cmd' not found in PATH."
done
[[ -d "$SSH_DIR" ]] || die "'$SSH_DIR' does not exist."
[[ -e "$OUT_FILE" ]] && die "'$OUT_FILE' already exists, refusing to overwrite."
gpg --list-secret-keys --with-colons 2>/dev/null | grep -q '^sec' \
  || die "no GPG secret keys found."

# --- staging dir (prefer tmpfs so plaintext keys never hit disk) --------
STAGE_PARENT="${XDG_RUNTIME_DIR:-/dev/shm}"
[[ -d "$STAGE_PARENT" && -w "$STAGE_PARENT" ]] || STAGE_PARENT="${TMPDIR:-/tmp}"
STAGE="$(mktemp -d "$STAGE_PARENT/keys-backup.XXXXXX")"

cleanup() {
  if command -v shred >/dev/null 2>&1; then
    find "$STAGE" -type f -exec shred -u {} + 2>/dev/null || true
  fi
  rm -rf "$STAGE"
}
trap cleanup EXIT
trap 'rm -f "$OUT_FILE"; exit 1' INT TERM

# --- export gpg ---------------------------------------------------------
mkdir "$STAGE/gpg"
echo "Exporting GPG keys (pinentry may ask for your key passphrase)..."
gpg --armor --export-secret-keys > "$STAGE/gpg/secret-keys.asc"
gpg --armor --export             > "$STAGE/gpg/public-keys.asc"
gpg --export-ownertrust          > "$STAGE/gpg/ownertrust.txt"
[[ -s "$STAGE/gpg/secret-keys.asc" ]] || die "gpg secret key export is empty."

# --- tar + encrypt ------------------------------------------------------
echo
echo "Encrypting to '$OUT_FILE'"
echo "You will be asked for a passphrase (twice, to confirm)."
echo

# Sockets (e.g. ~/.ssh/agent/*) can't be archived, so skip them.
if tar -czf - \
     -C "$STAGE" gpg \
     -C "$(dirname "$SSH_DIR")" --exclude="$(basename "$SSH_DIR")/agent" "$(basename "$SSH_DIR")" \
   | age -p -o "$OUT_FILE"; then
  echo "Done. Wrote $OUT_FILE"
else
  rm -f "$OUT_FILE"
  die "archive/encryption failed."
fi
