#!/bin/sh

# Show wifi 📶 and percent strength or 📡 if none.
# Show 🌐 if connected to ethernet or ❎ if none.
# Show 🔒 if a vpn connection is active

case $BLOCK_BUTTON in
	1) "$TERMINAL" -e nmtui; pkill -RTMIN+4 dwmblocks ;;
	3) notify-send "🌐 Internet module" "\- Click to connect
睊: no wifi connection
直: wifi connection with quality
❎: no ethernet
🌐: ethernet working
🔒: vpn is active
" ;;
	6) "$TERMINAL" -e "$EDITOR" "$0" ;;
esac

case "$(cat /sys/class/net/w*/operstate 2>/dev/null)" in
	down) wifiicon="睊 " ;;
	up) wifiicon="$(awk '/^\s*w/ { print "直", int($3 * 100 / 70) "% " }' /proc/net/wireless)" ;;
esac
# sed -i  "1s/.*/$wifiicon/" ~/.local/share/wifiStatus
# getstatus=$(sed -n '1p' < ~/.local/share/wifiStatus)

printf "%s%s%s\n" "$wifiicon"

