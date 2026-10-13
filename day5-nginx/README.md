# Day 05 — DNS, HTTP/HTTPS & Nginx

## Mission
Understand DNS resolution and HTTP response codes. Run a local backend on port 3000 and configure Nginx as a reverse proxy.

## Study
DNS lookup; TCP connections; HTTP methods and status codes; TLS basics; reverse proxies; Nginx configuration testing.

## Lab (Ubuntu VM)

```bash
sudo apt update
sudo apt install -y nginx python3
# In a separate terminal, start a demo HTTP server:
python3 -m http.server 3000 --bind 127.0.0.1
```

Install the example Nginx server block after reviewing it:

```bash
sudo cp day5-nginx/myapp.conf /etc/nginx/sites-available/myapp
sudo ln -s /etc/nginx/sites-available/myapp /etc/nginx/sites-enabled/myapp
sudo nginx -t
sudo systemctl reload nginx
curl -i http://127.0.0.1:8080/
```

The example uses **port 8080** to reduce conflicts with an existing site. The Python server is a simple demonstration backend, not a production application.

## Troubleshooting
If Nginx reports `502 Bad Gateway`, confirm the backend is running with `ss -ltnp` and `curl -i http://127.0.0.1:3000/`; inspect `sudo journalctl -u nginx` and `/var/log/nginx/error.log`.

## Deliverables
- `myapp.conf`
- `status-codes.md` completed with **observed** responses
- Short notes on DNS and TLS
