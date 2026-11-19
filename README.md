<img src="net_tools.svg" alt="net_tools" width="120">
# net_tools

A collection of small network diagnostic and inspection tools, bundled behind a
single task-runner menu (`./ask.sh`). Nothing to build, nothing to install — POSIX
`sh`, `curl`, `dig`, `python3`, `openssl`.

## The menu

`./ask.sh` shows the menu; each task lives in `ask.d/*.sh` with a
`# id:` / `# group:` / `# desc:` header. Tasks prompt for the target host/domain.

| Group | ID | What it does |
|-------|----|--------------|
| NET   | 1  | Ping a host |
| NET   | 2  | Traceroute to a host |
| NET   | 3  | Check common TCP ports on a host |
| WEB   | 10 | HTTP response headers (`curl -sI`) |
| WEB   | 11 | Cloudflare proxy check — public DNS + headers + IP-range verdict |
| WEB   | 12 | TLS certificate info (subject, issuer, dates) |
| WEB   | 13 | HTTP response timing (DNS / connect / TLS / first byte / total) |
| WEB   | 14 | Cloudflare proxy yes/no (verdict only) |
| DNS   | 20 | DNS lookup (A, AAAA, MX, TXT, NS) |
| DNS   | 21 | DNS over HTTPS (Google resolver) |

## Requirements

- `sh`, `curl`, `dig`, `python3`, `openssl`, `ping`, `traceroute` (optional for task 2)
- Linux or macOS; Windows via a POSIX shell (e.g. WSL/Git Bash)

## Why

Quick, readable network diagnosis from one menu — nothing hidden, no daemons, no
background traffic. Every task prints exactly what it probes.

## License

AGPL-3.0 — see `LICENSE`.
