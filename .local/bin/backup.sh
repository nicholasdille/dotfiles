#!/bin/bash
set -o errexit

TIMESTAMP="$(
    date +%Y%m%d-%H%M%S
)"

FILES="$(
    find "${HOME}/.local/etc/backup.d" -type f -name \*.sh \
    | while read FILE; do
        source ${FILE}
    done
)"

tar -czf "${HOME}/backup-${TIMESTAMP}.tar.gz" ${FILES}
