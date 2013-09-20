/home/zgilburd/.screenlayout/disable.sh &
xrdb -remove ~/.Xresources &
xrdb -merge ~/.Xresources &
dropbox &
thunar --daemon &
~/.screenlayout/default.sh &
pidgin &
~/bin/lockremove-checker.sh &
nitrogen --restore &
exec ck-launch-session i3
