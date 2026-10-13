#!/usr/bin/env bash

set -euo pipefail

APP_DIR="/opt/myapp"

echo "Starting application workspace checks..."

for directory in bin config logs data; do
    if [[ -d "$APP_DIR/$directory" ]]; then
        echo "[OK] $directory directory exists"
    else
        echo "[ERROR] Missing directory: $directory"
        exit 1
    fi
done

if [[ -f "$APP_DIR/config/app.conf" ]]; then
    echo "[OK] Configuration file exists"
else
    echo "[ERROR] Configuration file missing"
    exit 1
fi

echo "Workspace checks completed successfully."
