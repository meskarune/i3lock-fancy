#!/usr/bin/env bash

SR="$(xrandr -q | grep ' connected ' | grep -o '[0-9]*x[0-9]*+[0-9]*+[0-9]*')"

for RES in $SR; do
    printf "X: %s\nY: %s\nX-offset: %s\nY-offset: %s\n" \
        "$(awk -F '[x+]' '{print $1}' <<< "$RES")" \
        "$(awk -F '[x+]' '{print $2}' <<< "$RES")" \
        "$(awk -F '[x+]' '{print $3}' <<< "$RES")" \
        "$(awk -F '[x+]' '{print $4}' <<< "$RES")"
done

while read LINE
do
  if [[$LINE =~ ([0-9]+)x([0-9]+)\\+([0-9]+)\\+([0-9]+) ]]; then
    W=${BASH_REMATCH[1]}
    H=${BASH_REMATCH[2]}
    Xoff=${BASH_REMATCH[3]}
    Yoff=${BASH_REMATCH[4]}
    MIDX=$(("$W" / 2 + "$Xoff" - 60  / 2))
    MIDY=$(("$H" / 2 + "$Yoff" - 60  / 2))
    printf "X: $W Y: $H X-offset: $Xoff Y-offset $Yoff middlex: $MIDX middley: $MIDY"
  fi
done <<<"$(xrandr -q | grep " connected ")"
