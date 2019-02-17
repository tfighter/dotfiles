#!/bin/bash

echo -n "Welcome to chroot $HOSTNAME, $USER. Running adb in " 
for i in {3..1}; do echo -n "$i..."; done
echo; adb start-server 

echo -e "What's the last 3 digits of your android phone's ip address?"
read -p "192.168.1." deviceip

adb connect 192.168.1.$deviceip
