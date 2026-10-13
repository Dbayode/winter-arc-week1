# Day 03 — Processes, Services & Logs

## Mission
Create a worker that logs a heartbeat every five seconds, run it under systemd, intentionally break `ExecStart`, diagnose the failure, then restore it.

## Study
`ps`, `top`, `pgrep`, `kill`, `systemctl`, `journalctl`, exit codes, service users, `Restart=`.

## Setup (VM only)

```bash
sudo install -m 755 day3-service/demo-worker.sh /usr/local/bin/demo-worker.sh
sudo install -m 644 day3-service/demo-worker.service /etc/systemd/system/demo-worker.service
sudo systemctl daemon-reload
sudo systemctl enable --now demo-worker
systemctl status demo-worker --no-pager
journalctl -u demo-worker -n 15 --no-pager
```

## Troubleshooting exercise
Change the unit's `ExecStart` path to a nonexistent file, run `sudo systemctl daemon-reload`, then `sudo systemctl restart demo-worker`. Capture `systemctl status` and `journalctl -u demo-worker` output. Restore the correct path, reload, restart, and verify.

## Evidence (create after the lab)
- Failing status output, with sensitive details removed
- Two-line root cause and fix
- Successful status and heartbeat logs

## Cleanup

```bash
sudo systemctl disable --now demo-worker
```
