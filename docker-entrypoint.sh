#!/bin/bash

MAIL_FOLDER=$( grep "Path" ${SYNC_CONFIG} | cut -d " " -f 2 )

if [ ! -d ${MAIL_FOLDER} ]; then
    mkdir -p ${MAIL_FOLDER}
    chmod 750 ${MAIL_FOLDER}
fi

if [ ! -z "${ISYNC_USER_GID}" ] && [ ! -z "${ISYNC_USER_UID}" ] && [ "${ISYNC_USER_GID}" != "0" ] && [ "${ISYNC_USER_UID}" != "0" ]; then
    USER_EXISTS=$( grep -c '^isync_user:' /etc/passwd )

    if [ "${USER_EXISTS}" == "0" ]; then
        groupadd --gid ${ISYNC_USER_GID} isync_user_group
        adduser --gid ${ISYNC_USER_GID} --uid ${ISYNC_USER_UID} isync_user
    else
        groupmod --gid ${ISYNC_USER_GID} isync_user_group
        usermod --uid ${ISYNC_USER_UID} isync_user
    fi

    chown isync_user.isync_user_group -R ${MAIL_FOLDER}

    echo "* * * * * sleep ${SYNC_INTERVAL} && /usr/local/bin/mbsync -c ${SYNC_CONFIG} ${CHANNEL}" > /var/spool/cron/isync_user && \
    chown isync_user.isync_user_group /var/spool/cron/isync_user && \
    chmod 400 /var/spool/cron/isync_user
else
    chown root.root -R ${MAIL_FOLDER}

    echo "* * * * *	sleep ${SYNC_INTERVAL} && /usr/local/bin/mbsync -c ${SYNC_CONFIG} ${CHANNEL}" > /var/spool/cron/root && \
    chown root.root /var/spool/cron/root && \
    chmod 400 /var/spool/cron/root
fi

exec "$@"
