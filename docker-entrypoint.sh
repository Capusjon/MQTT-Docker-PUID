#!/bin/sh
set -e

PUID=${PUID:-1000}
PGID=${PGID:-1000}

# Check if group exists; if not, create it
if ! getent group mosquitto >/dev/null 2>&1; then
    addgroup -g "$PGID" mosquitto
fi

# Check if user exists; if not, create it
if ! id -u mosquitto >/dev/null 2>&1; then
    adduser -D -u "$PUID" -G mosquitto mosquitto
else
    # If the user exists, modify UID/GID
    usermod -u "$PUID" mosquitto
    groupmod -g "$PGID" mosquitto
fi

# Ensure proper ownership of mounted volumes
chown -R "$PUID:$PGID" /mosquitto/config /mosquitto/data /mosquitto/log

# Run Mosquitto as this user
exec su-exec mosquitto "$@"
