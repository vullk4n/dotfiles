export ZSH="/mnt/hd3/vitor/.oh-my-zsh"
export EDITOR="nano"
#export OUT_DIR=/mnt/hd3/vitor/derp-out

ZSH_THEME="robbyrussell"

plugins=(zsh-autosuggestions
zsh-syntax-highlighting)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
 mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

play () {
#git clone https://github.com/LineageOS/android_device_motorola_channel  device/motorola/channel
git clone https://github.com/LineageOS/android_device_motorola_nash -b lineage-19.1 device/motorola/nash
#git clone https://github.com/LineageOS/android_device_motorola_sdm632-common  device/motorola/sdm632-common
#git clone https://gitlab.com/the-muppets/proprietary_vendor_motorola_channel   vendor/motorola/channel
#git clone https://gitlab.com/the-muppets/proprietary_vendor_motorola_sdm632-common  vendor/motorola/sdm632-common
git clone https://gitlab.com/the-muppets/proprietary_vendor_motorola_nash vendor/motorola/nash
#git clone https://github.com/LineageOS/android_kernel_motorola_sdm632   kernel/motorola/sdm632
git clone https://github.com/LineageOS/android_kernel_motorola_msm8998  -b lineage-19.1 kernel/motorola/msm8998
}


hw () {
git clone https://github.com/LineageOS/android_hardware_motorola   	hardware/motorola
git clone https://github.com/LineageOS/android_system_qcom 		system/qcom
git clone https://github.com/LineageOS/android_external_bson		external/bson
#git clone https://github.com/LineageOS/android_hardware_qcom_media -b lineage-19.1-caf-msm8996		hardware/qcom-caf/msm8996/media
#git clone https://github.com/LineageOS/android_hardware_qcom_audio -b lineage-19.1-caf-msm8996		hardware/qcom-caf/msm8996/audio
#git clone https://github.com/LineageOS/android_hardware_qcom_display -b lineage-19.1-caf-msm8996	hardware/qcom-caf/msm8996/display
}

dt () {
git clone https://github.com/vulkan-ops/device_motorola_ocean  device/motorola/ocean
git clone https://github.com/vulkan-ops/device_motorola_river  device/motorola/river
git clone https://github.com/vulkan-ops/device_motorola_sdm632-common  device/motorola/sdm632-common
git clone https://github.com/vulkan-ops/vendor_motorola_ocean   vendor/motorola/ocean
git clone https://github.com/vulkan-ops/vendor_motorola_river   vendor/motorola/river
git clone https://github.com/vulkan-ops/vendor_motorola_sdm632-common  vendor/motorola/sdm632-common
git clone https://github.com/vulkan-ops/kernel_motorola_sdm632   kernel/motorola/sdm632
}

f () {
  git fetch https://github.com/${1} ${2}
}

p () {
  git cherry-pick ${1}
}

cc () {
  git add . && git cherry-pick --continue
}

a () {
  git cherry-pick --abort
}

amend () {
    git add . && git commit --amend
  }

#alias b=".build/envsetup.sh && lunch derp_${1}-userdebug && mka derp | tee ${1}.log

sshgen () {
  ssh-keygen -t ed25519 -C "vulkanops@gmail.com"
  eval "$(ssh-agent -s)" && ssh-add -l
  cat $HOME/.ssh/id_ed25519.pub | wl-copy
}


alias hals="cp -af hardware/qcom-caf/common/os_pickup.bp hardware/qcom-caf/msm8996/Android.bp && cp -af hardware/qcom-caf/common/os_pickup.mk hardware/qcom-caf/msm8996/Android.mk"
