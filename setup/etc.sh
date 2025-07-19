#!/usr/bin/env bash


sudo rm -rf /etc/systemd/system/getty@tty1.service.d/override.conf
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
echo "[Service]
ExecStart=
ExecStart=-/usr/bin/agetty --autologin $USER --noclear %I $TERM" | sudo tee -a /etc/systemd/system/getty@tty1.service.d/override.conf > /dev/null
