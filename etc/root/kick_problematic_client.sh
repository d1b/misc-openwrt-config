#!/bin/sh /etc/rc.common
MAC="<enter mac address here>"
IP="<enter ip here>"
WIFI_IF="<enter wifi interface here>"

while true; do
	ping=$(ping $IP-c 4 -W 1 | grep packets | awk '{print $7 }' | sed s/%//g)

	if [ $ping -eq 100 ]
	then
		/usr/bin/logger -f KICK_WIFI_CLIENT "deauthing problematic client from wifi"

		ubus call hostapd.$WIFI_IF del_client "{'addr':'$MAC', 'reason':5, 'deauth':false, 'ban_time':0}"
	fi
	sleep 40
done
