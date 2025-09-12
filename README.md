# ﻿MQTT-Docker-PUID
Custom Eclipse Mosquitto Docker image with dynamic user/group IDs.

https://hub.docker.com/r/capusjon/mqtt-docker-puid

--------------------------------------------------------------------
--

This image builds on the official Eclipse Mosquitto image, adding:

• Configurable PUID (user ID) and PGID (group ID) via environment variables.

• Mosquitto runs under a new user capmqtt instead of the built-in mosquitto user, avoiding UID conflicts.

• Automatic ownership and permission fixes for mounted volumes.

--
--

Features

• Run Mosquitto as a custom UID/GID, matching host user permissions.

Environment Variables

**Default
**
PUID:1000

UID to run Mosquitto as inside the container.

PGID:1000

GID to run Mosquitto as inside the container.

---
Make sure you add the following to your conf to get rid of the "Error saving in-memory database, unable to open mosquitto.db.new for writing." message

Enable persistence

persistence true

Where to save mosquitto.db

persistence_location /mosquitto/data/

Optional: save interval (default is 1800s = 30min)

persistence_interval 60 (for testing only, afterwards revert to a timing you find acceptable)

You can find these settings commented out in the default conf file.
Use this conf file if no file is present in your config folder https://github.com/Capusjon/MQTT-Docker-PUID/blob/main/mosquitto/config/mosquitto.conf



