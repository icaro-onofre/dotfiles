#Start shortcuts daemon
sxhkd &

#Keyboard configuartion 
xset m 1/1
setxkbmap -option caps:super
setxkbmap -option grp:alt_caps_toggle
setxkbmap us,br

#Start emacs daemon 
#/usr/bin/emacs --daemon

# Cloud files mount points
#rclone mount --daemon Livros: ~/Livros
#rclone mount --daemon Icaro: ~/Documents/Icaro

#Status bar
#polybar &

#Video configurations 
#xrandr -s 1440x900 --set audio on
xrandr --dpi 90
#HDMI Config if nvidia is configured
feh --bg-scale ~/.dotfiles/themes/lain_wp.jpg
#xrandr --output HDMI-1-0 --auto; xrandr --output DP-1 --off;feh --bg-scale ~/.dotfiles/themes/lain_wp.jpg
#xrandr --output 

#Start i3 window server
exec i3
