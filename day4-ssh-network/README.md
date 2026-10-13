# Day 04 — Networking & SSH

## Mission
Inspect interfaces, routes, DNS and listening ports; connect to a VM using SSH keys; troubleshoot connection failures.

## Study and practise

```bash
ip -br addr
ip route
ss -tulpen
getent hosts example.com
ping -c 3 1.1.1.1
ssh -V
```

Generate a key **only if you do not already have one**; never overwrite an existing private key:

```bash
ssh-keygen -t ed25519 -f ~/.ssh/winter_arc_lab -C 'winter-arc-lab'
```

Copy the public key to a VM you control using `ssh-copy-id -i ~/.ssh/winter_arc_lab.pub USER@HOST` where appropriate. Never commit the private key. Edit `~/.ssh/config` using the template in `ssh-config.example`, then connect using `ssh winter-arc-lab`.

## Troubleshooting notes
- **Connection refused:** host responded but the target port is not accepting the connection (or actively rejected it). Check `ss`, service status and firewall rules.
- **Connection timed out:** no timely response; check routing, security groups, firewall drops, host reachability and IP address.
- **Permission denied (publickey):** verify username, key selection, server `authorized_keys` and permissions.

## Evidence to add
Redacted `~/.ssh/config` entry, relevant commands, observations, and one diagnosed connectivity problem.
