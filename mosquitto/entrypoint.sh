#!/bin/sh
set -e
if [[ ! -z $PGID ]] && [[ ! -z $PUID ]]; then
    addgroup -g $PGID -S mosquitto
    adduser -S -D -H -h /var/empty -s /sbin/nologin -G mosquitto -u $PUID -g mosquitto mosquitto
    cat /etc/passwd
fi
echo "set mosquitto user:${MOSQUITTO_USER_NAME}"
echo "" > /tmp/pwfile.conf
mosquitto_passwd -b /tmp/pwfile.conf ${MOSQUITTO_USER_NAME} ${MOSQUITTO_PASSWORD}
chmod 400 /tmp/pwfile.conf
/docker-entrypoint.sh
exec "$@"