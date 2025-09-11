MQTT-Docker-PUID

Custom Eclipse Mosquitto Docker image with dynamic user/group IDs.

This image builds on the official Eclipse Mosquitto
 image, adding:

Configurable PUID (user ID) and PGID (group ID) via environment variables.

Mosquitto runs under a new user capmqtt instead of the built-in mosquitto user, avoiding UID conflicts.

See https://hub.docker.com/_/eclipse-mosquitto for further configuration refenrences
