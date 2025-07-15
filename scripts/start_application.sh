#!/bin/bash
set -e

APP_DIR="/home/ec2-user/app"
LOG_DIR="${APP_DIR}/logs"
PID_FILE="${APP_DIR}/application.pid"

# Create logs directory if it doesn't exist
mkdir -p ${LOG_DIR}

# Activate virtual environment
source "${APP_DIR}/venv/bin/activate"

# Check if app.py exists
if [ ! -f "${APP_DIR}/app.py" ]; then
    echo "Error: app.py not found at ${APP_DIR}/app.py"
    exit 1
fi

# Start the application
cd ${APP_DIR}
python3 app.py >> "${LOG_DIR}/application.log" 2>&1 &

# Store the PID
echo $! > ${PID_FILE}

# Verify the application started
sleep 5
if ! ps -p $(cat ${PID_FILE}) > /dev/null; then
    echo "Error: Application failed to start"
    exit 1
fi

echo "Application started successfully with PID $(cat ${PID_FILE})"
deactivate