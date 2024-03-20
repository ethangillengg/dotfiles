#!/usr/bin/env bash
wallpaperdir="$HOME/Pictures/wallpapers/gruvbox-nature"

files=("$wallpaperdir"/*)
randompic=$(printf "%s\n" "${files[RANDOM % ${#files[@]}]}")
echo "$randompic"
swww img --transition-type wipe --transition-duration 2 --transition-fps 60 "$randompic"
