#!/bin/bash

# Colors (ARGB format for hyprctl)
SHARING_COLOR="ffff0000"   # red border when sharing
NORMAL_COLOR="ff44475a"    # your normal border color

SHARING=false

while true; do
    # Detect active PipeWire screenshare session via xdg-desktop-portal
    IS_SHARING=$(gdbus call --session \
        --dest org.freedesktop.portal.Desktop \
        --object-path /org/freedesktop/portal/desktop \
        --method org.freedesktop.DBus.Properties.Get \
        org.freedesktop.portal.ScreenCast NbActiveScreenCastSessions 2>/dev/null \
        | grep -oP '\d+')

    if [[ "$IS_SHARING" -gt 0 ]] && [[ "$SHARING" == false ]]; then
        SHARING=true
        hyprctl keyword general:col.active_border "rgba(${SHARING_COLOR}ee) rgba(ff880000)ee 45deg"
        notify-send -u critical "🔴 Screen Sharing" "Your screen is being shared"

    elif [[ "$IS_SHARING" -eq 0 ]] && [[ "$SHARING" == true ]]; then
        SHARING=false
        hyprctl keyword general:col.active_border "rgba(${NORMAL_COLOR}ee)"
        notify-send "🟢 Screen Sharing" "Screen sharing stopped"
    fi

    sleep 2
done
