#!/bin/bash

selected=$(tmux ls | fzf | cut -d: -f1)
tmux switch-client -t $selected

