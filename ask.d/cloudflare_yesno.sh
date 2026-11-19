#!/bin/sh
# id: 14
# group: WEB
# desc: Cloudflare proxy yes/no (verdict only)

printf "  Domain (e.g. www.example.com): "
read domain || exit 1
[ -n "$domain" ] || { printf "  empty domain\n"; exit 1; }

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
if [ -z "$ip" ]; then
  printf "  NO ANSWER from public resolver\n"
  exit 1
fi
python3 - "$ip" "$domain" <<'EOF'
import ipaddress, sys
ip = ipaddress.ip_address(sys.argv[1])
domain = sys.argv[2]
cf = [
 '173.245.48.0/20','103.21.244.0/22','103.22.200.0/22','103.31.4.0/22','141.101.64.0/18',
 '108.162.192.0/18','190.93.240.0/20','188.114.96.0/20','197.234.240.0/22','198.41.128.0/17',
 '162.158.0.0/15','104.16.0.0/13','104.24.0.0/14','172.64.0.0/13','131.0.72.0/22',
]
for r in cf:
    if ip in ipaddress.ip_network(r):
        print(f"  {domain} is PROXIED (Cloudflare, {ip})")
        break
else:
    print(f"  {domain} is DNS-ONLY (direct origin, {ip})")
EOF
