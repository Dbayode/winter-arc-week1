# Day 06 — Linux Storage, Monitoring & Troubleshooting

## Project Overview

This project explores Linux storage management,
filesystem mounting, resource monitoring,
and troubleshooting.

It is part of my 90-Day DevOps Winter Arc.

## Learning Objectives

- Inspect disks and partitions.
- Understand Linux filesystems.
- Understand mount points and /etc/fstab.
- Monitor disk usage.
- Monitor CPU and memory.
- Build a Bash monitoring script.
- Troubleshoot resource problems.

## Technologies

- Ubuntu Linux
- Bash
- ext4
- Linux system utilities
- Git and GitHub

## Project Structure

```text
day6-storage/
├── README.md
├── health-check.sh
├── fstab-example.txt
├── df-before.txt
├── df-after.txt
└── troubleshooting.md
```

## Storage Commands

```bash
df -h
lsblk -f
findmnt
sudo du -sh /var/log
```

## Monitoring Commands

```bash
free -h
top
uptime
ps aux --sort=-%cpu
```

## Run the Monitoring Script

```bash
chmod +x health-check.sh
./health-check.sh
```

## Troubleshooting

See `troubleshooting.md`.

## Key Takeaway

Monitoring and storage management are essential
for maintaining reliable Linux infrastructure.
