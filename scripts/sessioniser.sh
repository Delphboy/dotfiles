#!/usr/bin/env bash
# if [[ $# -eq 1 ]]; then
#     selected=$1
# else
#     selected=$(find ~/Documents/code ~/.config/ -mindepth 1 -maxdepth 1 -type d | fzf)
# fi
#
# if [[ -z $selected ]]; then
#     exit 0
# fi
#
# selected_name=$(basename "$selected" | tr ".:, " _)
# tmux_running=$(pgrep tmux)
#
# if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
#     tmux new-session -s $selected_name -c $selected
#     tmux send-keys -t $selected_name
#     exit 0
# fi
#
# if ! tmux has-session -t=$selected_name 2> /dev/null; then
#     tmux new-session -ds $selected_name -c $selected
# fi
#
# tmux switch-client -t $selected_name



selected=$(find ~/Documents/code ~/.config/ -mindepth 1 -maxdepth 1 -type d | fzf)
if [[ -z "$selected" ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr ".:, " _)

switch_to() {
    if [[ -z "$TMUX" ]]; then
        tmux attach-session -t $selected_name
    else
        tmux switch-client -t $selected_name
    fi
}

if tmux has-session -t=$selected_name; then
    switch_to
else
    tmux new-session -ds $selected_name -c $selected
    switch_to
    tmux send-keys -t $selected_name "tmux-ready.sh" 
fi




