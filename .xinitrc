#Start shortcuts daemon
sxhkd &
dunst &

#Keyboard configuartion 
xset m 1/1
setxkbmap -option caps:super
setxkbmap -option grp:alt_caps_toggle
setxkbmap us,br

#Start emacs daemon 
# /usr/bin/emacs --daemon

# Cloud files mount points
#rclone mount --daemon Livros: ~/Livros
#rclone mount --daemon Icaro: ~/Documents/Icaro

#Status bar
polybar &

#Video configurations 
#Grandr --dpi 90
#HDMI Config if nvidia is configured
feh --bg-scale ~/.dotfiles/themes/lain_wp.jpg
# xrandr --output HDMI-0 --mode 1920x1080 --rate 144; 
# xrandr --output HDMI-1 --mode 1920x1080 --rate 144
#xrandr --output HDMI-1-1 --mode 1440x900 --rate 60; 
#xrandr --output HDMI-1 --mode 1920x1080 --rate 144
xrandr --output VGA-0 --mode 1440x900 --rate 60; 
#xrandr --output 
# FIXING RESOLUTION BEGIN
#
# Setando resolução em sistemas que não vem por padrão
# cvt 1440 900 60; 
# xrandr --newmode "1440x900_60.00"  119.00  1440 1528 1672 1904  900 993 1003 1029 -hsync +vsync 
# xrandr --addmode VGA-0 "1440x900_60.00" 
# xrandr --output VGA-0 --mode "1440x900_60.00"
#
# cvt 1920 1080 60
# xrandr --newmode "1920x1080_60.00" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
# xrandr --addmode <OUTPUT_NAME> "1920x1080_60.00"

# xrandr --addmode HDMI-0 "1440x900_60.00"
# xrandr --output HDMI-0 --mode "1440x900_60.00"

# FIXING RESOLUTION END

#Start i3 window server

# Disable power saving 
xset s off
xset s off -dpms

exec i3

 /etc/xdg/autostart/gnome-keyring-*.desktop
 source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
