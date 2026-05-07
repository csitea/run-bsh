#!/bin/bash
#------------------------------------------------------------------------------
# @description Demonstrates @arg-driven named-argument parsing. Defaults to
# self-contained values so the test passes when invoked as `./run -a do_test_named_args`.
# @arg --name NAME
# @arg --force FORCE
#------------------------------------------------------------------------------

do_test_named_args() {
  local name="${NAME:-Alice}"
  local force="${FORCE:-false}"

  do_log "INFO test_named_args — name=$name force=$force"
  if [[ "$force" == "true" ]]; then
    do_log "INFO Force mode is ENABLED"
  else
    do_log "INFO Force mode is DISABLED"
  fi
  do_log "OK test_named_args passed"
}
# run-bsh ::: v3.8.1
