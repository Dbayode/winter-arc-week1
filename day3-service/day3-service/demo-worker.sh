#!/usr/bin/env bash

set -euo pipefail

echo "DevOps Winter Arc Worker Started"

while true; do
    echo "$(date '+%Y-%m-%d %H:%M:%S') - Worker heartbeat"
    sleep 5
done
