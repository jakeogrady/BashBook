#!/bin/bash

total=$#
sender=$1
receiver=$2
shift 2
message="$sender : $@\n"

if [ $total -eq 0 ] || [ $total -eq 1 ]; then
	echo "nok: no senderID or receiverID given"
	exit 1
fi
if [ ! -d Documents/BashBook/${sender} ]; then
	echo "nok: user '$sender' does not exist"
	exit 1
elif [ ! -d Documents/BashBook/${receiver} ]; then
	echo "nok: user '$receiver' does not exist"
	exit 1
elif ! grep -q "^$receiver" "Documents/BashBook/${sender}/friends.txt"; then
	echo "You are not friends with this user!"
	exit 1

else 
	echo "Message posted!"
	echo "$message" >> Documents/BashBook/${receiver}/wall.txt
fi
