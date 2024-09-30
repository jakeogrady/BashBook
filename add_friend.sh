#/bin/bash

if [ ! -d Documents/BashBook/$1 ]; then
	echo "nok: user '$1' does not exist"
	exit 1
fi

if [ ! -d Documents/BashBook/$2 ]; then
	echo "nok: user '$2' does not exist"
	exit 1
fi

if grep -q "^$2" "Documents/BashBook/$1/friends.txt"; then
	echo "nok: user '$2' is already in the list of friends of user '$1'"
else
	echo "$2" >> "Documents/BashBook/$1/friends.txt"
	echo "$1" >> "Documents/BashBook/$2/friends.txt"
	echo "ok: friend added!"
fi
