#!/usr/bin/env bash
set -euo pipefail
url="${1:-http://127.0.0.1:8080/}"
if curl --silent --show-error --fail --location --max-time 5 --output /dev/null "$url"; then
  printf 'HEALTHY %s
' "$url"
else
  printf 'UNHEALTHY %s
' "$url" >&2
  exit 1
fi
