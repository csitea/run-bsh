#------------------------------------------------------------------------------
# @description Opens each sibling project directory under APP_PATH in a new
# @description tmux window and attaches to the session.
# @example ./run -a do_open_app_projects_in_tmux
#------------------------------------------------------------------------------
do_open_app_projects_in_tmux() {

  local SESSION="sess-${ORG}-${APP}"
  tmux new-session -d -s "$SESSION" || {
    echo "Failed to create session"
    exit 1
  }

  if test -f "$APP_PATH/.tmux/dirs.lst"; then
    mapfile -t dirs <"$APP_PATH/.tmux/dirs.lst"
  else
    dirs=($(find "$APP_PATH" -mindepth 1 -maxdepth 1 -type d))
  fi

  for dir in "${dirs[@]}"; do
    if [[ ! -d "$dir" ]]; then
      echo "Error: Directory does not exist - $dir"
      continue
    fi

    local base_name
    base_name=$(basename "$dir")
    local window_name
    window_name=$(printf '%.30s' "$base_name    ")

    local window_id
    window_id=$(tmux new-window -t "$SESSION" -n "$window_name" -P -F "#{window_id}" "cd \"$dir\" && bash -i") || {
      echo "Failed to create window: $window_name for dir: $dir"
      continue
    }

    tmux rename-window -t "$window_id" "$window_name" || {
      echo "Failed to rename window ID: $window_id to $window_name"
      continue
    }

    echo "Created and renamed window: $window_name (ID: $window_id) for directory: $dir"
  done

  tmux attach -t "$SESSION" || {
    echo "Failed to attach to session: $SESSION"
    exit 1
  }

  export EXIT_CODE="0"
}
# run-bsh ::: v3.7.0
