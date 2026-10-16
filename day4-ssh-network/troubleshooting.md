# Day 04 — Linux Networking & SSH Troubleshooting

## Project Overview

This project is part of my 90-Day DevOps Winter Arc journey.

The objective of Day 04 is to develop practical skills in Linux
networking, SSH configuration, remote server administration, and
troubleshooting network connectivity issues.

This report documents three common SSH connection failures:

1. Connection Refused
2. Connection Timed Out
3. Permission Denied (publickey)

The scenarios below demonstrate a structured troubleshooting
approach using Linux networking and system administration tools.

**Lab status:** Illustrative troubleshooting scenarios.
Actual test results should be recorded after performing each
exercise on the Ubuntu practice VM.

---

## Environment

| Component | Configuration |
|-----------|---------------|
| Operating System | Ubuntu Linux |
| Environment | Linux Virtual Machine |
| Network Interface | ens33 (example) |
| IP Address | 192.168.1.100/24 (example) |
| Default Gateway | 192.168.1.1 (example) |
| SSH Server | OpenSSH Server |
| SSH Client | OpenSSH Client |
| SSH Port | TCP 22 |
| Authentication | SSH Public-Key Authentication |
| Firewall | UFW (if enabled) |

### Initial Network Investigation

Before troubleshooting SSH, I use the following commands
to inspect the server's network configuration.

#### Check Network Interfaces

```bash
ip -br addr
```

Example output:

```text
lo       UNKNOWN    127.0.0.1/8
ens33    UP         192.168.1.100/24
```

This command displays the available network interfaces,
their operational status, and assigned IP addresses.

#### Check Routing Table

```bash
ip route
```

Example output:

```text
default via 192.168.1.1 dev ens33
192.168.1.0/24 dev ens33 proto kernel scope link
```

The routing table identifies the default gateway and
the networks directly connected to the server.

#### Test Network Connectivity

```bash
ping -c 4 1.1.1.1
```

This tests ICMP reachability to an external IP address.

#### Test DNS Resolution

```bash
getent hosts example.com
```

This checks whether the system can resolve a hostname
to an IP address.

#### Inspect Listening Ports

```bash
sudo ss -tlnp
```

This displays listening TCP sockets and their
associated processes.

---

# Scenario 1 — SSH Connection Refused

## Symptoms

### Simulated Error

An SSH client attempts to connect to the Ubuntu server.

Command:

```bash
ssh ubuntu@192.168.1.100
```

Example error:

```text
ssh: connect to host 192.168.1.100 port 22: Connection refused
```

The connection is rejected before SSH authentication begins.

This can happen when the SSH service is stopped,
the server is not listening on the expected port,
or a network device actively rejects the connection.

## Investigation

### Step 1: Check SSH Service Status

On the Ubuntu server:

```bash
sudo systemctl status ssh
```

Example result:

```text
Active: inactive (dead)
```

This indicates that the SSH service is not running.

### Step 2: Check Listening Ports

```bash
sudo ss -tlnp | grep ':22'
```

Example result:

```text
No matching output
```

This suggests that no TCP service is listening on
port 22 in the current network namespace.

### Step 3: Verify OpenSSH Installation

```bash
dpkg -l openssh-server
```

This checks whether the OpenSSH server package
is installed.

### Step 4: Examine SSH Logs

```bash
sudo journalctl -u ssh -n 30 --no-pager
```

This displays recent service logs that may explain
why SSH stopped or failed to start.

## Root Cause

**Simulated root cause:**

The OpenSSH server service was stopped.

Because SSH was not running, the server could not
accept incoming connections on TCP port 22.

The client therefore received a connection refusal.

## Resolution

Start the SSH service:

```bash
sudo systemctl start ssh
```

Enable automatic startup:

```bash
sudo systemctl enable ssh
```

Check the service status:

```bash
sudo systemctl is-active ssh
```

Expected result:

