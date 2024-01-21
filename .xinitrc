sxhkd &
setxkbmap -option caps:super
setxkbmap -option grp:alt_caps_toggle
setxkbmap us,br
feh --bg-scale ~/.dotfiles/themes/kiki_wallpaper.jpg
xrandr --output DP-1 --off
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
usr/bin/emacs --daemon
xset m 1/1
exec i3
