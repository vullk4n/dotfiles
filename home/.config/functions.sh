#!/usr/bin/env bash

source $HOME/.colors &>/dev/null

function f() {
  git fetch https://github.com/${1} ${2}
}

function p() {
  git cherry-pick ${1}
}

function cc() {
  git add . && git cherry-pick --continue
}

function a() {
  git cherry-pick --abort
}

function translate() {
  typing=$(mktemp)
  rm -rf $typing && nano $typing
  msg=$(trans -b :en -no-auto -i $typing)
  cat $typing
}

if [ $HOST = "vulkan" ]; then
  function cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
  }
  function c() {
    git add . && git commit --author "${1}" && git push -f
  }
  function amend() {
    git add . && git commit --signoff --amend && git push -f
  }
else
  function cm() {
    translate
    git add . && git commit --message $msg --signoff --author "vulkan-ops <vulkanops@gmail.com>" && git push -f
  }
  function c() {
    git add . && git commit --author "${1}"
  }
  function amend() {
    git add . && git commit --amend
  }
fi

function upd() {
  $HOME/.config/scripts/pacman-update.sh
}

function sshgen() {
  ssh-keygen -t ed25519 -C "vulkanops@gmail.com"
  eval "$(ssh-agent -s)" && ssh-add -l
  cat $HOME/.ssh/id_ed25519.pub | wl-copy
  xdg-open https://github.com/settings/ssh/new
}

function wifi() {
  interface=$(cat /proc/net/wireless | perl -ne '/(\w+):/ && print $1')
  iwctl station $interface scan && sleep 3
  iwctl station $interface get-networks
  echo "${BLU}Which network do you want to connect to?${END} "; read wifi
  iwctl station $interface connect "${wifi}"
}

function fetch() {
  ./.dotfiles/home/.config/scripts/fetch.sh gnu
}

function vm () {
ssh vitor@casa.luizdores.com.br
}

function dt () {
git clone https://github.com/PixelExperience/hardware_qcom-caf_msm8996_display hardware/qcom-caf/msm8996/display
git clone https://github.com/PixelExperience/hardware_qcom-caf_msm8996_media hardware/qcom-caf/msm8996/media
git clone https://github.com/PixelExperience/hardware_qcom-caf_msm8996_audio hardware/qcom-caf/msm8996/audio
}

function derp () {
#git clone https://github.com/vulkan-ops/device_motorola_channel -b derp  device/motorola/channel
git clone https://github.com/vulkan-ops/device_motorola_ocean  -b derp  device/motorola/ocean
#git clone https://github.com/vulkan-ops/device_motorola_river  -b derp  device/motorola/river
git clone https://github.com/vulkan-ops/device_motorola_sdm632-common   device/motorola/sdm632-common
git clone https://github.com/vulkan-ops/vendor_motorola_ocean   vendor/motorola/ocean
#git clone https://github.com/vulkan-ops/vendor_motorola_channel   vendor/motorola/channel
#git clone https://github.com/vulkan-ops/vendor_motorola_river   vendor/motorola/river
git clone https://github.com/vulkan-ops/vendor_motorola_sdm632-common  vendor/motorola/sdm632-common
git clone https://github.com/vulkan-ops/kernel_motorola_sdm632   kernel/motorola/sdm632
}

function job () {
cd Downloads
mkdir github
cd github
git clone https://github.com/vulkan-ops/arch archlinux
git clone https://github.com/vulkan-ops/device_motorola_ocean ocean-dt
git clone https://github.com/vulkan-ops/device_motorola_channel	channel-dt
git clone https://github.com/vulkan-ops/device_motorola_river	river-dt
git clone https://github.com/vulkan-ops/device_motorola_sdm632-common  common-tree
git clone https://github.com/vulkan-ops/vendor_motorola_ocean  vendor-ocean
git clone https://github.com/vulkan-ops/vendor_motorola_river	vendor-river
git clone https://github.com/vulkan-ops/vendor_motorola_channel	vendor-channel
git clone https://github.com/vulkan-ops/vendor_motorola_sdm632-common vendor-common
git clone https://github.com/vulkan-ops/kernel_motorola_sdm632 kernel
}

function b () {
. build/envsetup.sh
#make installclean
#export ARROW_GAPPS=true
lunch lineage_${1}-userdebug
#export TEMPORARY_DISABLE_PATH_RESTRICTIONS=true
#export SKIP_ABI_CHECKS=true
make  bacon -j$(nproc --all) | tee ${1}.log
}

function v () {
source build/envsetup.sh
#export MIN_GAPPS=true
lunch derp_${1}-userdebug
mka derp -j$(nproc --all) | tee ${1}.log
}
