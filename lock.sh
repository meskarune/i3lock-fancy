#!/usr/bin/env bash
# Original Author: Dolores Portalatin <hello@doloresportalatin.info>
# This version is amde by: Adam Hallgat
# Dependencies: imagemagick, i3lock-color-git, scrot
set -o errexit -o noclobber -o nounset

HUE=(-level 0%,100%,0.6)
EFFECT=(-filter Gaussian -resize 20% -define filter:sigma=1.5 -resize 500.5%)
# default system sans-serif font
FONT="$(convert -list font | awk "{ a[NR] = \$2 } /family: $(fc-match sans -f "%{family}\n")/ { print a[NR-1]; exit }")"
IMAGE="$(mktemp).png"

# move pipefail down as for some reason "convert -list font" returns 1
set -o pipefail
trap 'rm -f "$IMAGE"' EXIT
TEMP="$(getopt -o :hpglf: -l help,pixelate,greyscale,font: --name "$0" -- "$@")"
eval set -- "$TEMP"

# get path where the script is located to find the lock icon
SCRIPTPATH=$(realpath "$0")
SCRIPTPATH=${SCRIPTPATH%/*}

# no text
TEXT=""

VALUE="60" #brightness value to compare to
scrot -z "$IMAGE"
COLOR=$(convert "$IMAGE" -gravity center -crop 100x100+0+0 +repage -colorspace hsb \
    -resize 1x1 txt:- | awk -F '[%$]' 'NR==2{gsub(",",""); printf "%.0f\n", $(NF-1)}');

    BW="white"
    ICON="$SCRIPTPATH/lock.png"
    PARAM=(--textcolor=ffffff00 --insidecolor=ffffff1c --ringcolor=ffffff3e \
        --linecolor=ffffff00 --keyhlcolor=00000080 --ringvercolor=00000000 \
        --separatorcolor=22222260 --insidevercolor=0000001c \
        --ringwrongcolor=00000055 --insidewrongcolor=0000001c)


convert "$IMAGE" "${HUE[@]}" "${EFFECT[@]}" -font "$FONT" -pointsize 26 -fill "$BW" -gravity center \
    -annotate +0+160 "$TEXT" "$ICON" -gravity center -composite "$IMAGE"

# try to use a forked version of i3lock with prepared parameters
if ! i3lock -n "${PARAM[@]}" -i "$IMAGE" > /dev/null 2>&1; then
    # We have failed, lets get back to stock one
    i3lock -n -i "$IMAGE"
fi
