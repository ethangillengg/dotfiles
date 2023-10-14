#!/usr/bin/env bash

STATUS=$(makoctl mode)

toggle() {
    if [ $STATUS == "do-not-disturb" ]; then
        makoctl mode -r do-not-disturb
    else
        makoctl mode -s do-not-disturb
    fi
}


class() {
    if [ $STATUS == "do-not-disturb" ]; then
      echo active
    else
      echo inactive
    fi
}

if [[ $1 == "--toggle" ]]; then
    toggle
elif [[ $1 == "--class" ]]; then
    class
fi
