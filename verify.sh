#!/bin/sh
# Verify this release before running the binary.
# Checks the OpenPGP signature on SHA256SUMS.txt against the pinned release
# key fingerprint, then checks every file listed in SHA256SUMS.txt.
# This script never runs bin/wonderlab.
set -eu
cd "$(dirname "$0")"

EXPECTED_FPR="5D618346092F2C27F6095597B187898A6EFA8024"
KEY="keys/wonderlab-release.asc"

command -v gpg >/dev/null 2>&1 || { echo "verify: gpg is required" >&2; exit 1; }
command -v sha256sum >/dev/null 2>&1 || { echo "verify: sha256sum is required" >&2; exit 1; }
[ -f "$KEY" ] || { echo "verify: $KEY is missing" >&2; exit 1; }
[ -f SHA256SUMS.txt.asc ] || { echo "verify: SHA256SUMS.txt.asc is missing" >&2; exit 1; }

TMPHOME="$(mktemp -d)"
trap 'rm -rf "$TMPHOME"' EXIT INT TERM
export GNUPGHOME="$TMPHOME/gnupg"
mkdir -m 700 "$GNUPGHOME"

gpg --quiet --import "$KEY"
ACTUAL_FPR="$(gpg --list-keys --with-colons | awk -F: '/^fpr/{print $10; exit}')"
if [ "$ACTUAL_FPR" != "$EXPECTED_FPR" ]; then
  echo "verify: FAILED - key fingerprint is $ACTUAL_FPR" >&2
  echo "verify: expected            $EXPECTED_FPR" >&2
  exit 1
fi
echo "verify: release key fingerprint matches the pinned fingerprint"

STATUS="$(gpg --status-fd 1 --verify SHA256SUMS.txt.asc SHA256SUMS.txt 2>/dev/null || true)"
case "$STATUS" in
  *"[GNUPG:] VALIDSIG $EXPECTED_FPR"*) echo "verify: signature on SHA256SUMS.txt is valid" ;;
  *) echo "verify: FAILED - signature on SHA256SUMS.txt did not validate" >&2; exit 1 ;;
esac

sha256sum -c SHA256SUMS.txt
echo "verify: OK - this release is intact and signed by the pinned release key"
echo "verify: on first use, confirm the fingerprint through a separate channel:"
echo "        5D61 8346 092F 2C27 F609 5597 B187 898A 6EFA 8024"
