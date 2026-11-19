#!/bin/sh
# id: 20
# group: DNS
# desc: DNS lookup (A, AAAA, MX, TXT, NS)

printf "  Domain: "
read domain || exit 1
[ -n "$domain" ] || { printf "  empty domain\n"; exit 1; }

for type in A AAAA MX TXT NS; do
  printf "...%s records for %s\n" "$type" "$domain"
  dig +short "$domain" "$type"
  printf "\n"
done
