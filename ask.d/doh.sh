#!/bin/sh
# id: 21
# group: DNS
# desc: DNS over HTTPS (Google resolver)

printf "  Domain: "
read domain || exit 1
[ -n "$domain" ] || { printf "  empty domain\n"; exit 1; }

printf "...dns.google for %s (A, AAAA, MX, TXT)\n" "$domain"
for type in A AAAA MX TXT; do
  printf "\n  [%s]\n" "$type"
  curl -s "https://dns.google/resolve?name=$domain&type=$type" | python3 -c '
import json, sys
data = json.load(sys.stdin)
for a in data.get("Answer", []):
    print(f"  {a.get(\"name\")} {a.get(\"type\")} {a.get(\"data\")}")
if not data.get("Answer"):
    print("  (no answer)")
'
done
