#!/bin/bash
#------------------------------------------------------------------------------
# @description Hierarchical configuration loader.
# @description Loads proj.cnf then $USER.cnf (highest priority).
# @description Later files overwrite earlier ones. Missing files are silently skipped.
# @example do_load_config
#------------------------------------------------------------------------------
do_load_config() {
  local conf_dir="${PROJ_PATH:-}/cnf/bash"

  # Exit silently if config directory doesn't exist
  [[ ! -d "$conf_dir" ]] && return 0

  # Config files in override order (later files overwrite earlier ones)
  local config_files=(
    "proj.cnf"
    "${USER:-}.cnf"
  )

  for cnf_file in "${config_files[@]}"; do
    # Skip if filename is invalid (e.g., if USER is unset resulting in ".cnf")
    [[ -z "$cnf_file" || "$cnf_file" == ".cnf" ]] && continue

    local cnf_path="$conf_dir/$cnf_file"
    if [[ -f "$cnf_path" ]]; then
      do_log "INFO Loading config: $cnf_file"
      source "$cnf_path"
    fi
  done
}
