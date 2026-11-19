#!/bin/sh
# id: 11
# group: WEB
# desc: Cloudflare proxy check (orange/grey cloud)

printf "  Domain (e.g. www.example.com): "
read domain || exit 1
[ -n "$domain" ] || { printf "  empty domain\n"; exit 1; }

printf "...public DNS (dns.google)\n"
curl -s "https://dns.google/resolve?name=$domain&type=A" | python3 -c '
import json, sys
try:
    data = json.load(sys.stdin)
except Exception:
    print("  (unexpected response)")
    sys.exit(0)
for a in data.get("Answer", []):
    print(f"  {a.get(\"name\")} -> {a.get(\"data\")}")
'

printf "...headers (curl -sI)\n"
curl -s -I --max-time 15 "https://$domain/" | grep -iE 'cf-ray|cf-cache-status|server:' || printf "  (no Cloudflare headers)\n"

ip=$(curl -s "https://dns.google/resolve?name=$domain&type=A" | python3 -c '
import json, sys
try:
    data = json.load(sys.stdin)
except Exception:
    sys.exit(0)
for a in data.get("Answer", []):
    if a.get("type") == 1:
        print(a.get("data"))
        break
')
[ -n "$ip" ] && python3 - "$ip" <<'EOF'
import ipaddress, sys
ip = ipaddress.ip_address(sys.argv[1])
cf = [
 '173.245.48.0/20','103.21.244.0/22','103.22.200.0/22','103.31.4.0/22','141.101.64.0/18',
 '108.162.192.0/18','190.93.240.0/20','188.114.96.0/20','197.234.240.0/22','198.41.128.0/17',
 '162.158.0.0/15','104.16.0.0/13','104.24.0.0/14','172.64.0.0/13','131.0.72.0/22',
]
for r in cf:
    if ip in ipaddress.ip_network(r):
        print(f"  {ip} is a Cloudflare IP -> proxied (orange cloud)")
        break
else:
    print(f"  {ip} is NOT a Cloudflare IP -> DNS-only (grey cloud) / direct origin")
EOF
