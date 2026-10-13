# Day 01 — Linux Fundamentals & Shell

## Overview

Day 1 focuses on Linux filesystem navigation,
file management, searching, pipes, redirection
and package management.

## Objectives

- Navigate the Linux filesystem.
- Create and manage files and directories.
- Understand absolute and relative paths.
- Search files using `find` and `grep`.
- Analyse application logs.
- Use pipes and output redirection.
- Manage packages with `apt`.

## Environment

Ubuntu Linux with Bash.

## Project: Linux Application Workspace

Prepare an application workspace under `/opt/myapp`.

### Directory Structure

```text
/opt/myapp/
├── bin/
│   └── start.sh
├── config/
│   └── app.conf
├── data/
└── logs/
    ├── app.log
    └── errors.txt
```

### 1. Create the Workspace

```bash
sudo mkdir -p /opt/myapp/{bin,config,logs,data}
```

For this personal lab, give the current user ownership:

```bash
sudo chown -R "$USER:$(id -gn)" /opt/myapp
```

### 2. Create Configuration Files

```bash
printf 'port=3000\nenvironment=development\n' \
  > /opt/myapp/config/app.conf
```

### 3. Generate Application Logs

```bash
for i in $(seq 1 20); do
    echo "INFO request $i" >> /opt/myapp/logs/app.log
done
```

Add sample errors:

```bash
echo "ERROR database timeout" >> /opt/myapp/logs/app.log
echo "ERROR connection refused" >> /opt/myapp/logs/app.log
echo "ERROR authentication failed" >> /opt/myapp/logs/app.log
```

### 4. Analyse Logs

Find errors:

```bash
grep ERROR /opt/myapp/logs/app.log
```

Count errors:

```bash
grep -c ERROR /opt/myapp/logs/app.log
```

Save errors:

```bash
grep ERROR /opt/myapp/logs/app.log \
  > /opt/myapp/logs/errors.txt
```

### 5. Generate Directory Report

```bash
tree /opt/myapp
```

## Verification

```bash
test -d /opt/myapp/bin
test -d /opt/myapp/config
test -d /opt/myapp/logs
test -d /opt/myapp/data
grep -c ERROR /opt/myapp/logs/app.log
```

Expected error count: `3` for the sample data.

## Skills Practised

- Linux navigation
- File and directory management
- Log analysis
- Command-line searching
- Pipes and redirection
- Package management

## Troubleshooting Notes

Record actual errors encountered during the exercise
and the commands used to resolve them.

## Key Takeaway

Linux fundamentals support application deployment,
system administration and troubleshooting.
