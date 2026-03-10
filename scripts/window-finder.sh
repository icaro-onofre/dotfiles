chosen=$(hyprctl clients -j | jq -r '.[] | "\(.class) - \(.title) [\(.address)]"' | rofi -dmenu)  
  
addr=$(echo "$chosen" | grep -o '\[.*\]' | tr -d '[]')  
  
[ -n "$addr" ] && hyprctl dispatch focuswindow address:$addr

