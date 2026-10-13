#!/usr/bin/env bash
set -euo pipefail
# LAB ONLY: changes local users/groups and /opt/shared-app on this VM.
[[ $EUID -eq 0 ]] || { echo 'Run with sudo' >&2; exit 1; }
getent group devs >/dev/null || groupadd devs
for user in alice bob viewer; do
  id "$user" &>/dev/null || useradd -m -s /bin/bash "$user"
done
usermod -aG devs alice
usermod -aG devs bob
install -d -o root -g devs -m 2775 /opt/shared-app
# Files: developers can write, everyone else can read.
if [[ ! -e /opt/shared-app/README.txt ]]; then
  printf 'Shared application lab directory
' > /opt/shared-app/README.txt
fi
chown root:devs /opt/shared-app/README.txt
chmod 664 /opt/shared-app/README.txt
printf 'Configured devs group and shared directory. Verify with id and ls -ld.
'
