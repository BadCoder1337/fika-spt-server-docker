#!/bin/bash

# Pterodactyl Entrypoint for SPT + Fika Server
# This script processes the STARTUP environment variable and executes it

cd /home/container || exit 1

# Output container info
echo "----------------------------------------"
echo "SPT + Fika Pterodactyl Container"
echo ".NET Version: $(dotnet --version 2>/dev/null || echo 'unknown')"
echo "Working Directory: $(pwd)"
echo "----------------------------------------"

# Check if STARTUP variable is set
if [ -z "${STARTUP}" ]; then
    echo "ERROR: STARTUP environment variable is not set"
    echo "This container is designed to run with Pterodactyl Panel"
    exit 1
fi

# Replace Pterodactyl template variables {{VAR}} with shell variables ${VAR}
MODIFIED_STARTUP=$(echo "${STARTUP}" | sed -e 's/{{/${/g' -e 's/}}/}/g')

echo "Startup Command: ${MODIFIED_STARTUP}"
echo "----------------------------------------"

# Execute the startup command
eval "${MODIFIED_STARTUP}"
