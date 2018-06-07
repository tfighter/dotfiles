#!/bin/bash

echo -e "Welcome to chroot $HOSTNAME, $USER. Running adb..."
adb start-server 

echo -e "adb server started. What's the last 3 digits of your android phone's ip address?"
read -p "192.168.1." deviceip
#read -p "port number (ex: 5555): " deviceport

#echo -e "\ndebug info: \$deviceIP: $deviceip, \$deviceport: $deviceport\n"


adb connect 192.168.1.$deviceip

#echo -e "\ndebug info: \$deviceIP: $deviceip, \$deviceport: $deviceport\n"