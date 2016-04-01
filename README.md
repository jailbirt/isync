# Supported tags and respective ``Dockerfile`` links

* [`latest`, `1.2.1-2.1` (docker/Dockerfile)](https://github.com/bcouto/isync/blob/master/Dockerfile)
* [`1.2.1-1.0` (docker/Dockerfile)](https://github.com/bcouto/isync/blob/1.2.1-1.0/Dockerfile)

# isync:
A command line application which synchronizes mailboxes; currently Maildir and IMAP4 mailboxes are supported. New messages, message deletions and flag changes can be propagated both ways. isync is suitable for use in IMAP-disconnected mode.

Synchronization is based on unique message identifiers (UIDs), so no identification conflicts can occur (as opposed to some other mail synchronizers).
Synchronization state is kept in one local text file per mailbox pair; multiple replicas of a mailbox can be maintained.

isync website: http://isync.sourceforge.net/

# Features:
* Fine-grained selection of synchronization operations to perform
* Synchronizes single mailboxes or entire mailbox collections
* Partial mirrors possible: keep only the latest messages locally
* Trash functionality: backup messages before removing them
* IMAP features:
* TLS/SSL via IMAPS and STARTTLS for encryption
* SASL for authentication
* Pipelining for maximum speed

# Running isync:
```
docker run \
    -ti \
    --rm \
    -v /mail/:/mail/ bcouto/isync \
    mbsync -c <config file (e.g. /mail/mbsync.conf)> <channel> 
```

# Running isync service:
```
docker run \
    -ti \
    --rm \
    -v /mail/:/mail/ \
    -e SYNC_INTERVAL=300 \
    -e SYNC_CONFIG=/mail/mbsync.conf \
    -e CHANNEL=<channel> bcouto/isync
```
docker-compose.yml:
```
version: '2'

services:
    isync:
        image: bcouto/isync
        environment:
            - SYNC_INTERVAL=300
            - SYNC_CONFIG=/mail/mbsync.conf
            - CHANNEL=<channel>
        volumes:
            - /mail/:/mail/
```
