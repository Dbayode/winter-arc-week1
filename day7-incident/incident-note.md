# Day 07 — Linux Production Incident Simulation

## Incident Summary

**Incident ID:** INC-007  
**Incident Type:** Application Availability  
**Environment:** Ubuntu Linux Lab  
**Affected Service:** Nginx Reverse Proxy / Python Backend  
**Severity:** Simulated service outage  
**Status:** To be confirmed after recovery

## 1. Incident Description

During a controlled DevOps troubleshooting exercise, the Python backend application was deliberately stopped to simulate an application outage.

Nginx remained operational but could no longer forward requests successfully to the backend service.

## 2. Symptoms

- The API endpoint became unavailable.
- Nginx was expected to return HTTP 502 Bad Gateway.
- The backend health-check endpoint could not be reached.

**Actual HTTP response:** [Record response]

## 3. Investigation

The following diagnostic commands were used:

```bash
sudo systemctl status nginx
sudo nginx -t
sudo ss -tlnp | grep -E ':(5000|8085)\b'
curl -i http://127.0.0.1:5000/api/health
curl -i http://localhost:8085/api/health
sudo tail -n 30 /var/log/nginx/myapp-error.log
```

**Findings:** [Record actual output and observations]

## 4. Root Cause

For this controlled simulation, the backend Python application was deliberately stopped.

Nginx remained active, but its upstream service on port 5000 was unavailable.

## 5. Resolution

The backend application was restarted:

```bash
python3 day5-nginx/app.py
```

The application was then tested directly and through Nginx.

## 6. Verification

```bash
curl -i http://127.0.0.1:5000/api/health
curl -i http://localhost:8085/api/health
curl -I http://localhost:8085/
```

**Verification results:** [Record actual HTTP status codes]

## 7. Lessons Learned

- A running reverse proxy does not guarantee application availability.
- HTTP 502 errors can indicate problems communicating with upstream services.
- Service status, listening ports, and logs help narrow down the root cause.
- Recovery must be verified rather than assumed.
- Incident documentation supports future troubleshooting.

## 8. Preventive Improvements

- Manage the backend as a systemd service.
- Configure appropriate service restart policies.
- Add automated application health checks.
- Monitor application availability and error rates.
- Create alerts for service failures.

## 9. Incident Timeline

| Event | Time |
|---|---|
| Healthy baseline confirmed | [Time] |
| Backend stopped | [Time] |
| Failure detected | [Time] |
| Root cause identified | [Time] |
| Backend restarted | [Time] |
| Recovery verified | [Time] |

## Conclusion

This exercise demonstrates the importance of systematic troubleshooting, root-cause analysis, and service recovery in Linux-based application environments.

**Final status:** [Resolved / Unresolved]
