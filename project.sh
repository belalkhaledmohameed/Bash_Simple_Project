#!/bin/bash

check_status() {

if  [[ $? -eq 0 ]]; then
	echo "operation suceesed"
else
	echo "operation failed"
fi


}

remove_ip(){
local index=$1
unset "ip_addresses[index-1]"
ip_addresses=("${ip_addresses[@]}")
echo "ip address $IP removed"
check_status


}

ping_ip() {
display_ips
echo "Enter IP you want Ping"
read IP
ip_to_ping="${ip_addresses[$((IP-1))]}"
ping -c 4 "$ip_to_ping"
check_status

}

display_ips() {
echo "list of ip addresses"
if [[ ${#ip_addresses[@]} -eq 0 ]]; then
	echo "no ip addresses in the list . "
else 
	for i in "${!ip_addresses[@]}"
	do
		echo "$((i+1)). ${ip_addresses[$i]}"
	done
fi
check_status
}

add_ip() {

local IP=$1
ip_addresses+=("$IP")
check_status
echo "ip addresse $IP added"

}

ip_addresses=()

PS3="enter your option (1-4):"
options=("Add IP address" "Remove IP address" "Display IP address" "Ping IP address" "Exit")
select option in "${options[@]}"
do
	case $REPLY in
	1)
		echo -n "Enter IP address you want add: "
		read IP
		add_ip "$IP"
	;;

	2) 
		display_ips
		echo -n "Enter IP address you want to remove: "
		read IP
		remove_ip "$IP"
		
	;;
	3)
		echo -n  "Enter IP address you want dispaly: "
		display_ips
	;;
	4)
		
		echo -n "Enter IP address you want ping: "
		ping_ip
	;;
	5)
		echo "existing sucess"
		exit 0
	;;
	*)
		echo "Invalid option"
	;;
	esac
done
