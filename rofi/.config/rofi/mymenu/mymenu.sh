#!/usr/bin/env bash

git=/home/vulkan/Downloads/pstar_devops

repo0="hw-moto"
repo1="derp-pstar"
repo2="derp-nio"
repo3="derp-common"
repo4="derp-pstar-vendor"
repo5="derp-nio-vendor"
repo6="derp-vendor-common"
repos="$repo0\n$repo1\n$repo2\n$repo3\n$repo4\n$repo5\n$repo6"

chosen="$(echo -e "$repos" | wofi --lines 15 --dmenu -p "  Commiter")"
case $chosen in
$repo0)
alacritty -t newcommit --working-directory $git/hw-moto;;
$repo1)
alacritty -t newcommit --working-directory $git/derp-pstar;;
$repo2)
alacritty -t newcommit --working-directory $git/derp-nio;;
$repo3)
alacritty -t newcommit --working-directory $git/derp-common;;
$repo4)
alacritty -t newcommit --working-directory $git/derp-pstar-vendor;;
$repo5)
alacritty -t newcommit --working-directory $git/derp-nio-vendor;;
$repo6)
alacritty -t newcommit --working-directory $git/derp-vendor-common;;

esac
exit 0;