```text
active
```

Verify that SSH is listening:

```bash
sudo ss -tlnp | grep ':22'
```

Retry the SSH connection from the client:

```bash
ssh ubuntu@192.168.1.100
```

## Verification

The issue is considered resolved when:

- The SSH service reports an active state.
- TCP port 22 is listening on the expected address.
- The client reaches the SSH authentication stage.
- Authentication succeeds with valid credentials.

## Lesson Learned

A connection refusal does not always mean that
the entire server or network is unavailable.

It may indicate that the required application
or service is not running.

Checking service status and listening ports
is an important first troubleshooting step.

---

# Scenario 2 — SSH Connection Timed Out

## Symptoms

### Simulated Error

The SSH client attempts to connect to the server.

Command:

```bash
ssh ubuntu@192.168.1.100
```

Example error:

```text
ssh: connect to host 192.168.1.100 port 22: Connection timed out
```

The client does not receive the expected response
within the connection timeout.

Possible causes include:

- Incorrect destination IP address.
- Firewall restrictions.
- Routing problems.
- Network connectivity issues.
- Incorrect virtual machine network configuration.

## Investigation

### Step 1: Verify Server IP Address

On the Ubuntu server:

```bash
ip -br addr
```

This confirms the IP address assigned to the
server's network interface.

### Step 2: Test Network Reachability

From the SSH client:

```bash
ping -c 4 192.168.1.100
```

A successful ping indicates that ICMP traffic
can reach the server and return.

A failed ping requires further investigation,
because some networks block ICMP traffic.

### Step 3: Inspect Routing

```bash
ip route
```

This displays the routing table.

The client must have a valid route to the
destination network.

### Step 4: Check Firewall Status

On the Ubuntu server:

```bash
sudo ufw status verbose
```

Example:

```text
Status: active
```

Review the firewall rules to determine whether
incoming SSH traffic is permitted.

### Step 5: Verify SSH Service

```bash
sudo systemctl status ssh
```

Check port 22:

```bash
sudo ss -tlnp | grep ':22'
```

If SSH is active and listening, the problem
may be elsewhere in the network path.

### Step 6: Test TCP Connectivity

From the client:

```bash
nc -vz -w 5 192.168.1.100 22
```

This tests whether the client can establish
a TCP connection to port 22.

Alternatively:

```bash
ssh -vvv -o ConnectTimeout=5 ubuntu@192.168.1.100
```

Verbose output provides additional information
about the connection attempt.

## Root Cause

**Simulated root cause:**

The server's firewall configuration did not permit
incoming SSH connections on TCP port 22.

Although the SSH service was running, the firewall
prevented the client from establishing a connection.

This root cause should be confirmed by inspecting
firewall rules and testing connectivity.

## Resolution

Confirm that the SSH service is running:

```bash
sudo systemctl is-active ssh
```

Inspect firewall rules:

```bash
sudo ufw status numbered
```

If the lab firewall is blocking SSH, add a rule
permitting the required connection:

```bash
sudo ufw allow 22/tcp
```

For a more secure configuration, restrict access
to the trusted client IP address:

```bash
sudo ufw allow from CLIENT_IP to any port 22 proto tcp
```

Replace CLIENT_IP with the actual client address.

Verify the firewall configuration:

```bash
sudo ufw status verbose
```

Retry the connection:

```bash
ssh ubuntu@192.168.1.100
```

## Verification

The issue is considered resolved when:

- The SSH service is active.
- Port 22 is listening.
- The firewall permits the required traffic.
- The client establishes a TCP connection.
- SSH authentication succeeds.

## Lesson Learned

A connection timeout may occur even when the
SSH service is running correctly.

Troubleshooting must consider the entire network
path, including IP addressing, routing, firewalls,
and virtual machine network configuration.

Disabling the firewall completely is not a
recommended troubleshooting approach.

---

# Scenario 3 — Permission Denied (publickey)

