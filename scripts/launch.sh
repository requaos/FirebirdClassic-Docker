#!/bin/bash
set -e
chown -R firebird:firebird /db
exec gosu xinetd -dontfork "$@"