#!/bin/sh
set -e

PUID=${PUID:-1000}
PGID=${PGID:-1000}

# Create group if it doesn't exist
if ! getent group mosquitto >/dev/null 2>&1; then
    addgroup -g "$PGID" mosquitto
fi

# Create user if it doesn't exist
if ! id -u mosquitto >/dev/null 2>&1; then
    adduser -D -u "$PUID" -G mosquitto mosquitto
fi

# Fix ownership of mounted volumes
chown -R "$PUID:$PGID" /mosquitto/config /mosquitto/data /mosquitto/log

# Run Mosquitto as the created user
exec su-exec mosquitto "$@"
