#!/bin/bash

if [ ! -z "${ISYNC_USER_GID}" ] && [ ! -z "${ISYNC_USER_UID}" ]; then
    USER_EXISTS=$( grep -c '^isync_user:' /etc/passwd )

    if [ "${USER_EXISTS}" == "0" ]; then
        groupadd --gid ${ISYNC_USER_GID} isync_user_group
        adduser --gid ${ISYNC_USER_GID} --uid ${ISYNC_USER_UID} isync_user
    else
        groupmod --gid ${ISYNC_USER_GID} isync_user_group
        usermod --uid ${ISYNC_USER_UID} isync_user
    fi

    MAIL_FOLDER=$( grep "Path" ${SYNC_CONFIG} | cut -d " " -f 2 )
    mkdir -p ${MAIL_FOLDER}
    chown isync_user.isync_user_group -R ${MAIL_FOLDER}
    chmod 755 ${MAIL_FOLDER}

    echo "* * * * * sleep ${SYNC_INTERVAL} && /usr/local/bin/mbsync -c ${SYNC_CONFIG} ${CHANNEL}" > /var/spool/cron/isync_user && \
    chown isync_user.isync_user_group /var/spool/cron/isync_user && \
    chmod 400 /var/spool/cron/isync_user
else
    echo "* * * * *	sleep ${SYNC_INTERVAL} && /usr/local/bin/mbsync -c ${SYNC_CONFIG} ${CHANNEL}" > /var/spool/cron/root && \
    chown root.root /var/spool/cron/root && \
    chmod 400 /var/spool/cron/root
fi

exec "$@"
