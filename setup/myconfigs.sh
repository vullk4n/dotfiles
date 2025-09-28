#!/usr/bin/env bash

source $HOME/.Xconfigs # My general configs

clear

pwd=$(pwd)
cd $HOME

# Git
git config --global user.email "vulkanops@gmail.com" && git config --global user.name "vullk4n"

# Dirs
mkdir -p $HOME/{Images,Downloads/Arch,Videos,GitHub,.ssh} &> /dev/null

cd $pwd
