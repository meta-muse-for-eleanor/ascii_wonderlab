# Changelog

## 1.0.0 - 2026-11-06

- Four modes: seeded mazes with an optional drawn solution, Mandelbrot
  and Julia fractals, passphrases drawn from `/dev/urandom` with an
  entropy report, and a fortune that is deterministic per seed.
- Binary SHA-256
  `83730a7131dbb21c23bf37a52c3e71235fe8402e86a9a1576c553edcf6cf16d2`,
  reproducible from two clean builds recorded in `provenance.json`.
- Release signing introduced: `SHA256SUMS.txt` is signed with the
  release key in `keys/wonderlab-release.asc`, fingerprint
  `5D61 8346 092F 2C27 F609 5597 B187 898A 6EFA 8024`.
- Added `verify.sh`, `README.md`, `SECURITY.md` and `BEHAVIOUR.md`.
