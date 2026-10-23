# Security

## Reporting a problem

Report a defect or a security concern to the person or channel that
provided this release, and include the output of `sh verify.sh` and the
SHA-256 of the binary you ran.

## Release key

- Releases are signed with an Ed25519 OpenPGP key, fingerprint
  `5D61 8346 092F 2C27 F609 5597 B187 898A 6EFA 8024`, expiring
  2029-10-22.
- The public key ships in `keys/wonderlab-release.asc`. The private key
  is not in this repository. It is held separately from the release, and
  a revocation certificate was generated with the key and stored with it.
- Every release is signed with this key, so a later release that
  verifies against it comes from the same key holder as this one.
- If the signing key ever changes, the new fingerprint will be announced
  alongside the old key's signature over the new key. Until then, treat
  a release signed by a different key as coming from a different source.

## What the program needs

- No elevated privileges, and it is not setuid.
- No network access. Run it under `unshare -n` on Linux to enforce this.
- No writable files, configuration or account.
- One read at runtime, in passphrase mode only: `/dev/urandom`.

## Updating

Download the new release in full, run `sh verify.sh` in the new copy,
and check `CHANGELOG.md` for what changed, including any change to the
binary's recorded SHA-256 in `provenance.json`. Keep the previous
verified copy until the new one passes.

## Scope of the checks in this repository

`BEHAVIOUR.md` records observations made with `strace` on 2026-10-23.
Those observations describe that build on that day. The signed hashes
and reproducible build record in `provenance.json` are what tie any
later copy back to the build that was observed.
