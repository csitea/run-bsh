#!/bin/bash
#------------------------------------------------------------------------------
# @description Demonstrates a custom getopts _args hook. Defaults to
# self-contained values so the test passes when invoked as `./run -a do_test_custom_args`.
#------------------------------------------------------------------------------

do_test_custom_args_args() {
  do_log "DEBUG test_custom_args _args hook running"
  while getopts "n:f" opt; do
    case $opt in
      n) export NAME="$OPTARG" ;;
      f) export FORCE="true" ;;
      *) return 1 ;;
    esac
  done
}

do_test_custom_args() {
  local name="${NAME:-Bob}"
  local force="${FORCE:-false}"
  do_log "INFO test_custom_args — name=$name force=$force"
  do_log "OK test_custom_args passed"
}
# run-bsh ::: v3.8.1
