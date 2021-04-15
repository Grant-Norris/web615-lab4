#!/bin/bash

set +e
echo "attempting to migrate to the DB"

bin/rails db:migrate 2>/dev/null
RET=$?
set -e
if [ $RET -gt 0 ]; then
  echo "migration failed creating the database"
  bin/rails db:create
  echo "migrating the database"
  bin/rails db:migrate
  bin/rails db:test:prepare
  echo "seeding the database"
  bin/rails db:seed
fi
echo "removing the old server PID"
rm -f tmp/pids/server.pid
echo "starting the webserver"
bin/rails server -p 3000 -b '0.0.0.0'