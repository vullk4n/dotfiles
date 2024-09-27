#!/usr/bin/env bash

iconpath="/usr/share/icons/Papirus-Dark/32x32/devices"
icon="${iconpath}/bluetooth.svg"

bluetoothctl power on
bluetoothctl agent on
bluetoothctl default-agent

bt() {
  bluetoothctl trust ${1}
  bluetoothctl pair ${1}
  bluetoothctl connect ${1}
}

scan="Scan devices"
bt1="F0n3"
bt2="Pok3b0la"

devices="$scan\n$bt1\n$bt2"

chosen="$(echo -e "$devices" | wofi --lines 5 --sort-order=DEFAULT --dmenu -p "  Bluetooth")"
case $chosen in
    $scan)
      bluetoothctl scan on;;
    $bt1)
      bt "1C:52:16:3F:B7:5C";; # F0n3
    $bt2)
      bt "41:42:D2:B3:29:71";; # Pok3b0la

esac
exit 0;
