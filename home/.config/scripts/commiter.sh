#!/usr/bin/env bash

git=/home/vitor/Downloads/pstar_devops

repo0="pstar-dt"
repo1="sm8250-common"
repo2="pstar-vendor"
repo3="vendor-sm8250"
repo4="kernel-sm8250"
repos="$repo0\n$repo1\n$repo2\n$rep3\n$repo4"

chosen="$(echo -e "$repos" | wofi --lines 15 --dmenu -p "  Commiter")"
case $chosen in
$repo0)
alacritty -t newcommit --working-directory $git/pstar-dt;;
$repo1)
alacritty -t newcommit --working-directory $git/sm8250-common;;
$repo2)
alacritty -t newcommit --working-directory $git/pstar-vendor;;
$repo3)
alacritty -t newcommit --working-directory $git/vendor-sm8250;;
$repo4)
alacritty -t newcommit --working-directory $git/kernel-sm8250;;

esac
exit 0;
