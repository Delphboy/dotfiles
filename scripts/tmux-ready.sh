#!/bin/bash

if [[ -x ./.ready-tmux ]]; then
    ./.ready-tmux
elif [[ -x ~/.ready-tmux ]]; then
    ~/.ready-tmux
fi

clear

