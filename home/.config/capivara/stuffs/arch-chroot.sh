#!/usr/bin/env bash

networkmanager_enable(){
 pacman -Syy networkmanager -noconfirm
 systemctl enable NetworkManager
}

timezone_config(){
  hwclock --systohc
  timedatectl set-ntp true
}

language_system(){
  sed -i -r 's/^#(.*pt_BR.UTF-8 UTF-8.*)$/\1/' /etc/locale.gen
  sed -i '393s/^#//' /etc/locale.gen
  clear && locale-gen
  echo LANG=pt_BR.UTF-8 > /etc/locale.conf
  export LANG=pt_BR.UTF-8
  read -p 'LOCALE configurado, PRESSIONE ENTER PARA CONTINUAR...'
}

keymap_config(){
  echo KEYMAP=br-abnt2 > /etc/vconsole.conf
}

hostname_config(){
  clear && printf "Digite abaixo um hostname para a sua maquina:\n\n"
  read HOST_NAME
  echo "$HOST_NAME" > /etc/hostname
}

btrfs_progs_config(){
  pacman -S btrfs-progs --noconfirm
}

kernels_download(){
  clear && printf "Escolha seu kernel de preferência:\n\n[1] - linux-zen-headers (Kernel focado em desempenho)\n\n"
  read KERNEL_CHOICE
  if [ $KERNEL_CHOICE == '1' ] || [ $KERNEL_CHOICE == '01' ] ; then
    clear && pacman -S linux-zen linux-zen-headers --noconfirm

  else
    read -p 'Opção invalida, POR FAVOR ESCOLHA UM KERNEL, PRESSIONE ENTER PARA CONTINUAR...' && kernels_download
  fi
}
pacman_config(){
  sed -i -r 's/^#(.*UseSyslog.*)$/\1/' /etc/pacman.conf
  sed -i -r 's/^#(.*Color.*)$/\1/' /etc/pacman.conf
  sed -i -r 's/^#(.*CheckSpace.*)$/\1/' /etc/pacman.conf
  sed -i -r 's/^#(.*VerbosePkgLists.*)$/\1/' /etc/pacman.conf
  sed -i -r 's/^#(.*ParallelDownloads.*)$/\1/' /etc/pacman.conf
  sed -i '/ParallelDownloads/s/5/60/g' /etc/pacman.conf
  sed -i '38s/$/ILoveCandy/' /etc/pacman.conf
  sed -i '93,94s/^#//' /etc/pacman.conf
  echo ILoveCandy >> /etc/pacman.conf
}

repo_update(){
  clear && pacman -Syy
}

password_root(){
  clear && printf "Digite e confirme sua senha root abaixo (CUIDADO A SENHA NÃO É EXIBIDA):\n\n"
  passwd
}

user_create(){
  clear && printf "Criando usuario, escolha seu shell de preferência:\n\n[1] - zsh\n[2]"
  read SHELL_CHOICE
  if [ $SHELL_CHOICE == '1' ] || [ $SHELL_CHOICE == '01' ] ; then
    clear && pacman -S zsh --noconfirm
    clear && printf "Digite o nome do seu usuario abaixo (COM LETRAS MINUSCULAS SEM ACENTOS E SEM ESPAÇOS):\n\n"
    read USERNAME
    clear && useradd -m -g users -G wheel -s /bin/zsh "$USERNAME"

    else
    read -p 'Opção invalida, por favor tente novamente PRESSIONE ENTER PARA CONTINUAR...' && user_create
  fi
}

password_user(){
  clear && read -p 'Digite e confirme a sua senha de usuario abaixo (CUIDADO A SENHA NÃO É EXIBIDA) PRESSIONE ENTER PARA CONTINUAR...'
  clear && printf "Digite seu nome de usuario abaixo:\n\n"
  read USERNAME1
  passwd "$USERNAME1"
}

edit_sudoers(){
  sed -i '85s/^#//' /etc/sudoers
  sed -i '85s/^[ \t]*//' /etc/sudoers
  #sed -i -r 's/^#(.*%wheel ALL=(ALL:ALL) ALL.*)$/\1/' /etc/sudoers
}

grub_install(){
  clear && pacman -S grub efibootmgr --noconfirm
  grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArchLinux --recheck
  grub-mkconfig -o /boot/grub/grub.cfg
}

finish_install(){
  clear && read -p 'Instalação finalizada, NÃO ESQUEÇA DE SAIR DO CHROOT(CTRL + D) E REBOOTAR O PC!!! PRESSIONE ENTER PARA CONTINUAR...' && exit 0
}

networkmanager_enable
timezone_config
language_system
keymap_config
hostname_config
btrfs_progs_config
kernels_download
pacman_config
repo_update
password_root
user_create
password_user
edit_sudoers
grub_install
finish_install