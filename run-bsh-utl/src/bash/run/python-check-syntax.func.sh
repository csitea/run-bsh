#!/bin/bash
#------------------------------------------------------------------------------
# @description Compile-check every .py under PROJ_PATH (skipping vendor + .git
#              + dat/). Uses python3 -m py_compile on each file and reports a
#              pass/fail summary. Returns 11 if any file fails to compile.
# @param       SKIP_GLOB  (optional) — extra grep -vE pattern to exclude paths.
#                                       Defaults to vendor/dat/.git/.bak.
# @example     ./run -a do_python_check_syntax
# @example     SKIP_GLOB='generated|legacy' ./run -a do_python_check_syntax
#------------------------------------------------------------------------------

do_python_check_syntax() {
  do_require_bin python3 find || return $?

  local skip_re="${SKIP_GLOB:-/vendor/|/\.git/|/dat/|\.bak$|\.pyc$}"
  local total=0 ok=0 fail=0
  local failed_files=()
  local f errmsg

  do_log "INFO scanning ${PROJ_PATH:-$(pwd)} for *.py (skipping: $skip_re)"

  while IFS= read -r -d '' f; do
    total=$((total + 1))
    if errmsg=$(python3 -m py_compile "$f" 2>&1); then
      ok=$((ok + 1))
    else
      fail=$((fail + 1))
      failed_files+=("$f")
      do_log "ERROR py_compile failed: $f"
      do_log "ERROR  ↳ $errmsg"
    fi
  done < <(find "${PROJ_PATH:-$(pwd)}" -type f -name '*.py' -print0 2>/dev/null \
            | grep -zvE "$skip_re" \
            | sort -z)

  do_log "INFO ════════════════════════════════════════"
  do_log "INFO python-syntax: $ok/$total OK, $fail failed"

  if (( fail > 0 )); then
    do_log "ERROR failing files:"
    local ff
    for ff in "${failed_files[@]}"; do
      do_log "ERROR   $ff"
    done
    return 11
  fi
  do_log "OK python-syntax — all $total files compile cleanly"
}
# run-bsh ::: v3.8.1
