import os
import sys
import time
import signal
import logging
from http.server import HTTPServer, BaseHTTPRequestHandler
import threading

logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] [worker-service] %(message)s',
    handlers=[logging.StreamHandler(sys.stdout)]
)

RUNNING = True

def signal_handler(signum, frame):
    global RUNNING
    logging.info(f"Received signal {signum}. Shutting down worker gracefully...")
    RUNNING = False

signal.signal(signal.SIGINT, signal_handler)
signal.signal(signal.SIGTERM, signal_handler)

class HealthCheckHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path in ["/health", "/ready"]:
            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(b'{"status": "healthy", "service": "worker-service"}')
        else:
            self.send_response(404)
            self.end_headers()

    def log_message(self, format, *args):
        pass # Suppress default HTTP request logging

def start_health_server(port=8080):
    server = HTTPServer(('0.0.0.0', port), HealthCheckHandler)
    logging.info(f"Health server listening on port {port}")
    server.serve_forever()

def process_tasks():
    global RUNNING
    poll_interval = float(os.getenv("POLL_INTERVAL", "5.0"))
    api_url = os.getenv("API_SERVICE_URL", "http://localhost:8000")
    logging.info(f"Starting worker loop. Target API URL: {api_url}")

    task_count = 0
    while RUNNING:
        task_count += 1
        logging.info(f"Worker heartbeat check #{task_count} — active and waiting for tasks...")
        time.sleep(poll_interval)

    logging.info("Worker loop terminated.")

if __name__ == "__main__":
    health_thread = threading.Thread(target=start_health_server, args=(8080,), daemon=True)
    health_thread.start()
    process_tasks()
