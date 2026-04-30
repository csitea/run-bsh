#!/bin/bash
# @description Main action for hook testing
do_test_hooks() {
  do_log "INFO Running MAIN action: do_test_hooks"
  if [[ "${FAIL_ACTION:-}" == "true" ]]; then
    do_log "ERROR Simulating action failure..."
    return 1
  fi
}
# run-bsh ::: v3.7.0
