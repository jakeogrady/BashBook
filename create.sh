#!/bin/bash

myDir=$1
if [ $# = 0 ]; then
	echo "nok: no identifier provided"
	exit 1
fi
if [ -d Documents/BashBook/${myDir} ]; then
	echo "nok: ID already used!"
else
	echo "ok: User created!"
	mkdir Documents/BashBook/${myDir}
	echo > "Documents/BashBook/${myDir}/wall.txt"
	echo > "Documents/BashBook/${myDir}/friends.txt"
fi

