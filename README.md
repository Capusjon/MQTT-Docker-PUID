MQTT-Docker-PUID
Custom Eclipse Mosquitto Docker image with dynamic user/group IDs.

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

Default

PUID:1000

UID to run Mosquitto as inside the container.

PGID:1000

GID to run Mosquitto as inside the container.


