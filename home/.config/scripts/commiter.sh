#!/usr/bin/env bash

git=/home/vulkan/Downloads/pstar_devops

repo0="hw-moto"
repo1="derp-pstar"
repo2="derp-pstar-common"
repo3="derp-pstar-vendor"
repo4="derp-pstar-vendor-common"
repo5="cr-pstar"
repo6="cr-pstar-common"
repo7="cr-pstar-vendor"
repo8="cr-pstar-vendor-common"
repos="$repo0\n$repo1\n$repo2\n$repo3\n$repo4\n$repo5\n$repo6\n$repo7\n$repo8"

chosen="$(echo -e "$repos" | wofi --lines 15 --dmenu -p "  Commiter")"
case $chosen in
$repo0)
alacritty -t newcommit --working-directory $git/hw-moto;;
$repo1)
alacritty -t newcommit --working-directory $git/derp-pstar;;
$repo2)
alacritty -t newcommit --working-directory $git/derp-pstar-common;;
$repo3)
alacritty -t newcommit --working-directory $git/derp-pstar-vendor;;
$repo4)
alacritty -t newcommit --working-directory $git/derp-pstar-vendor-common;;
$repo5)
alacritty -t newcommit --working-directory $git/cr-pstar;;
$repo6)
alacritty -t newcommit --working-directory $git/cr-pstar-common;;
$repo7)
alacritty -t newcommit --working-directory $git/cr-pstar-vendor;;
$repo8)
alacritty -t newcommit --working-directory $git/cr-pstar-vendor-common;;

esac
exit 0;
