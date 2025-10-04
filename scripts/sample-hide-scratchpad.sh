#!/bin/bash
APP="obsidian"
SCRATCHPAD_NAME="obsidian_scratchpad"

if ! pgrep -x "$APP" > /dev/null; then
    i3-msg "exec --no-startup-id $APP"
    sleep 1  # Give it a moment to start
    i3-msg "[class=\"$APP\"] move to scratchpad, scratchpad show"
else
    i3-msg "[con_mark=\"$SCRATCHPAD_NAME\"] scratchpad show" \
        || i3-msg "[class=\"$APP\"] move to scratchpad, scratchpad show"
fi
