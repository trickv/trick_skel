tmux-rename() {
  if [[ $# -ne 2 ]]; then
    echo "Usage: tmux-rename <session number/name> <new name>"
    return 1
  fi

  session_target="$1"
  new_name="$2"

  tmux rename-session -t "$session_target" "$new_name"
}

