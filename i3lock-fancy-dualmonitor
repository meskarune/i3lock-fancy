#!/usr/bin/env bash
# Author: Dolores Portalatin <hello@doloresportalatin.info>
# Dependencies: imagemagick, i3lock-color-git, scrot
set -o errexit -o noclobber -o nounset

HUE=(-level 0%,100%,0.6)
EFFECT=(-filter Gaussian -resize 20% -define filter:sigma=1.5 -resize 500.5%)
# default system sans-serif font
FONT="$(convert -list font | awk "{ a[NR] = \$2 } /family: $(fc-match sans -f "%{family}\n")/ { print a[NR-1]; exit }")"
IMAGE="$(mktemp).png"
DM=$(xdpyinfo | awk '/^  dimensions(.+([0-9]+))/{print $2}')

OPTIONS="Options:
    -h, --help   This help menu.
    -g, --greyscale  Set background to greyscale instead of color.
    -p, --pixelate   Pixelate the background instead of blur, runs faster.
    -f <fontname>, --font <fontname>  Set a custom font. Type 'convert -list font' in a terminal to get a list."

# move pipefail down as for some reason "convert -list font" returns 1
set -o pipefail
trap 'rm -f "$IMAGE"' EXIT
TEMP="$(getopt -o :hpgf: -l help,pixelate,greyscale,font: --name "$0" -- "$@")"
eval set -- "$TEMP"

while true ; do
    case "$1" in
        -h|--help)
            printf "Usage: $(basename $0) [options]\n\n$OPTIONS\n\n" ; exit 1 ;;
        -g|--greyscale) HUE=(-level 0%,100%,0.6 -set colorspace Gray -separate -average) ; shift ;;
        -p|--pixelate) EFFECT=(-scale 10% -scale 1000%) ; shift ;;
        -f|--font)
            case "$2" in
                "") shift 2 ;;
                *) FONT=$2 ; shift 2 ;;
            esac ;;
        --) shift ; break ;;
        *) echo "error" ; exit 1 ;;
    esac
done

# l10n support
TEXT="Type password to unlock"
case "${LANG:-}" in
    de_* ) TEXT="Bitte Passwort eingeben" ;; # Deutsch
    da_* ) TEXT="Indtast adgangskode" ;; # Danish
    en_* ) TEXT="Type password to unlock" ;; # English
    es_* ) TEXT="Ingrese su contraseña" ;; # Española
    fr_* ) TEXT="Entrez votre mot de passe" ;; # Français
    he_* ) TEXT="הליענה לטבל המסיס דלקה" ;; # Hebrew עברית (convert doesn't play bidi well)
    id_* ) TEXT="Masukkan kata sandi Anda" ;; # Bahasa Indonesia
    it_* ) TEXT="Inserisci la password" ;; # Italian
    ja_* ) TEXT="パスワードを入力してください" ;; # Japanese
    lv_* ) TEXT="Ievadi paroli" ;; # Latvian
    pl_* ) TEXT="Podaj hasło" ;; # Polish
    pt_* ) TEXT="Digite a senha para desbloquear" ;; # Português
    ru_* ) TEXT="Введите пароль" ;; # Russian
    * ) TEXT="Type password to unlock" ;; # Default to English
esac

scrot -z "$IMAGE"
ICON="/usr/share/i3lock-fancy-dualmonitor/lock.png"
PARAM=("--insidecolor=0000001c" "--ringcolor=0000003e" \
    "--linecolor=00000000" "--keyhlcolor=ffffff80" "--ringvercolor=ffffff00" \
    "--separatorcolor=22222260" "--insidevercolor=ffffff1c" \
    "--ringwrongcolor=ffffff55" "--insidewrongcolor=ffffff1c" \
    "--verifcolor=ffffff00" "--wrongcolor=ff000000" "--timecolor=ffffff00" \
    "--datecolor=ffffff00" "--layoutcolor=ffffff00")

LOCK=()
while read LINE
do
    if [[ "$LINE" =~ ([0-9]+)x([0-9]+)\+([0-9]+)\+([0-9]+) ]]; then
        W=${BASH_REMATCH[1]}
        H=${BASH_REMATCH[2]}
        Xoff=${BASH_REMATCH[3]}
        Yoff=${BASH_REMATCH[4]}
        MIDXi=$(($W / 2 + $Xoff - 60  / 2))
        MIDYi=$(($H / 2 + $Yoff - 60  / 2))
        MIDXt=$(($W / 2 + $Xoff - 285 / 2))
        MIDYt=$(($H / 2 + $Yoff + 320 / 2))
        MIDXts=$(($MIDXt + 2))
        MIDYts=$(($MIDYt + 2))
        LOCK+=(\( -size $DM xc:none -font $FONT -pointsize 26 -fill black -annotate +$MIDXts+$MIDYts "$TEXT" -blur 0x2 \
               -fill black -annotate +$MIDXts+$MIDYts "$TEXT" -blur 0x1 -fill white -annotate +$MIDXt+$MIDYt "$TEXT" \) \
               -flatten \
               $ICON -geometry +$MIDXi+$MIDYi -composite)
    fi
done <<<"$(xrandr)"

convert "$IMAGE" "${HUE[@]}" "${EFFECT[@]}" "${LOCK[@]}" "$IMAGE"

# try to use a forked version of i3lock with prepared parameters
if ! i3lock -n "${PARAM[@]}" -i "$IMAGE" > /dev/null 2>&1; then
    # We have failed, lets get back to stock one
    i3lock -n -i "$IMAGE"
fi
