#!/bin/bash

APP="$1"          # application binary, e.g. "alacritty"
WORKSPACE="$2"    # special workspace name, e.g. "magic:term"

# Check if app is running
if ! pgrep -x "$APP" > /dev/null; then
    # Run app in background
    "$APP" &
    # Wait for it to start and be recognized by Hyprland
    sleep 0.5
fi

# Move app to special workspace
hyprctl dispatch movetoworkspacesilent "$WORKSPACE,^(.*$APP.*)$"
# Switch to that workspace
hyprctl dispatch workspace "$WORKSPACE"
