#!/bin/bash
#------------------------------------------------------------------------------
# @description Test action for decentralized named argument parsing.
#------------------------------------------------------------------------------

# Each action now defines its own parsing logic in an _args hook
do_test_named_args_args() {
  # This action chooses to use the standard helper
  do_parse_args "$@"
}

do_test_named_args() {
  do_require_var NAME "${NAME:-}"
  
  do_log "INFO Hello, $NAME!"
  if [[ "${FORCE:-}" == "true" ]]; then
    do_log "INFO Force mode is ENABLED."
  else
    do_log "INFO Force mode is DISABLED."
  fi
}
# run-bsh ::: v3.7.0
