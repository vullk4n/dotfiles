#!/bin/sh

xrandr --setprovideroutputsource modesetting Intel
xrandr --auto

xrdb -merge ~/.Xresources

fc-cache -f -r -v

exec i3
