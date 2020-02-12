#!/bin/bash

i3status --config /home/phil/.config/i3status/config | while :
do
    read line
    case "$(xset -q|grep LED| awk '{ print $10 }')" in
      "00000000") LG="DE" ;;
      "00000002") LG="DE" ;;
      "00001002") LG="EN" ;;
      "00001000") LG="EN" ;;
      *) LG="unknown" ;;
    esac
    if [ $LG == "EN" ]
    then
        dat="[{ \"full_text\": \"🇺🇸\" },"
    else
        dat="[{ \"full_text\": \"🇩🇪\" },"
    fi
    echo "${line/[/$dat}" || exit 1
done
