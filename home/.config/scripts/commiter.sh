#!/usr/bin/env bash

git=/home/vitor/Downloads/pstar_devops

repo0="pstar-tree"
repo1="vendor-pstar"
repo2="kernel-sm8250"
repos="$repo0\n$repo1\n$repo2"

chosen="$(echo -e "$repos" | wofi --lines 15 --dmenu -p "  Commiter")"
case $chosen in
$repo0)
alacritty -t newcommit --working-directory $git/pstar-tree;;
$repo1)
alacritty -t newcommit --working-directory $git/vendor-pstar;;
$repo2)
alacritty -t newcommit --working-directory $git/kernel-sm8250;;

esac
exit 0;
