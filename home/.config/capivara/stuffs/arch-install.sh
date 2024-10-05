#!/usr/bin/env bash

format_disk(){
  clear
  echo -e "[!] - Formatando os discos\n"
  sleep 2
  mkfs.vfat -F32 /dev/sdb1 
  mkfs.ext4 /dev/sdb2 
  mkfs.ext4 /dev/sda1
}

mount_partitions(){
  clear
  echo -e "[!] - Montando as partições\n"
  sleep 2
  mount /dev/sdb2 /mnt 
  mkdir -p /mnt/boot/efi && mount /dev/sdb1 /mnt/boot/efi 
  mkdir /mnt/home && mount /dev/sda3 /mnt/home
}

iwct_enable(){
  iwctl
  device list
  printf "\n\nDigite o nome da sua rede abaixo:\n\n"
  read REDE_NOME
  station wlan0 connect "$REDE_NOME"
  clear && printf "Digite a senha do seu wifi abaixo:\n\n"
  read SENHA
  iwctl --passphrase "$SENHA" station dispositivo connect "$REDE_NOME"
}

pacstrap_arch(){
  clear
  echo -e "[!] - Instalando os pacotes base do Arch Linux\n"
  sleep 2
  pacstrap /mnt base wget neovim linux-firmware base-devel
  pacman -Sy archlinux-keyring --noconfirm
  pacstrap /mnt base wget neovim linux-firmware base-devel
}

fstab_gen(){
  clear
  echo -e "[!] - Gerando o Fstab\n"
  sleep 2
  genfstab /mnt >> /mnt/etc/fstab
}

arch_chroot_enter(){
  clear && echo -e "[!] - ENTRE NO CHROOT DIGITANDO: arch-chroot /mnt"
  sleep 2
}

format_disk
mount_partitions
iwctl_enable
pacstrap_arch
fstab_gen
arch_chroot_enter