#!/usr/bin/env bash

SR="$(xrandr -q | grep ' connected ' | grep -o '[0-9]*x[0-9]*+[0-9]*+[0-9]*')"

for RES in $SR; do
    printf "X: %s\nY: %s\nX-offset: %s\nY-offset: %s\n" \
        "$(awk -F '[x+]' '{print $1}' <<< "$RES")" \
        "$(awk -F '[x+]' '{print $2}' <<< "$RES")" \
        "$(awk -F '[x+]' '{print $3}' <<< "$RES")" \
        "$(awk -F '[x+]' '{print $4}' <<< "$RES")"
done
