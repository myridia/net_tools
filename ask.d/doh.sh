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
  curl -s "https://dns.google/resolve?name=$domain&type=$type" > /tmp/nettools_doh.json
  python3 - /tmp/nettools_doh.json <<'EOF'
import json, sys
data = json.load(open(sys.argv[1]))
for a in data.get("Answer", []):
    print("  " + a.get("name") + " " + str(a.get("type")) + " " + a.get("data"))
if not data.get("Answer"):
    print("  (no answer)")
EOF
done
rm -f /tmp/nettools_doh.json
