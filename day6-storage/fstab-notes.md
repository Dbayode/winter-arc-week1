# Day 6 — fstab notes (example only)

`/etc/fstab` describes filesystems to mount. A sample line for a dedicated lab disk might be:

```fstab
UUID=<LAB-FILESYSTEM-UUID>  /mnt/winter-arc-data  ext4  defaults,nofail  0  2
```

**Do not paste this placeholder into a real `/etc/fstab`.** Replace it only after identifying a safe lab filesystem with `lsblk -f` and `blkid`, creating the mountpoint, and reviewing mount options. `nofail` can reduce boot disruption when optional disks are missing but does not replace validation.

## Actual test notes (fill after execution)
- Lab device / UUID:
- Mount point:
- `df -h` before:
- `df -h` after:
- `sudo mount -a` result:
- Rollback procedure:
