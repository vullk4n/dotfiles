#!/usr/bin/env bash

github=/home/vitor/Downloads/sm8250

repo0="pstar-dt"
repo1="sm8250_common-tree"
repo2="vendor-pstar"
repo3="vendor_sm8250-common"
repo4="kernel-sm8250"
repos="$repo0\n$repo1\n$repo2\n$repo3\n$repo4"

chosen="$(echo -e "$repos" | wofi --lines 15 --dmenu -p "  Commiter")"
case $chosen in
$repo0)
alacritty -t newcommit --working-directory $github/pstar-dt;;
$repo1)
alacritty -t newcommit --working-directory $github/sm8250_common-tree;;
$repo2)
alacritty -t newcommit --working-directory $github/vendor-pstar;;
$repo3)
alacritty -t newcommit --working-directory $github/vendor_sm8250-common;;
$repo4)
alacritty -t newcommit --working-directory $github/kernel-sm8250;;

esac
exit 0;
