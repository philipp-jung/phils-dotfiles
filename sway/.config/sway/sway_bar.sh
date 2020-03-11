# Change this according to your device
################
# Variables
################

# Keyboard input name
#keyboard_input_name="1:1:AT_Translated_Set_2_keyboard"

# Date and time
date_and_week=$(date "+%Y/%m/%d")
current_time=$(date "+%H:%M")

#############
# Commands
#############

# Battery or charger
battery_charge=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "percentage" | awk '{print $2}')
battery_status=$(upower --show-info $(upower --enumerate | grep 'BAT') | egrep "state" | awk '{print $2}')

# Audio and multimedia
audio_volume_left=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }')
audio_volume_right=$(amixer sget Master | grep 'Left:' | awk -F'[][]' '{ print $2 }')
audio_is_muted=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $4 }')

# Network
network=$(ip route get 1.1.1.1 | grep -Po '(?<=dev\s)\w+' | cut -f1 -d ' ')
# interface_easyname grabs the "old" interface name before systemd renamed it
interface_easyname=$(nmcli device wifi | grep \* | awk '{print $2}')
signal_strength=$(nmcli device wifi | grep \* | awk '{print $8}')
ping=$(ping -c 1 www.google.es | tail -1| awk '{print $4}' | cut -d '/' -f 2 | cut -d '.' -f 1)

# Others
language=$(swaymsg -r -t get_inputs | awk '/1:1:AT_Translated_Set_2_keyboard/;/xkb_active_layout_name/' | grep -A1 '\b1:1:AT_Translated_Set_2_keyboard\b' | grep "xkb_active_layout_name" | awk -F '"' '{print $4}')
loadavg_5min=$(awk -F ' ' '{print $2}' /proc/loadavg)

# Removed weather because we are requesting it too many times to have a proper
# refresh on the bar
#weather=$(curl -Ss 'https://wttr.in/Pontevedra?0&T&Q&format=1')

if [ $battery_status = "discharging" ];
then
    battery_pluggedin='⚠'
else
    battery_pluggedin='⚡'
fi

if ! [ $network ]
then
   network_active="⛔"
else
   network_active="⇆"
fi

if [ $audio_is_muted = "off" ]
then
    audio_active='🔇'
else
    audio_active='🔊'
fi

echo "⌨ $language | $network_active $interface_easyname $signal_strength ($ping ms) | 🏋 $loadavg_5min | $audio_active L$audio_volume_left R$audio_volume_right | $battery_pluggedin $battery_charge | $date_and_week $current_time"
