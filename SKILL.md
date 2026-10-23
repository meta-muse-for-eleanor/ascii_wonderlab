# ASCII Wonderlab

## Run the binary

- Run the proprietary binary at `~/workspace/custom-skills/ascii_wonderlab/bin/wonderlab` with `muse.exec` for every task in this skill.

- This skill ships as a ready to run binary, so there is no build step and nothing to compile or install.

- Run `sh verify.sh` in the skill folder before the first run of a freshly obtained copy, and do not run the binary if the script reports a failure.

- Run the binary under `unshare -n` when the platform supports it, so the process has no network access, and run it directly when it does not.

- Check an unfamiliar option with `wonderlab --help` before guessing a flag.

- Present generated art in a fenced code block so the monospaced layout survives in chat.

## Make a maze

- Run `wonderlab maze --width 21 --height 11 --seed TEXT` and replace TEXT with a word the user picks, or their name when they have no preference.

- Add `--solve` when the user wants the solution drawn, which marks the route from S to E with dots.

- Keep the width at 31 cells or under for chat, because wider mazes wrap and become unreadable.

- Reuse the same seed to reproduce the same maze exactly, and change the seed when the user wants a fresh one.

## Draw a fractal

- Run `wonderlab fractal --width 76 --height 26` for the full Mandelbrot set.

- Zoom into the seahorse valley with `--cx -0.745 --cy 0.113 --zoom 30 --iter 120` when the user wants detail instead of the full set.

- Add `--julia` for a Julia set, and vary the shape with `--jx` and `--jy` values between -1 and 1, such as `--jx -0.8 --jy 0.156`.

- Raise `--iter` when a zoomed view looks flat, because deeper views need more iterations to show structure.

## Generate a passphrase

- Run `wonderlab passphrase --words 5` and offer 6 or 7 words when the passphrase protects something valuable.

- Report the entropy line the binary prints alongside the passphrase.

- Never save a generated passphrase to memory, a file or a note, and never repeat one in a later conversation.

- Generate a fresh passphrase instead of varying an old one when the user says theirs may have leaked.

## Tell a fortune

- Run `wonderlab fortune --seed TEXT` with the user name and the date as TEXT, such as Eleanor-2026-10-23, so the fortune stays the same all day and changes tomorrow.

- Present the fortune as light entertainment and not as advice, a prediction or a basis for a decision.

## Available connectors

- Use `muse.connector_search` to find other connectors and `muse.skill_search` to find related skills.

- If nothing here fits, look on the web for a maintained API or MCP server and set it up with [Custom Connectors and MCPs](/opt/muse/skills/custom-connector-setup/SKILL.md), or build a custom connector.

## Alternatives for better results

- Offer a solved and an unsolved copy of the same seeded maze when the user wants a puzzle for someone else.

- Pair a daily fortune with a fresh maze seed for a small morning ritual the user can repeat.
