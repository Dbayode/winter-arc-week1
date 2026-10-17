# Day 05 — DNS, HTTP & Nginx

## Project Overview

This project demonstrates how to configure an Nginx web server
and reverse proxy on Ubuntu Linux.

It is part of my 90-Day DevOps Winter Arc challenge.

## Learning Objectives

- Understand DNS resolution.
- Understand HTTP and HTTPS.
- Install and configure Nginx.
- Deploy a static website.
- Configure a reverse proxy.
- Troubleshoot HTTP errors.
- Analyse Nginx logs.

## Technologies

- Ubuntu Linux
- Nginx
- Python 3
- Bash
- Git and GitHub

## Architecture

```text
Client
  |
  v
Nginx :8085
  |
  +---- / --------> Static Website
  |
  +---- /api/ ----> Python Backend :5000
```

## Project Structure

```text
day5-nginx/
├── README.md
├── app.py
├── myapp
├── troubleshooting.md
└── website/
    └── index.html
```

## Installation

Install Nginx:

```bash
sudo apt update
sudo apt install nginx -y
```

Deploy the website:

```bash
sudo mkdir -p /var/www/myapp
sudo cp website/index.html /var/www/myapp/
```

Configure Nginx:

```bash
sudo cp myapp /etc/nginx/sites-available/myapp
sudo ln -s /etc/nginx/sites-available/myapp \
  /etc/nginx/sites-enabled/myapp
```

Validate and reload:

```bash
sudo nginx -t
sudo systemctl reload nginx
```

## Start the Backend

```bash
python3 app.py
```

## Verification

Test the website:

```bash
curl -I http://localhost:8085
```

Test the API:

```bash
curl http://localhost:8085/api/health
```

## Troubleshooting

See `troubleshooting.md`.

## Key Takeaway

Nginx provides a reliable entry point for web applications
and can route incoming requests to backend services.
