# See README.md

rut() { testing unit run "$*"; }
eut() { testing unit exec "$*"; }
rst() { testing system run "$*"; }
est() { testing system exec "$*"; }

tid() { "$(scripts_dir)/print_test_id.sh"; }
demo() { "$(scripts_dir)/run_demo.sh"; }
hup() { "$(scripts_dir)/hup.sh"; }

testing()
{
  local -r scope="${1}"; shift
  local -r command="${1}"; shift
  TIDS="-k ${*// / or }" \
    "$(scripts_dir)/test/${scope}/${command}.sh"
}

scripts_dir()
{
  # BASH_SOURCE is empty inside a 'sourced' script
  local -r repo_home=$(git rev-parse --show-toplevel)
  echo "${repo_home}/scripts"
}

