#!/bin/sh
# id: 10
# group: WEB
# desc: HTTP response headers (curl -sI)

printf "  URL (e.g. http://example.com): "
read url || exit 1
[ -n "$url" ] || { printf "  empty URL\n"; exit 1; }

printf "...curl -sI %s\n" "$url"
curl -s -I --max-time 15 "$url"
