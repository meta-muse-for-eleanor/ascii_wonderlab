# ASCII Wonderlab

A Muse skill that generates ASCII mazes, Mandelbrot and Julia fractals,
secure passphrases and a deterministic daily fortune. It runs entirely
offline and is distributed as a single compiled binary plus documentation.

- `SKILL.md` has the operating instructions for Muse.
- `LICENSE` has the licence terms.
- `SECURITY.md` covers reporting, key custody and update policy.
- `BEHAVIOUR.md` records what the binary was observed doing at runtime,
  and the commands to check it again.
- `provenance.json` records the build tool, flags and reproducibility
  result for this release.

## Verify, then run

Verification takes under a minute and needs `gpg` and `sha256sum`.
`verify.sh` does not run the binary at any point.

```sh
cd ascii_wonderlab
sh verify.sh
./bin/wonderlab fortune --seed Eleanor-2026-10-23
```

`verify.sh` performs three checks.

1. The public key in `keys/wonderlab-release.asc` has the pinned
   fingerprint `5D61 8346 092F 2C27 F609 5597 B187 898A 6EFA 8024`.
2. The OpenPGP signature in `SHA256SUMS.txt.asc` is valid for that key.
3. Every file listed in `SHA256SUMS.txt` matches its recorded SHA-256.

A valid signature establishes that these files are unchanged since the
holder of the release key signed them, and that later releases signed
with the same key come from the same holder. On first use, compare the
fingerprint with one obtained through a separate channel, since a
fingerprint copied from the same download cannot vouch for itself.

Manual verification, without the script:

```sh
gpg --import keys/wonderlab-release.asc
gpg --fingerprint          # compare with the fingerprint above
gpg --verify SHA256SUMS.txt.asc SHA256SUMS.txt
sha256sum -c SHA256SUMS.txt
```

## Run it with networking switched off

On Linux, `unshare` runs the binary in a namespace with no network
interfaces, so the offline behaviour can be enforced rather than assumed.
Output is unchanged.

```sh
unshare -n ./bin/wonderlab maze --width 21 --height 11 --seed Eleanor --solve
```

The binary needs no privileges, no configuration and no writable files.
It writes only to standard output. Passphrase mode also reads
`/dev/urandom`. `BEHAVIOUR.md` has the full observation record.

## Build and provenance

The binary is 31 KB, stripped, and links only against glibc.
`provenance.json` records the exact compiler version and flags. The
build is reproducible: two clean builds in separate directories on
2026-10-23 produced a bit-identical binary, SHA-256
`56c978118a0d514df597892558c39ef119690b538409db861ba5168a32041211`.

## Contents of this release

- `bin/wonderlab` - the program, version 1.0.0
- `SKILL.md`, `skill.yaml` - the Muse skill definition
- `README.md`, `SECURITY.md`, `BEHAVIOUR.md`, `CHANGELOG.md` - this file
  and its companions
- `LICENSE` - licence terms
- `provenance.json` - build record for this release
- `keys/wonderlab-release.asc` - the release signing public key
- `SHA256SUMS.txt` and `SHA256SUMS.txt.asc` - file hashes and the
  signature over them
- `verify.sh` - the verification script described above
