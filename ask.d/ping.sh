#!/bin/sh
# id: 1
# group: NET
# desc: Ping a host

printf "  Host/IP: "
read host || exit 1
[ -n "$host" ] || { printf "  empty host\n"; exit 1; }

printf "...ping -c 4 %s\n" "$host"
ping -c 4 -W 2 "$host"
