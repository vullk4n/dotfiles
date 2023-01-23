#!/usr/bin/env bash

github=/home/vitor/Downloads/github

repo0="ocean-dt"
repo1="river-dt"
repo2="common-tree"
repo3="vendor-ocean"
repo4="vendor-river"
repo5="vendor-common"
repo6="kernel"
repos="$repo0\n$repo1\n$repo2\n$repo3\n$repo4\n$repo5\n$repo6"

chosen="$(echo -e "$repos" | wofi --lines 15 --dmenu -p "  Commiter")"
case $chosen in
$repo0)
alacritty -t newcommit --working-directory $github/ocean-dt;;
$repo1)
alacritty -t newcommit --working-directory $github/river-dt;;
$repo2)
alacritty -t newcommit --working-directory $github/common-tree;;
$repo3)
alacritty -t newcommit --working-directory $github/vendor-ocean;;
$repo4)
alacritty -t newcommit --working-directory $github/vendor-river;;
$repo5)
alacritty -t newcommit --working-directory $github/vendor-common;;
$repo6)
alacritty -t newcommit --working-directory $github/kernel;;

esac
exit 0;
