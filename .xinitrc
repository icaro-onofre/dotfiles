setxkbmap -option caps:super
sxhkd &
xset m 1/1
setxkbmap -option caps:super
setxkbmap -option grp:alt_caps_toggle
setxkbmap us,br
#xrandr -s 1440x900 --set audio on
#/usr/bin/emacs --daemon
feh --bg-scale ~/.dotfiles/themes/lain_wp.jpg
rclone mount --daemon Livros: ~/Livros
#rclone mount --daemon IcaroZweig: ~/mount/Icaro-Zweig
#polybar &
#HDMI Config if nvidia is configured
xrandr --output HDMI-1-0 --auto; xrandr --output DP-1 --off
xrandr --output 
exec i3
