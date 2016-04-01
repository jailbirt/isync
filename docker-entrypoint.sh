#!/bin/bash

echo "* * * * *	sleep ${SYNC_INTERVAL} && /usr/local/bin/mbsync -c ${SYNC_CONFIG} ${CHANNEL}" > /var/spool/cron/root && \
chown root.root /var/spool/cron/root && \
chmod 400 /var/spool/cron/root

exec "$@"
