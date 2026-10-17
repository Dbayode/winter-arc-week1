# Day 05 — Nginx Troubleshooting

## Environment

- Operating System: Ubuntu
- Web Server: Nginx
- Web Port: 8085
- Backend: Python HTTP Server
- Backend Port: 5000

## Scenario 1: 502 Bad Gateway

### Symptoms
Nginx returns HTTP 502 when the backend is unavailable.

### Investigation
- Check the backend process.
- Inspect listening ports.
- Review Nginx error logs.

### Root Cause
The backend application was stopped during the lab.

### Resolution
Restart the Python application.

### Verification
The health-check endpoint returns HTTP 200.

## Scenario 2: Configuration Error

### Symptoms
Nginx configuration validation fails.

### Investigation
Run `sudo nginx -t`.

### Root Cause
Record the actual syntax error, if reproduced.

### Resolution
Correct the configuration and reload Nginx.

## Scenario 3: HTTP 404

### Symptoms
The requested resource is not found.

### Investigation
Inspect the document root and server block.

### Root Cause
The requested file does not exist.

### Resolution
Use a valid URL or deploy the missing file.

## Lessons Learned

- Nginx can serve static content and proxy requests.
- Backend failures can produce HTTP 502 responses.
- Configuration validation prevents avoidable outages.
- Logs are essential for troubleshooting.
