ARG BASE_IMAGE=eclipse-mosquitto:2.1-alpine
FROM ${BASE_IMAGE}

# su-exec om van root naar PUID:PGID over te schakelen
RUN apk add --no-cache su-exec

# Eigen entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["mosquitto", "-c", "/mosquitto/config/mosquitto.conf"]
