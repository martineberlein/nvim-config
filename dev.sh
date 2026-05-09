#!/bin/bash

SESSION="${1:-ifc}"
DIR="${2:-$(pwd)}"

if tmux has-session -t $SESSION 2>/dev/null; then
    tmux attach-session -t $SESSION
    exit 0
fi

tmux new-session -d -s $SESSION -n "code" -c "$DIR"

# Split right for claude (1/4 width)
tmux split-window -h -p 20 -t $SESSION:code -c "$DIR"
tmux send-keys -t $SESSION:code.right "claude" Enter

# Split left pane horizontally for tests
tmux select-pane -t $SESSION:code.left
tmux split-window -v -t $SESSION:code.left -c "$DIR"
tmux send-keys -t $SESSION:code.left.bottom "make test" Enter

# Focus editor pane
tmux select-pane -t $SESSION:code.left.top
tmux send-keys -t $SESSION:code.left.top "vim ." Enter

# Window 2: git
tmux new-window -t $SESSION -n "git" -c "$DIR"
tmux send-keys -t $SESSION:git "git status" Enter

# Go back to code window
tmux select-window -t $SESSION:code

tmux attach-session -t $SESSION
