#!/bin/sh
set -e
if [[ ! -z $PGID ]] && [[ ! -z $PUID ]]; then
    addgroup -g $PGID -S mosquitto
    adduser -S -D -H -h /var/empty -s /sbin/nologin -G mosquitto -u $PUID -g mosquitto mosquitto
    cat /etc/passwd
fi
echo "set mosquitto user:${MOSQUITTO_USER_NAME}"
echo "" > /tmp/pwfile.conf
mosquitto_passwd -b /tmp/pwfile.conf ${MOSQUITTO_USER_NAME} ${MOSQUITTO_PASSWORD} > /dev/null 2>&1 || true
chmod 444 /tmp/pwfile.conf
/docker-entrypoint.sh "$@"