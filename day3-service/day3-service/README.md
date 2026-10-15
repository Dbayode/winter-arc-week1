# Day 03 — Linux Processes, Services & Logs

## Project Overview

This project demonstrates how to create, deploy, manage,
monitor, and troubleshoot a Linux background service using
Bash and systemd.

## Objectives

- Understand Linux processes and process IDs.
- Monitor running processes using ps, top, and htop.
- Create a Bash background worker.
- Configure a systemd service.
- Enable automatic service startup.
- Monitor service logs using journalctl.
- Troubleshoot and recover a failed service.

## Environment

- Operating System: Ubuntu Linux
- Shell: Bash
- Service Manager: systemd
- Logging: journalctl

## Project Files

- demo-worker.sh — Bash background worker.
- demo-worker.service — systemd service configuration.

## Implementation

### 1. Create the Background Worker

Created a Bash script that generates a timestamped
heartbeat every five seconds.

### 2. Configure systemd

Configured a service to manage the worker automatically.

The service uses:

- An unprivileged execution account.
- Automatic restart on failure.
- A five-second restart delay.
- Automatic startup at boot.

### 3. Install and Start the Service

```bash
sudo install -m 755 demo-worker.sh /usr/local/bin/demo-worker.sh
sudo install -m 644 demo-worker.service /etc/systemd/system/demo-worker.service
sudo systemctl daemon-reload
sudo systemctl start demo-worker
sudo systemctl enable demo-worker
```

### 4. Verify the Service

```bash
systemctl is-active demo-worker
systemctl is-enabled demo-worker
```

### 5. Monitor Logs

```bash
sudo journalctl -u demo-worker -n 20 --no-pager
```

## Troubleshooting Exercise

### Problem

The service failed after its executable path was
changed to a nonexistent file.

### Investigation

```bash
sudo systemctl status demo-worker
sudo journalctl -u demo-worker -n 30
systemctl cat demo-worker
```

### Root Cause

The ExecStart directive referenced an invalid path.

### Resolution

Restored the correct executable path, reloaded systemd,
and restarted the service.

### Verification

```bash
systemctl is-active demo-worker
```

Expected result: active.

## Skills Developed

- Linux process management
- Bash scripting
- systemd service administration
- Service monitoring
- Log investigation
- Troubleshooting and recovery

## Key Takeaway

Understanding Linux processes and services is essential
for maintaining reliable applications and troubleshooting
production environments.