## Symptoms

### Simulated Error

The client attempts to connect using an SSH private key.

Command:

```bash
ssh -i ~/.ssh/winter_arc_lab ubuntu@192.168.1.100
```

Example error:

```text
ubuntu@192.168.1.100: Permission denied (publickey).
```

This indicates that the connection reached
the SSH authentication stage, but the server
did not accept the offered authentication method.

Possible causes include:

- Incorrect SSH username.
- Wrong private key.
- Missing public key on the server.
- Incorrect SSH file permissions.
- Incorrect SSH server authentication settings.

## Investigation

### Step 1: Verify Username

On the server:

```bash
id ubuntu
```

This confirms whether the target account exists.

### Step 2: Verify Private Key

On the client:

```bash
ls -l ~/.ssh/winter_arc_lab
```

The private key should exist and have
appropriately restricted permissions.

Set permissions:

```bash
chmod 600 ~/.ssh/winter_arc_lab
```

### Step 3: Enable Verbose SSH Logging

```bash
ssh -vvv -i ~/.ssh/winter_arc_lab ubuntu@192.168.1.100
```

This displays additional authentication details.

The output can help determine whether the client
offered the expected key and whether it was accepted.

### Step 4: Check Authorized Keys

On the server:

```bash
sudo ls -ld /home/ubuntu/.ssh
```

```bash
sudo ls -l /home/ubuntu/.ssh/authorized_keys
```

Typical secure permissions:

```text
/home/ubuntu/.ssh                 700
/home/ubuntu/.ssh/authorized_keys 600
```

### Step 5: Verify Public Key

On the client:

```bash
cat ~/.ssh/winter_arc_lab.pub
```

Compare the public key with the corresponding
entry in the server's authorized_keys file.

### Step 6: Inspect Authentication Logs

On the server:

```bash
sudo journalctl -u ssh -n 30 --no-pager
```

This may reveal rejected authentication attempts
or SSH configuration problems.

## Root Cause

**Simulated root cause:**

The client's public SSH key was missing from
the target user's authorized_keys file.

Consequently, the SSH server could not authenticate
the client using the supplied private key.

## Resolution

Install the correct public key on the server.

If password authentication is available for
initial configuration, run from the client:

```bash
ssh-copy-id -i ~/.ssh/winter_arc_lab.pub ubuntu@192.168.1.100
```

Otherwise, use an existing authorised administrator
session or the VM console to install the public key.

Verify permissions on the server:

```bash
sudo chmod 700 /home/ubuntu/.ssh
```

```bash
sudo chmod 600 /home/ubuntu/.ssh/authorized_keys
```

Verify ownership:

```bash
sudo chown -R ubuntu:ubuntu /home/ubuntu/.ssh
```

Retry the connection:

```bash
ssh -i ~/.ssh/winter_arc_lab ubuntu@192.168.1.100
```

## Verification

The issue is considered resolved when:

- The client uses the correct private key.
- The corresponding public key is authorised.
- SSH directory permissions are correct.
- The correct Linux username is used.
- SSH authentication succeeds.

After connecting, verify the remote session:

```bash
whoami
```

```bash
hostname
```

```bash
pwd
```

## Lesson Learned

Successful SSH authentication requires
correctly configured credentials and permissions.

A server may be reachable over the network
while still rejecting authentication.

It is important to distinguish authentication
failures from network connectivity failures.

---

# Troubleshooting Summary

| Error | Example Root Cause | Investigation | Resolution |
|-------|--------------------|---------------|------------|
| Connection Refused | SSH service stopped | systemctl, ss, journalctl | Start SSH service |
| Connection Timed Out | Firewall blocking TCP 22 | ip route, ufw, nc | Correct firewall rule |
| Permission Denied (publickey) | Public key not authorised | ssh -vvv, authorized_keys, logs | Install correct public key |

---

# Troubleshooting Methodology

