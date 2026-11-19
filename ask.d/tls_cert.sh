#!/bin/sh
# id: 12
# group: WEB
# desc: TLS certificate info (expiry, issuer, subject)

printf "  Domain (e.g. www.example.com): "
read domain || exit 1
[ -n "$domain" ] || { printf "  empty domain\n"; exit 1; }

printf "...openssl s_client to %s:443\n" "$domain"
echo | openssl s_client -connect "$domain:443" -servername "$domain" 2>/dev/null \
  | openssl x509 -noout -subject -issuer -dates -serial 2>/dev/null \
  || printf "  TLS handshake failed (domain unreachable, or TLS on another port)\n"
