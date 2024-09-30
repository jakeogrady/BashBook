#!/bin/bash

id=$1

if [ $# -eq 0 ]; then
	echo "nok: no user id provided"
	exit 1
elif [ ! -d Documents/BashBook/${id} ]; then
	echo "nok: user '$id' does not exist"
	exit 1
else
	start="start_of_file"
	fileEnd="end_of_file"
	fileContent=$(cat Documents/BashBook/${id}/wall.txt)
	output="$start\n$fileContent\n$fileEnd"
	echo -e $output
	exit 0
fi
