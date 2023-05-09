setxkbmap -option caps:super
eval `ssh-agent`
sxhkd &
#xrandr -s 1440x900 --set audio on
#/usr/bin/emacs --daemon
feh --bg-scale ~/.dotfiles/themes/lain_wp3.jpg
#rclone mount --daemon Livros: ~/Livros
#rclone mount --daemon IcaroZweig: ~/mount/Icaro-Zweig
xset m 1/1
#polybar &
exec i3
