#!/usr/bin/env sh

set -e

command="$1"

case $command in
     server)
          /usr/local/bin/confd -onetime -backend=env
          /go/bin/bifrost server -c /bifrost.cfg
          ;;
     init)
          shift
          DB_URL=$BIFROST_DB_DSN DB_DUMP_FILE=/go/src/github.com/stellar/go/services/bifrost/database/migrations/01_init.sql /go/bin/initbifrost
          ;;
     *)
          echo "Wrong command `$command`" && false;
          ;;
esac

