#!/bin/sh
set -e

# Use environment variables or defaults
PUID=${PUID:-1000}
PGID=${PGID:-1000}

# Create group if it doesn't exist
if ! getent group capmqtt >/dev/null 2>&1; then
    addgroup -g "$PGID" capmqtt
fi

# Create user if it doesn't exist
if ! id capmqtt >/dev/null 2>&1; then
    adduser -D -u "$PUID" -G capmqtt capmqtt
fi

# Ensure ownership of volumes
chown -R "$PUID:$PGID" /mosquitto/config /mosquitto/data /mosquitto/log

# Fix pwfile if it exists
if [ -f /mosquitto/config/pwfile ]; then
    chown "$PUID:$PGID" /mosquitto/config/pwfile
    chmod 0700 /mosquitto/config/pwfile
fi

# Run Mosquitto as capmqtt
exec su-exec capmqtt "$@"
