export ZSH="/home/vulkan/.oh-my-zsh"
export EDITOR="nano"

ZSH_THEME="robbyrussell"

plugins=(zsh-autosuggestions
zsh-syntax-highlighting)

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
 mkdir $ZSH_CACHE_DIR
fi

source $ZSH/oh-my-zsh.sh

hw () {
git clone ssh://git@github.com/vulkan-ops/hardware_motorola  hardware/motorola
git clone ssh://git@github.com/LineageOS/android_system_qcom 	-b lineage-21	system/qcom
git clone ssh://git@github.com/LineageOS/android_external_bson	-b lineage-21	external/bson
}

dp () {
git clone https://github.com/DerpFest-Devices/device_motorola_pstar  device/motorola/pstar
git clone https://github.com/DerpFest-Devices/device_motorola_sm8250-common  device/motorola/sm8250-common
git clone https://github.com/DerpFest-Devices/vendor_motorola_pstar   vendor/motorola/pstar
git clone https://github.com/DerpFest-Devices/vendor_motorola_sm8250-common  vendor/motorola/sm8250-common
git clone https://github.com/DerpFest-Devices/kernel_motorola_sm8250  kernel/motorola/sm8250
}

cr () {
git clone ssh://git@github.com/crdroidandroid/android_device_motorola_pstar   device/motorola/pstar
git clone ssh://git@github.com/crdroidandroid/android_device_motorola_sm8250-common  device/motorola/sm8250-common
git clone ssh://git@github.com/crdroidandroid/proprietary_vendor_motorola_pstar   vendor/motorola/pstar
git clone ssh://git@github.com/crdroidandroid/proprietary_vendor_motorola_sm8250-common   vendor/motorola/sm8250-common
git clone ssh://git@github.com/crdroidandroid/android_kernel_motorola_sm8250   kernel/motorola/sm8250
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

sshgen () {
  ssh-keygen -t ed25519 -C "vulkanops@gmail.com"
  eval "$(ssh-agent -s)" && ssh-add -l
  cat $HOME/.ssh/id_ed25519.pub
}
