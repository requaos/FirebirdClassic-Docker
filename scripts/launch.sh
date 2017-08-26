#!/bin/bash
set -e

if [ "$1" = 'xinetd' ]; then
    chown -R firebird:firebird /db
    exec gosu xinetd "$@"
fi

exec "$@"