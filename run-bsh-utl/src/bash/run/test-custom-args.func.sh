#!/bin/bash
#------------------------------------------------------------------------------
# @description Example action using custom getopts parsing logic.
#------------------------------------------------------------------------------

do_test_custom_args_args() {
  do_log "INFO Running custom getopts parsing for this action..."
  while getopts "n:f" opt; do
    case $opt in
      n) export NAME="$OPTARG" ;;
      f) export FORCE="true" ;;
      *) return 1 ;;
    esac
  done
}

do_test_custom_args() {
  do_require_var NAME "${NAME:-}"
  do_log "INFO Custom Parse Result: Name=$NAME, Force=${FORCE:-false}"
}
# run-bsh ::: v3.7.0
