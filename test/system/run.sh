#!/bin/bash -Eeu

pytest \
  --capture=no \
  --color=yes \
  --ignore="${XY_CONTAINER_DIR}/test/unit" \
  --no-cov \
  -o cache_dir=/tmp \
  --pythonwarnings=error \
  --quiet \
  --random-order-bucket=global \
  --tb=short \
  --workers auto \
    "${TIDS}"
