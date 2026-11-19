#!/bin/sh
# id: 3
# group: NET
# desc: Check common TCP ports on a host

printf "  Host/IP: "
read host || exit 1
[ -n "$host" ] || { printf "  empty host\n"; exit 1; }

python3 - "$host" <<'EOF'
import socket, sys
host = sys.argv[1]
ports = [21, 22, 23, 25, 53, 80, 110, 143, 443, 465, 587, 993, 995,
         1433, 1521, 2049, 3306, 5432, 5900, 6379, 8000, 8080, 8443,
         8880, 8888, 9000, 9200, 11211, 27017]
timeout = 2
for p in ports:
    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.settimeout(timeout)
    try:
        s.connect((host, p))
        print(f"  {host}:{p:5} open")
    except (socket.timeout, ConnectionRefusedError, OSError):
        pass
    finally:
        s.close()
EOF
