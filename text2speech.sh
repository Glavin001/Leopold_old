#!/bin/bash

INPUT=$*
STRINGNUM=0
ary=($INPUT)
for key in "${!ary[@]}"
do
SHORTTMP[$STRINGNUM]="${SHORTTMP[$STRINGNUM]} ${ary[$key]}"
LENGTH=$(echo ${#SHORTTMP[$STRINGNUM]})

if [[ "$LENGTH" -lt "100" ]]; then

SHORT[$STRINGNUM]=${SHORTTMP[$STRINGNUM]}
else
STRINGNUM=$(($STRINGNUM+1))
SHORTTMP[$STRINGNUM]="${ary[$key]}"
SHORT[$STRINGNUM]="${ary[$key]}"
fi
done
for key in "${!SHORT[@]}"
do
google_say() { 
    local IFS=+;
    sayUrl="http://translate.google.com/translate_tts?tl=en&q=${SHORT[$key]}"; 
    echo $sayUrl;
    wget -q -U "Mozilla/5.0 (Windows NT 6.2; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/27.0.1453.93 Safari/537.36" -O ./temp/say.mp3 $sayUrl
    play ./temp/say.mp3
    # mplayer -ao alsa -really-quiet -noconsolecontrols $sayUrl;
}
google_say $*
done

