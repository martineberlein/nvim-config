#!/bin/bash

DIR="${2:-$(pwd)}"
SESSION="${1:-$(basename $DIR)}"

if tmux has-session -t $SESSION 2>/dev/null; then
    tmux attach-session -t $SESSION
    exit 0
fi

tmux new-session -d -s $SESSION -n "code" -c "$DIR"  # pane 0: full window

# Split right for claude first (pane 1, 20% width)
tmux split-window -h -p 20 -t $SESSION:code.0 -c "$DIR"
tmux send-keys -t $SESSION:code.1 "claude" Enter

# Split left pane vertically for tests (pane 2, bottom 30%)
tmux split-window -v -p 30 -t $SESSION:code.0 -c "$DIR"

# Focus editor pane
tmux select-pane -t $SESSION:code.0
tmux send-keys -t $SESSION:code.0 "nvim" Enter

# Window 2: git
tmux new-window -t $SESSION -n "git" -c "$DIR"
tmux send-keys -t $SESSION:git "git status" Enter

# Go back to code window
tmux select-window -t $SESSION:code

tmux attach-session -t $SESSION