#!/bin/sh
# id: 4
# group: NET
# desc: Port scan (nmap -sT if available, else TCP connect)

printf "  Host/IP: "
read host || exit 1
[ -n "$host" ] || { printf "  empty host\n"; exit 1; }

if command -v nmap >/dev/null 2>&1; then
  printf "...nmap -v -sT %s\n" "$host"
  nmap -v -sT "$host"
else
  printf "  nmap not installed - falling back to TCP connect scan\n"
  python3 - "$host" <<'EOF'
import socket, sys
host = sys.argv[1]
ports = [21,22,23,25,53,80,110,143,443,445,465,587,993,995,1433,1521,2049,3306,5432,5900,6379,8000,8080,8443,8880,8888,9000,9200,27017]
for p in ports:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(2)
    try:
        s.connect((host, p))
        print(f"  {host}:{p:5} open")
    except OSError:
        pass
    finally:
        s.close()
EOF
fi
