#!/bin/sh
set -e

PUID=${PUID:-1000}
PGID=${PGID:-1000}

# Alleen numerieke waarden accepteren
case "$PUID" in ''|*[!0-9]*) echo "Ongeldige PUID '$PUID', gebruik 1000"; PUID=1000 ;; esac
case "$PGID" in ''|*[!0-9]*) echo "Ongeldige PGID '$PGID', gebruik 1000"; PGID=1000 ;; esac

RUN_UID=$PUID
RUN_GID=$PGID

# Mosquitto 2.1+ leest PUID/PGID zelf ook. Wij wisselen hieronder al van
# gebruiker, dus de variabelen weghalen voordat Mosquitto start.
unset PUID PGID

if [ "$(id -u)" = "0" ]; then
    # Groep met deze GID aanmaken als die nog niet bestaat
    if ! getent group "$RUN_GID" >/dev/null 2>&1; then
        addgroup -g "$RUN_GID" capmqtt
    fi
    group_name=$(getent group "$RUN_GID" | cut -d: -f1)

    # Gebruiker met deze UID aanmaken als die nog niet bestaat
    if ! getent passwd "$RUN_UID" >/dev/null 2>&1; then
        adduser -D -H -s /sbin/nologin -u "$RUN_UID" -G "$group_name" capmqtt
    fi

    # Eigenaar van de gekoppelde mappen goedzetten
    mkdir -p /mosquitto/config /mosquitto/data /mosquitto/log
    chown -R "$RUN_UID:$RUN_GID" /mosquitto/config /mosquitto/data /mosquitto/log \
        || echo "Waarschuwing: chown mislukt (read-only volume?), ga verder"

    # Wachtwoordbestand alleen leesbaar voor de eigenaar
    if [ -f /mosquitto/config/pwfile ]; then
        chmod 0700 /mosquitto/config/pwfile || true
    fi

    exec su-exec "$RUN_UID:$RUN_GID" "$@"
fi

# Container draait al als non-root (bijv. via 'user:' in compose)
exec "$@"
