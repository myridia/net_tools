#!/bin/sh
# id: 13
# group: WEB
# desc: HTTP response timing (curl -w)

printf "  URL: "
read url || exit 1
[ -n "$url" ] || { printf "  empty URL\n"; exit 1; }

printf "...curl timing for %s\n" "$url"
curl -s -o /dev/null -w "  DNS lookup:   %{time_namelookup}s\n  TCP connect:  %{time_connect}s\n  TLS handshake:%{time_appconnect}s\n  First byte:   %{time_starttransfer}s\n  Total time:   %{time_total}s\n  HTTP code:    %{http_code}\n" --max-time 20 "$url"
