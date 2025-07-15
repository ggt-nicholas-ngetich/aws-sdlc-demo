#!/bin/bash

APP_DIR="/home/ec2-user/app"
PID_FILE="${APP_DIR}/application.pid"

# Function to kill process safely
kill_process() {
    local pid=$1
    if kill -0 ${pid} 2>/dev/null; then
        echo "Stopping application (PID: ${pid})"
        kill -15 ${pid}
        # Wait for up to 30 seconds for graceful shutdown
        for i in {1..30}; do
            if ! kill -0 ${pid} 2>/dev/null; then
                echo "Application stopped successfully"
                return 0
            fi
            sleep 1
        done
        # Force kill if still running
        echo "Application did not stop gracefully, force killing..."
        kill -9 ${pid} 2>/dev/null || true
    fi
}

# Check if PID file exists
if [ -f "${PID_FILE}" ]; then
    pid=$(cat "${PID_FILE}")
    kill_process ${pid}
    rm -f "${PID_FILE}"
else
    # Fallback to pkill if PID file not found
    echo "PID file not found, attempting to stop application using pkill..."
    pkill -f "python3 app.py" || true
fi

# Double check no processes are left
if pgrep -f "python3 app.py" > /dev/null; then
    echo "Forcing kill of any remaining processes..."
    pkill -9 -f "python3 app.py" || true
fi