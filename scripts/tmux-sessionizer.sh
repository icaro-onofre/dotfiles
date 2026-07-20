#!/usr/bin/env bash
# tmux session picker: attach to an existing session,
# or type a new name to create + attach to it.

sessions=$(tmux list-sessions -F '#{session_name}' 2>/dev/null)

# --print-query lets us capture what was typed even if nothing was selected
selected=$(printf '%s\n' "$sessions" | fzf \
    --reverse \
    --print-query \
    --prompt="tmux session > " \
    --header="Enter: attach existing  |  type a new name + Enter: create it" \
    | tail -n1)

# nothing typed / Esc pressed
[ -z "$selected" ] && exit 0

if printf '%s\n' "$sessions" | grep -qx "$selected"; then
    target="$selected"
else
    tmux new-session -d -s "$selected"
    target="$selected"
fi

if [ -n "$TMUX" ]; then
    tmux switch-client -t "$target"
else
    tmux attach-session -t "$target"
fi
