# Day 02 — Users, Permissions & Bash

## Mission
Create lab users `alice`, `bob`, `viewer`, a `devs` group, and `/opt/shared-app`. Grant developers group write access; give others read-only access. Write an idempotent `setup.sh` and run it twice.

## Study
`id`, `getent`, `useradd`, `groupadd`, `usermod -aG`, `chown`, `chmod`, permission bits, setgid on directories, `umask`, Bash variables, tests and functions.

## Lab (disposable Ubuntu VM only)

```bash
sudo bash day2-users-bash/setup.sh
sudo bash day2-users-bash/setup.sh
id alice
id bob
id viewer
ls -ld /opt/shared-app
ls -l /opt/shared-app
```

Test access with `sudo -u alice ...`, `sudo -u bob ...`, and `sudo -u viewer ...`. The viewer should be able to read but not write. Do not use real account names or passwords in Git.

## Evidence to add after execution
- `id` output for each user (sanitised)
- `ls -ld /opt/shared-app`
- Proof of a successful second run
- Permission test results

## Reflection
What does directory setgid do? Why should a service normally use a dedicated, unprivileged account?
