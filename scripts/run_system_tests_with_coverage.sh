#!/usr/bin/env bash
set -Eeu

export XY_LIB_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/lib"; pwd)"
source "${XY_LIB_DIR}/echo_env_vars.sh"
export $(echo_env_vars)

"${XY_LIB_DIR}/build_image.sh"
"${XY_LIB_DIR}/network_up.sh"
"${XY_LIB_DIR}/server_up.sh"
"${XY_LIB_DIR}/wait_till_server_ready.sh"
"${XY_LIB_DIR}/../exec_system_tests_with_coverage.sh"
