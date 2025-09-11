# Base image
FROM eclipse-mosquitto:latest

# Install su-exec for dropping privileges
RUN apk add --no-cache su-exec

# Copy custom entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]

# Default command
CMD ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
