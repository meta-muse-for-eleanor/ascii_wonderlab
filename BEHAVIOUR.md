# Observed behaviour

Recorded on 2026-10-23 for the binary in this release, SHA-256
`56c978118a0d514df597892558c39ef119690b538409db861ba5168a32041211`.

## Method

Each mode was run once under `strace`, tracing network calls, file opens
and process execution.

```sh
strace -f -e trace=network,openat,execve -o trace.out \
  ./bin/wonderlab MODE [options]
```

Dynamic linking, which the loader performs before the program starts:

```sh
ldd ./bin/wonderlab
# libc.so.6 and the standard loader only. No other libraries.
```

## Results

- All four modes: no `socket`, `connect`, `bind`, `sendto` or `recvfrom`
  calls.
- All four modes: one `execve`, the program itself. It starts no child
  processes.
- Maze, fractal and fortune modes: no files opened by the program. The
  only opens in the trace belong to the dynamic loader.
- Passphrase mode: one file opened, `/dev/urandom`, read only.
- All four modes: output written to standard output only. Nothing was
  written to any file.
- The only file path embedded in the binary is `/dev/urandom`.
  Word list and fortune text are embedded as data and are visible with
  `strings`.

## Checking again

The trace above takes a few seconds to repeat on any copy. A network
namespace gives the same guarantee by construction:

```sh
unshare -n ./bin/wonderlab fortune --seed check
```

Run in a network namespace on 2026-10-23, all four modes produced their
normal output.
