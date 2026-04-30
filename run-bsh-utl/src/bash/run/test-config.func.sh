#!/bin/bash
#------------------------------------------------------------------------------
# @description Test action to verify configuration loading and overrides.
# @example ./run -a do_test_config
# @output Logs the value of OVERRIDE_VAR (or "not_set" if unloaded)
#------------------------------------------------------------------------------
do_test_config() {
  do_log "INFO Checking loaded variables:"
  do_log "INFO OVERRIDE_VAR: ${OVERRIDE_VAR:-not_set}"
}
# run-bsh ::: v3.7.0
