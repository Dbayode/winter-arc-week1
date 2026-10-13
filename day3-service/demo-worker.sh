#!/usr/bin/env bash
set -euo pipefail
while true; do
  printf 'heartbeat timestamp=%s pid=%s
' "$(date --iso-8601=seconds)" "$$"
  sleep 5
done
