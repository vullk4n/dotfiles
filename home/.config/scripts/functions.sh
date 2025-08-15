#!/usr/bin/env bash

source $HOME/.colors &>/dev/null

f() {
  git fetch https://github.com/${1} ${2}
}

p() {
  git cherry-pick ${1}
}

cc() {
  git add . && git cherry-pick --continue
}

a() {
  git cherry-pick --abort
}

translate() {
  typing=$(mktemp)
  rm -rf $typing && nano $typing
  msg=$(trans -b :en -no-auto -i $typing)
  cat $typing
}

if [ $HOST = "vulkan" ]; then
  cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vullk4n <vulkanops@gmail.com>" && git push -f
  }
  c() {
    git add . && git commit --author "${1}" && git push -f
  }
  amend() {
    git add . && git commit --signoff --amend && git push -f
  }
else
  cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vullk4n <vulkanops@gmail.com>" && git push -f
  }
  c() {
    git add . && git commit --author "${1}"
  }
  amend() {
    git add . && git commit --amend
  }
fi

upd() {
  $HOME/.config/scripts/pacman-update.sh
}

sshgen() {
  ssh-keygen -t ed25519 -C "vulkanops@gmail.com"
  eval "$(ssh-agent -s)" && ssh-add -l
  cat $HOME/.ssh/id_ed25519.pub | wl-copy
  xdg-open https://github.com/settings/ssh/new
}

wifi() {
  interface=$(cat /proc/net/wireless | perl -ne '/(\w+):/ && print $1')
  iwctl station $interface scan && sleep 3
  iwctl station $interface get-networks
  echo "${BLU}Which network do you want to connect to?${END} "; read wifi
  iwctl station $interface connect "${wifi}"
}

vm () {
sudo systemctl enable --now tailscaled
sudo tailscale up
ssh vulkan@100.90.167.139
}

job () {
cd Downloads
mkdir pstar_devops
cd pstar_devops
git clone https://github.com/vullk4n/hardware_motorola  hw-moto
git clone https://github.com/DerpFest-Devices/device_motorola_pstar derp-pstar
git clone https://github.com/DerpFest-Devices/device_motorola_nio derp-nio
git clone https://github.com/DerpFest-Devices/device_motorola_sm8250-common derp-pstar-common
git clone https://github.com/DerpFest-Devices/vendor_motorola_pstar derp-pstar-vendor
git clone https://github.com/DerpFest-Devices/vendor_motorola_nio derp-nio-vendor
git clone https://github.com/DerpFest-Devices/vendor_motorola_sm8250-common derp-pstar-vendor-common
}

stock() {
  $HOME/.config/scripts/stock.sh
}

gki() {
 sudo fastboot flash boot boot.img
 sudo fastboot flash vendor_boot vendor_boot.img
 sudo fastboot flash dtbo dtbo.img
}
