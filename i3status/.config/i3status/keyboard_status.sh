#!/bin/bash

i3status --config /home/phil/.config/i3status/config | while :
do
    read line
    case "$(xset -q|grep LED| awk '{ print $10 }')" in
      "00000000") LG="DE" ;;
      "00001000") LG="EN" ;;
      *) LG="unknown" ;;
    esac
    if [ $LG == "EN" ]
    then
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#009E00\" },"
    else
        dat="[{ \"full_text\": \"LANG: $LG\", \"color\":\"#C60101\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
