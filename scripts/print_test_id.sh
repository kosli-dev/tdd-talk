#!/usr/bin/env bash
set -Eeu

readonly XY_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/lib"; pwd)"
source "${XY_LIB_DIR}/echo_env_vars.sh"
export $(echo_env_vars)

docker run \
  --entrypoint="" \
  --interactive \
  --rm \
  --tty \
  --volume="${XY_HOME_DIR}/test:/${XY_DIR}/test:ro" \
  "${XY_IMAGE}" \
    "/${XY_DIR}/test/print_id.py"
