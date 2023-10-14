#!/usr/bin/env bash
STATUS=$(wpa_cli  status | grep wpa_state | cut -d"=" -f2)
SSID=$(iwgetid | awk -F '"' '{ print $2 }')
STRENGTH=$(awk 'NR==3 {printf("%.0f",$3*10/7)}' /proc/net/wireless)

toggle() {
    if [[ $STATUS == "COMPLETED" ]]; then
        sudo ifconfig wlp3s0 down
        notify-send --icon=network-wireless-disconnected --urgency=normal "Wi-Fi" "Wi-Fi disabled"
    else
        sudo ifconfig wlp3s0 up
        notify-send --icon=network-wireless-signal-excellent --urgency=normal "Wi-Fi" "Wi-Fi enabled"
    fi
}


class() {
    if [[ $STATUS == "COMPLETED" ]]; then
        echo active
    else
        echo inactive
    fi
}

ssid() {
    if [[ $STATUS == "COMPLETED" ]]; then
        echo $(iwgetid -r)

    else
        echo "n/a"
    fi
}
color() {
    if [[ $STATUS == "COMPLETED" ]]; then
        echo "green"

    else
        echo "red"
    fi
}
icon() {
    if [[ $STATUS == "COMPLETED" ]]; then
        echo "󰤨 "

    else
        echo "󰤮 "
    fi
}


if [[ $1 == "--toggle" ]]; then
    toggle
elif [[ $1 == "--class" ]]; then
    class
elif [[ $1 == "--ssid" ]]; then
   ssid 
elif [[ $1 == "--color" ]]; then
   color 
elif [[ $1 == "--icon" ]]; then
   icon
fi
