#! /bin/bash

#Location where this program will write out your network map to
NETWORK="network.map"
#The nmap command you'd like to use for client discovery
NMAP=`nmap -sn 192.168.1.0/24`
#The email (SMS) address you would like notified when a new host is discovered
EMAIL="ENTER_EMAIL_HERE"
IFS=$'\r\n' GLOBIGNORE='*' command eval  'XYZ=($NMAP)'
XYZ=${XYZ[@]:1}

touch $NETWORK
for each in "${XYZ[@]}"; do
       	IP=`echo $each | awk '{ print $(NF) }' | tr -d '()' | grep -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'`
       	if ! grep -Fxq "$IP" network.map
       	then
       		echo $IP >> $NETWORK
       		echo "A new device has appeared at $IP" | /usr/sbin/ssmtp -s "Alert" 5038932719@msg.fi.google.com
       	fi
done

#https://stackoverflow.com/questions/35355042/how-to-send-email-from-bash-via-a-gmail-account
#http://www.cyberciti.biz/tips/linux-use-gmail-as-a-smarthost.html
#https://www.google.com/settings/security/lesssecureapps
#Inspect

#Isolate

