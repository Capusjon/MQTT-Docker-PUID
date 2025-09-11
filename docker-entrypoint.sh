#!/bin/sh
set -e

# Use environment variables or defaults
PUID=${PUID:-1000}
PGID=${PGID:-1000}

# Check if a group with the desired GID exists
existing_group=$(getent group "$PGID" | cut -d: -f1)

if [ -z "$existing_group" ]; then
    addgroup -g "$PGID" capmqtt
    capmqtt_group="capmqtt"
else
    echo "Group with GID $PGID already exists: $existing_group"
    capmqtt_group="$existing_group"
fi

# Check if user exists
if ! id capmqtt >/dev/null 2>&1; then
    adduser -D -u "$PUID" -G "$capmqtt_group" capmqtt
fi

# Fix ownership of mounted volumes
chown -R "$PUID:$PGID" /mosquitto/config /mosquitto/data /mosquitto/log

# Fix pwfile permissions
if [ -f /mosquitto/config/pwfile ]; then
    chown "$PUID:$PGID" /mosquitto/config/pwfile
    chmod 0700 /mosquitto/config/pwfile
fi

# Run Mosquitto as capmqtt
exec su-exec capmqtt "$@"
