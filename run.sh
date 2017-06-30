#!/bin/sh

set -e

j2 ircd.j2 > ircd.yaml

if [ ! -f ircd.db ]; then
  ./oragono initdb
fi

if [ ! -f tls.crt ]; then
  ./oragono mkcerts
fi

exec ./oragono run
