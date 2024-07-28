#!/usr/bin/env bash
# Thanks, Prime
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/Documents/git -mindepth 1 -maxdepth 1 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then # If we aren't in tmux but it is running
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

# if ! tmux has-session -t=$selected_name 2> /dev/null; then
#     tmux new-session -ds $selected_name -c $selected
# fi
if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

if tmux list-clients | grep -q "$selected_name"; then
    tmux switch-client -t $selected_name
else
    tmux attach-session -t $selected_name
fi


tmux switch-client -t $selected_name
