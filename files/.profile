# 2022-05-30
# Folder : /home/
# https://doc.ubuntu-fr.org/xrandr

xrandr --newmode "3200x1800_60.00"  492.00  3200 3456 3800 4400  1800 1803 1808 1865 -hsync +vsync
xrandr --addmode DisplayPort-0 "3200x1800_60.00"
xrandr --addmode DisplayPort-1 "3200x1800_60.00"

xrandr --newmode "3328x1872_60.00"  532.25  3328 3592 3952 4576  1872 1875 1880 1939 -hsync +vsync
xrandr --addmode DisplayPort-0 "3328x1872_60.00"
xrandr --addmode DisplayPort-1 "3328x1872_60.00"

# Set -−
xrandr --output DisplayPort-0 --mode 3200x1800_60.00
xrandr --output DisplayPort-1 --mode 3200x1800_60.00

xrandr --output DisplayPort-0 --primary

# Alternative with scale, it works but also displays an error
# xrandr --output DisplayPort-0 --scale 0.85x0.85
# xrandr --output DisplayPort-1 --scale 0.85x0.85
