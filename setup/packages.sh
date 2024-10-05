#!/usr/bin/env bash

readonly PACKAGES=(
  # audio
  alsa alsa-firmware alsa-utils alsa-plugins
  pulseaudio pulseaudio-bluetooth pavucontrol
  sox

  # archlinux
  archlinux-keyring

  # apps
  alacritty bat tailscale filezilla git gpicview htop
  lxappearance dhcpcd leafpad vscode mako
  nano nano-syntax-highlighting
  reflector brightnessctl
  stow sway swaybg
  telegram-desktop tree thunar thunar-archive-plugin thunar-media-tags-plugin thunar-volman transmission-gtk
  waybar wayland wofi qbittorent
  xorg-server-xwayland
  zsh-autosuggestions

  # bluetooth
  bluez bluez-libs bluez-tools bluez-utils

  # tools for android/mobile
  android-tools
  gvfs gvfs-afc gvfs-gphoto2 gvfs-mtp gvfs-smb
  gvfs-nfs  gvfs-goa  gvfs-google ntfs-3g

  # screenshots/cast
  grim
  imagemagick
  slurp
  wl-clipboard

  # drivers and dependencies
  mesa mpd mpv
  openssh
  python-setuptools
  sbc
  unrar unzip zip
  wget
  #xf86-video-amdgpu
  #xf86-video-ati
  cups hplip system-config-printer

  # fonts
  noto-fonts-emoji
  terminus-font ttf-liberation
)

readonly AUR=(
  # themes
  ant-dracula-gtk-theme
  capitaine-cursors
  papirus-icon-theme-git

  # apps
  google-chrome
  oh-my-zsh-git
  swaylock-effects-git
  translate-shell-git
  zsh-syntax-highlighting
  spotify ntp

 # dependencies
  python-ruamel-yaml
  selinux-python
  ttf-font-awesome ttf-dejavu
  wf-recorder-git
)
