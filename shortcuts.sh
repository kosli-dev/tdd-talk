# See README.md

rut() { with_coverage run_unit_tests "$*"; }
eut() { with_coverage exec_unit_tests "$*"; }
rst() { with_coverage run_system_tests "$*"; }
est() { with_coverage exec_system_tests "$*"; }

tid() { "$(scripts_dir)/print_test_id.sh"; }
demo() { "$(scripts_dir)/run_demo.sh"; }

with_coverage()
{
  local -r command="${1}"
  shift
  # shellcheck disable=SC2116
  TIDS="-k $(echo "${*// / or /}")" \
    "$(scripts_dir)/${command}_with_coverage.sh"
}

scripts_dir() {
  cd "$(dirname "${BASH_SOURCE[0]}")/scripts" && pwd
}

# shellcheck disable=SC2116
# Replacing
#    TIDS=$(echo "${*// / or /}")
# with
#    TIDS="$(*// / or /)"
# causes warning
#    rut:N: permission denied: __pycache__//
