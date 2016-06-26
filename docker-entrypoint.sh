#!/bin/sh

MAIL_FOLDER=$( grep "Path" ${SYNC_CONFIG} | cut -d " " -f 2 )

if [ ! -d ${MAIL_FOLDER} ]; then
    mkdir -p ${MAIL_FOLDER} && \
    chmod 750 ${MAIL_FOLDER}
fi

if [ ! -z "${ISYNC_USER_GID}" ] && [ ! -z "${ISYNC_USER_UID}" ] && [ "${ISYNC_USER_GID}" != "0" ] && [ "${ISYNC_USER_UID}" != "0" ]; then
    addgroup -g ${ISYNC_USER_GID} isync_user_group && \
    adduser -D -H -u ${ISYNC_USER_UID} -G isync_user_group isync_user

    chown isync_user.isync_user_group -R ${MAIL_FOLDER}

    echo "* * * * *	sleep ${SYNC_INTERVAL} && /usr/local/bin/mbsync -c ${SYNC_CONFIG} ${CHANNEL}" > /var/spool/cron/crontabs/isync_user && \
    chown isync_user.isync_user_group /var/spool/cron/crontabs/isync_user && \
    chmod 600 /var/spool/cron/crontabs/isync_user
else
    chown root.root -R ${MAIL_FOLDER}

    echo "* * * * *	sleep ${SYNC_INTERVAL} && /usr/local/bin/mbsync -c ${SYNC_CONFIG} ${CHANNEL}" > /var/spool/cron/crontabs/root && \
    chown root.root /var/spool/cron/crontabs/root && \
    chmod 600 /var/spool/cron/crontabs/root
fi

exec "$@"
