#!/usr/bin/env bash

set -u

WEB_URL="http://127.0.0.1:8085"
API_URL="${WEB_URL}/api/health"
BACKEND_URL="http://127.0.0.1:5000/api/health"

echo "===================================="
echo "DAY 07 - LINUX INCIDENT DIAGNOSTICS"
echo "===================================="

echo "Date: $(date -Is)"
echo "Hostname: $(hostname)"
echo

echo "[1] System Uptime"
uptime
echo

echo "[2] Disk Usage"
df -h /
echo

echo "[3] Memory Usage"
free -h
echo

echo "[4] Nginx Service"
systemctl is-active nginx || true
echo

echo "[5] Nginx Configuration"
sudo nginx -t
echo

echo "[6] Listening Ports"
ss -tlnp | grep -E ':(5000|8085)\b' || true
echo

echo "[7] Static Website"
curl -sS -o /dev/null \
    -w "HTTP Status: %{http_code}\n" \
    --max-time 5 "$WEB_URL/"
echo

echo "[8] Backend Application"
curl -sS -o /dev/null \
    -w "HTTP Status: %{http_code}\n" \
    --max-time 5 "$BACKEND_URL"
echo

echo "[9] Reverse Proxy Endpoint"
curl -sS -o /dev/null \
    -w "HTTP Status: %{http_code}\n" \
    --max-time 5 "$API_URL"
echo

echo "[10] Recent Nginx Errors"
sudo tail -n 15 /var/log/nginx/myapp-error.log

echo
echo "Diagnostics completed."