The approach used in these scenarios follows
a structured investigation process.

## Step 1: Identify the Problem

Read the error message carefully.

Determine whether the issue involves:

- Network connectivity.
- Service availability.
- Firewall configuration.
- Authentication.

## Step 2: Gather Evidence

Use appropriate Linux commands:

```bash
ip -br addr
ip route
ping -c 4 127.0.0.1
sudo ss -tlnp
sudo systemctl status ssh
sudo journalctl -u ssh -n 30
```

## Step 3: Identify the Root Cause

Compare the observed results against
the expected system behaviour.

Avoid making configuration changes
before understanding the likely cause.

## Step 4: Apply a Targeted Resolution

Correct the specific issue identified
during the investigation.

Avoid unnecessary changes to unrelated
services or security configurations.

## Step 5: Verify the Resolution

Repeat the original connection test.

Confirm that the expected functionality
has been restored.

## Step 6: Document the Findings

Record:

- Symptoms.
- Commands executed.
- Evidence collected.
- Root cause.
- Resolution.
- Verification results.

---

# Lessons Learnt

## 1. Linux Networking Is Fundamental to DevOps

Understanding IP addressing, subnetting, routing,
DNS, TCP, UDP, and network ports is essential
for administering Linux servers.

These concepts provide the foundation for
working with cloud infrastructure and
container networking.

## 2. SSH Enables Secure Remote Administration

SSH provides encrypted communication between
clients and remote servers.

It allows DevOps engineers to perform
administrative tasks without requiring
physical access to the server.

Public-key authentication is an important
method of securing SSH access.

## 3. Different Errors Require Different Investigations

Connection Refused, Connection Timed Out,
and Permission Denied are different failure types.

Understanding these differences helps narrow
the investigation and identify the appropriate
troubleshooting commands.

## 4. Logs Provide Valuable Diagnostic Evidence

Linux tools such as journalctl provide
information about service failures and
authentication attempts.

Examining logs helps engineers make decisions
based on evidence rather than assumptions.

## 5. Security Should Not Be Compromised

Troubleshooting should not involve unnecessarily
disabling firewalls or weakening SSH security.

A better approach is to identify the required
access and configure appropriate restrictions.

## 6. A Structured Troubleshooting Process Is Essential

An effective troubleshooting process involves:

Identify → Investigate → Diagnose → Resolve → Verify → Document

This approach can be applied to Linux servers,
cloud environments, applications, and containers.

---

# Key Takeaway

Day 04 focuses on understanding how Linux servers
communicate and how DevOps engineers securely
administer remote systems.

The most important lesson is that successful
troubleshooting requires identifying whether
a failure is caused by networking, service
availability, firewall restrictions, or authentication.

Developing these skills provides a foundation
for managing AWS EC2 instances, Linux servers,
and cloud-based infrastructure.

---

# Day 04 Completion Checklist

- [ ] Inspect Linux network interfaces.
- [ ] Understand IP addresses and subnetting.
- [ ] Examine the routing table.
- [ ] Test network connectivity.
- [ ] Verify DNS resolution.
- [ ] Inspect listening TCP ports.
- [ ] Install and configure OpenSSH Server.
- [ ] Generate an SSH key pair.
- [ ] Establish SSH key-based authentication.
- [ ] Investigate a connection refusal.
- [ ] Investigate a connection timeout.
- [ ] Investigate a public-key authentication failure.
- [ ] Record actual troubleshooting evidence.
- [ ] Verify successful SSH connectivity.
- [ ] Commit documentation to GitHub.

---

## Conclusion

This Day 04 project demonstrates the troubleshooting
methods required to investigate Linux networking
and SSH connectivity problems.

The exercises provide a foundation for secure
remote server administration, systematic incident
investigation, and reliable infrastructure management.

The next stage of the DevOps Winter Arc focuses
on DNS, HTTP/HTTPS, and Nginx reverse proxy
configuration.
