#!/usr/bin/env bash

source $HOME/.Xconfigs # My general configs

HOST=$(cat /etc/hostname)

clear

if [[ ! -d $HOME/.dotfiles ]]; then
  echo "For you to use this dotfiles, it must be located in your HOME, and hidden, the correct path is: ~/.dotfiles"
  exit
fi

if [[ $USER == "vulkan" ]]; then
  echo -e "\n${BOL_MAG}Você deseja reconfigurar suas ${BOL_CYA}configurações pessoais? ${GRE}(y/n) ${RED}[enter=no] ${END}\n"
  read answerMyConfigs

  # Generate grub
  echo -e "\n${BOL_MAG}Você deseja instalar gerar novamente o ${BOL_CYA}mkinitcpio/grub? ${GRE}(y/n) ${RED}[enter=no] ${END}\n"
  read answerGrub
fi

# Update packages and keys
sudo pacman -Syyu --noconfirm
sudo pacman-key --populate archlinux

# Makepkg optmize
bash $HOME/.dotfiles/setup/makepkg.sh

# Load packages
source $HOME/.dotfiles/setup/packages.sh

# Install YAY AUR Manager
if [[ ! -f $(which yay) ]]; then
  pwd=$(pwd)
  sudo pacman -Sy base-devel --noconfirm
  rm -rf $HOME/yay && git clone https://aur.archlinux.org/yay.git $HOME/yay && cd $HOME/yay && makepkg -si --noconfirm && rm -rf $HOME/yay
  cd $pwd
fi

# Fonts
echo -e "\n${BOL_GRE}Copying fonts${END}\n"
sudo mkdir -p /usr/share/fonts/TTF &> /dev/null
sudo cp -rf $HOME/.dotfiles/.config/fonts/* /usr/share/fonts/TTF
fc-cache -f -r -v &> /dev/null

# Install packages
InstallPacAur() {
  failed=()
  success=()

  packages=("$@")
  for package in "${packages[@]}"; do
    echo -e "\n${BLU}PACKAGE: ${BOL_BLU}${package}${END}"
    sudo pacman -S --needed --noconfirm ${package}
    RESULT=$?
    if [[ $RESULT -eq 0 ]]; then
      echo -e "${GRE}Pacman successfully installed ${MAG}${package}${END}"
      success+=($package)
    else
      echo -e "${RED}Pacman failed to install ${MAG}${package}${END} ${RED}trying to install with ${YEL}AUR${END}\n"
      yay -S --needed --noconfirm ${package}
      RESULT=$?
      if [[ $RESULT -eq 0 ]]; then
        echo -e "${GRE}AUR successfully installed ${MAG}${package}${END}"
        success+=($package)
      else
        echo -e "\n${BOL_RED} * Error:\n ${BOL_RED}* ${RED}AUR failed to install ${YEL}${package}${END}"
        failed+=($package)
      fi
    fi
  done
}

echo -e "\n${BOL_GRE}Installing packages${END}\n${MAG}"

InstallPkgs() {
  if [[ $USER != "vullk4n" ]]; then
    InstallPacAur ${dependencies[@]}
  else
    InstallPacAur ${dependencies[@]}
    InstallPacAur ${mypackages[@]}
    
  fi
}
InstallPkgs

if [[ $HOST == "vulkan" ]]; then
  echo -e "\n${BOL_GRE}Installing packages PULSAR${END}\n${MAG}"
  bash $HOME/.dotfiles/setup/pulsar.sh
  echo -e "${END}"

# Enable systemd services
echo -e "\n${BOL_GRE}Enabling services ${CYA}odin${END}\n"
for services in \
  bluetooth \
  dhcpcd \
  getty@ttyN.service; do
  sudo systemctl enable $services
  sudo systemctl start $services
done

# Permissions
echo -e "\n${BOL_GRE}Set permissions${END}\n"
sudo chown -R $USER:$USER /home/$USER

# My configs
if [[ $USER == "vulkan" ]]; then
  if [[ $answerMyConfigs != ${answerMyConfigs#[Yys]} ]]; then
    echo -e "${BOL_GRE}Ok, reconfigurando ${BOL_MAG}configurações pessoais${END}\n"
    bash $HOME/.dotfiles/setup/myconfigs.sh
  else
    echo -e "${BOL_RED}Ok, não irei reconfigurar suas ${BOL_MAG}configurações pessoais${END}\n"
  fi

  # Grub
  if [[ $answerGrub != ${answerGrub#[Yys]} ]]; then
    echo -e "${BOL_GRE}Ok, gerando ${BOL_MAG}mkinitcpio/grub${END}\n"
    sudo mkinitcpio -P
    sudo grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub
    sudo grub-mkconfig -o /boot/grub/grub.cfg
  else
    echo -e "${BOL_RED}Ok, não irei gerar o ${BOL_MAG}mkinitcpio/grub${END}\n"
  fi
fi

# Remove folder GO
rm -rf $HOME/go &> /dev/null

# Stow
bash $HOME/.dotfiles/install.sh

# Resultados finais
echo -e "\n\n${BOL_GRE}Packages success:${GRE}\n"
for i in ${success[@]}; do
  echo -e "$i"
done
echo -e "${END}"

echo -e "\n\n${BOL_RED}Packages failed:${RED}\n"
for i in ${failed[@]}; do
  echo -e "$i"
done
echo -e "${END}"
