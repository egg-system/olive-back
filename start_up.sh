#!/usr/bin/env bash
rm -rf /usr/local/src/tmp/pids/server.pid
foreman start -f Procfile.dev-server
