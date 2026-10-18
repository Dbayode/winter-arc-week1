#!/usr/bin/env bash

set -euo pipefail

# DevOps Winter Arc — Day 06
# Linux System Health Monitoring Script

CPU_THRESHOLD=80
MEM_THRESHOLD=80
DISK_THRESHOLD=85

LOG_FILE="${HOME}/winter-arc-health.log"

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# CPU utilisation over a one-second interval.
read -r CPU_IDLE < <(
    top -bn2 -d 1 | awk '
        /Cpu\(s\)/ {
            idle=$8
        }
        END {
            print idle
        }
    '
)

CPU_USAGE=$(awk -v idle="$CPU_IDLE" \
    'BEGIN { printf "%.0f", 100 - idle }')

# Memory usage based on MemAvailable.
MEM_USAGE=$(free | awk '
    /^Mem:/ {
        printf "%.0f", (($2 - $7) / $2) * 100
    }
')

# Root filesystem usage.
DISK_USAGE=$(df -P / | awk '
    NR==2 {
        gsub("%", "", $5)
        print $5
    }
')

check_metric() {
    local metric_name="$1"
    local usage="$2"
    local threshold="$3"

    if (( usage >= threshold )); then
        echo "[ALERT] ${metric_name}: ${usage}% (threshold: ${threshold}%)"
    else
        echo "[OK] ${metric_name}: ${usage}%"
    fi
}

{
    echo "========================================"
    echo "System Health Report"
    echo "Timestamp: $TIMESTAMP"
    echo "Hostname: $(hostname)"
    echo "========================================"

    check_metric "CPU" "$CPU_USAGE" "$CPU_THRESHOLD"
    check_metric "Memory" "$MEM_USAGE" "$MEM_THRESHOLD"
    check_metric "Disk" "$DISK_USAGE" "$DISK_THRESHOLD"

    echo
} | tee -a "$LOG_FILE"
