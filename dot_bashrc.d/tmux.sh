#!/bin/bash

function tmux_main {

    if ! tmux has-session -t main 2>/dev/null; then
        tmux new-session -s main -d
        tmux send-keys -t main 'n' C-m
        tmux split-window -h -t main
    fi

    tmux attach -t main
}
