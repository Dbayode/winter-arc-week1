from http.server import BaseHTTPRequestHandler, HTTPServer
from datetime import datetime, timezone
import json


class Handler(BaseHTTPRequestHandler):

    def do_GET(self):

        if self.path == "/api/health":

            response = {
                "status": "healthy",
                "service": "winter-arc-day5",
                "timestamp": datetime.now(
                    timezone.utc
                ).isoformat()
            }

            body = json.dumps(response).encode()

            self.send_response(200)
            self.send_header(
                "Content-Type",
                "application/json"
            )
            self.send_header(
                "Content-Length",
                str(len(body))
            )
            self.end_headers()

            self.wfile.write(body)

        else:
            self.send_response(404)
            self.end_headers()


server = HTTPServer(
    ("127.0.0.1", 5000),
    Handler
)

print("Application running on port 5000", flush=True)

server.serve_forever()
