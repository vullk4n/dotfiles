#!/usr/bin/env bash

if [[ $USER = "vulkan" ]]; then
  pwd=$(pwd) && cd $HOME
  git config --global user.email "vulkanops@gmail.com"
  git config --global user.name "vullk4n"
  git config --global http.postBuffer 524288000
  mkdir -p $HOME/{Images,Docs,Videos} &>/dev/null
  cd $pwd
fi


pwd=$(pwd)
rm -rf $HOME/yay && git clone https://aur.archlinux.org/yay.git $HOME/yay && cd $HOME/yay && makepkg -si --noconfirm && rm -rf $HOME/yay
cd $pwd


source $HOME/.dotfiles/setup/packages.sh


curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | gpg --import -


for i in "${PACKAGES[@]}"; do
  sudo pacman -Sy ${i} --needed --noconfirm
done

for i in "${AUR[@]}"; do
  yay -Sy ${i} --needed --noconfirm
done

source $HOME/.dotfiles/setup/etc.sh

chsh -s $(which zsh)
