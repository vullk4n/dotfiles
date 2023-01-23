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

function translate() {
  typing=$(mktemp)
  rm -rf $typing && nano $typing
  msg=$(trans -b :en -no-auto -i $typing)
  cat $typing
}

if [ $HOST = "vulkan" ]; then
  cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
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
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
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

# play audio based search
yplay() {
    mpv --ytdl-format=bestaudio ytdl://ytsearch:"$*"
}

# play video based on the clipboard
play() {
        mpv "$(wl-paste 2>/dev/null || xclip -o 2>/dev/null)"
}

# download files based on the clipboard
down() {
    aria2c "$(wl-paste 2>/dev/null || xclip -o 2>/dev/null)"
}

pkginf() {
    clear && pacman -Si $@ | awk '/Name/{print "Package: " $3}/Version/{print "Version: " $3}/Installed Size/{printf "Size: %s %s\n", $4, $5}'
}

pkginf1() {
   clear && pacman -Q $@
}

usage() {
    for p in "$@" ; do
        if pidof $p >/dev/null ; then
            RAM=$(echo $(ps -A --sort -rsz -o comm,rss | grep $p | sed -n 1p | sed 's/.* //g') / 1000 | bc)
            PRAM=$(ps -A --sort -rsz -o comm,pmem | grep $p | sed -n 1p | sed 's/.* //g')
            PCPU=$(ps -A --sort -rsz -o comm,pcpu | grep $p | sed -n 1p | sed 's/.* //g')
            echo "$p está usando ${RAM}mb de RAM (${PRAM}%) e ${PCPU}% de CPU"
        else
            echo "$p não está rodando."
        fi
    done
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
ssh vitor@100.110.145.82
}

job () {
cd Downloads
mkdir github
cd github
git clone https://github.com/DerpFest-Devices/device_motorola_ocean    ocean-dt
git clone https://github.com/DerpFest-Devices/device_motorola_river    river-dt
git clone https://github.com/DerpFest-Devices/device_motorola_sdm632-common common-tree
git clone https://github.com/DerpFest-Devices/vendor_motorola_ocean   vendor-ocean
git clone https://github.com/DerpFest-Devices/vendor_motorola_river   vendor-river
git clone https://github.com/DerpFest-Devices/vendor_motorola_sdm632-common  vendor-common
git clone https://github.com/DerpFest-Devices/kernel_motorola_sdm632   kernel
}
