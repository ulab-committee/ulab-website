#!/bin/sh

set -e

if [ -f tmp/pids/server.pid ]; then
  rm tmp/pids/server.pid
fi

bin/rails assets:precompile
bin/rails s -p 3000 -b '0.0.0.0'
