#!/usr/bin/env bash
file=$1
w=$2
h=$3
x=$4
y=$5
hfloat=$(expr $h*0.9 | bc)
hint=${hfloat/.*}
CACHE="$HOME/.cache/tmpimg"

if [[ "$( file -Lb --mime-type "$file")" =~ ^image ]]; then
  kitty +icat --silent --transfer-mode file --place "${w}x${h}@${x}x2" "$file"
  exit 1
fi

ctpv "$file"
