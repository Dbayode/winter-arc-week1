#!/usr/bin/env bash
set -euo pipefail
printf '
== Disk usage ==
'; df -h
printf '
== Filesystems ==
'; lsblk -f
printf '
== Memory ==
'; free -h
printf '
== Largest log subdirectories (if accessible) ==
'
du -h -d 1 /var/log 2>/dev/null | sort -h | tail -n 10 || true
