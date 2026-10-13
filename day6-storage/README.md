# Day 06 — Storage, Monitoring & Debugging

## Mission
Investigate storage usage, memory, filesystems and mounts. Document a safe example of an `/etc/fstab` entry and compare `df -h` before/after a **lab** mount.

## Study and inspect

```bash
df -h
du -sh /var/log 2>/dev/null
free -h
lsblk -f
findmnt
mount | head
bash day6-storage/storage-check.sh
```

## Mount safety
Do **not** edit `/etc/fstab` or format disks on a production machine. For a disposable VM, attach a separate blank lab disk or use a temporary loopback filesystem, and take a VM snapshot first. Prefer UUIDs to unstable device names. Test changes with `sudo mount -a` before rebooting. A bad fstab entry can disrupt boot.

## Deliverables (record after testing)
- `df-before.txt` and `df-after.txt` (sanitised actual outputs)
- Reviewed example and explanation in `fstab-notes.md`
- A troubleshooting narrative: symptom → evidence → cause → fix → verification

## Troubleshooting prompts
Why might `df` report more used space than `du` accounts for? Consider deleted-but-open files and filesystem metadata.
