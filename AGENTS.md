# AGENTS.md — net_tools

## What this is
A collection of small network diagnostic tools behind a single task-runner
menu (`ask.sh` + `ask.d/*.sh`). No build, no install; POSIX `sh` + `curl`
+ `dig` + `python3` + `openssl`. Public repo (`github.com:veto8/net_tools`),
AGPL-3.0.

## Structure
```
net_tools/
  ask.sh            task switch (menu + dispatch, metadata-driven)
  ask.d/            one script per task, `# id:` / `# group:` / `# desc:` headers
  net_tools.svg     logo
  README.md         task table + requirements
  LICENSE           AGPL-3.0
```

## Conventions
- Menu is metadata-driven: `list_tasks` walks `ask.d/*.sh`, reads `# id:`
  /`# group:`/`# desc:`, groups ranked by `group_rank()`. Adding a task = one
  new file in `ask.d/` with the header — no edits to `ask.sh`.
- Tasks are interactive: prompt for host/domain/URL, then run. No background
  state, no daemons.
- No credentials, no internal IPs, no internal hostnames — this is a public repo.
- Keep task scripts `sh`-portable (POSIX, `#!/bin/sh`), not bashisms.
- No tests, no build, no CI.
- Never commit. The user runs git.
