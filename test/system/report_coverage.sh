#!/bin/bash -Eu

cd "${XY_APP_DIR}"

actual_coverage_file_count() {
  # Find is less noisy than ls when there are no matches
  find "${XY_APP_DIR}" -maxdepth 1 -type f -name '.coverage*' | wc -l | xargs
}

expected_coverage_file_count() {
  # Empirically, this is what we see.
  echo "$(("${XY_WORKERS}" * 2))"
}

wait_for_all_coverage_files() {
  # We have sent a SIGHUP to gunicorn master
  # So now we have to wait for all sigterm handlers
  # to write their coverage file
  while [ "$(actual_coverage_file_count)" != "$(expected_coverage_file_count)" ]; do
    echo -n .
    sleep 0.1
  done
  echo .
}

wait_for_all_coverage_files

coverage combine "${XY_APP_DIR}" #&> /dev/null

percent=$(coverage json --quiet -o /dev/stdout | jq .totals.percent_covered)
printf "%.2f%%\n" "${percent}"

coverage html \
  --directory "${XY_APP_DIR}/test/system/coverage" \
  --precision=2 \
  --quiet
