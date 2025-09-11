#!/bin/sh
set -e

# Default values
PUID=${PUID:-1000}
PGID=${PGID:-1000}

# Change mosquitto user/group IDs
if [ "$(id -u mosquitto)" != "$PUID" ]; then
    echo "Setting mosquitto UID to $PUID"
    deluser mosquitto
    addgroup -g "$PGID" mosquitto
    adduser -D -u "$PUID" -G mosquitto mosquitto
fi

# Adjust permissions of config/data/log folders
chown -R "$PUID:$PGID" /mosquitto/config /mosquitto/data /mosquitto/log

# Execute the original CMD as mosquitto user
exec su-exec mosquitto "$@"