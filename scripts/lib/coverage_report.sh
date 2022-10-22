#!/usr/bin/env bash
set -Eeu

curl \
  --request POST \
  --silent \
  http://localhost:80/api/coverage/report \
    > /dev/null

echo "${XY_HOME_DIR}/test/system/coverage/index.html"
