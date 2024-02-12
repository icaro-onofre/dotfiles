sxhkd &
setxkbmap -option caps:super
setxkbmap -option grp:alt_caps_toggle
setxkbmap us,br
feh --bg-scale ~/.dotfiles/themes/lain_wp.jpg
xrandr --output DP-1 --off
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
usr/bin/emacs --daemon
xset m 1/1
exec i3
#rclone mount --daemon Livros: ~/Livros
#rclone mount --daemon IcaroZweig: ~/mount/Icaro-Zweig
#polybar &
