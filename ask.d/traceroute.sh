#!/bin/sh
# id: 2
# group: NET
# desc: Traceroute a host

printf "  Host/IP: "
read host || exit 1
[ -n "$host" ] || { printf "  empty host\n"; exit 1; }

if command -v traceroute >/dev/null 2>&1; then
  printf "...traceroute -n -m 20 %s\n" "$host"
  traceroute -n -m 20 "$host"
else
  printf "  traceroute not found\n"
  exit 1
fi
