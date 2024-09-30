#!/bin/bash

interrupt_handler() {
        echo -e  "\n\nControl+C detected. Exiting..."
        echo "Deleting user pipe..."
        rm "$pipe_name"
        rm mylock
        exit 0
}

close_handler() {
        echo -e "\n\nQuiting program.."
        rm "$pipe_name"
        rm mylock
        exit 0
}


trap interrupt_handler SIGINT
trap close_handler SIGHUP


user=$1
pipe_name="${user}.pipe"
mkfifo "$pipe_name"

while true; do
	./acquire.sh mylock
	printf '%s\n' "$user"
	read -p 'Enter a request here: ' request
	printf '%s\n' "$request"
	case "$request" in
		post)
			read -p 'Enter a message here: ' message
			printf '%s\n' "$message"
			read -p 'Enter a user to message: ' id
			printf '%s\n' "$id"
			read reply < $pipe_name
			echo $reply > /dev/tty
			;;
		add)
			read -p 'Enter a user to add: ' id
			printf '%s\n' "$id"
			read reply < $pipe_name
			echo $reply > /dev/tty
			;;
		display) 
			read -p 'Enter a user to display their wall: ' id
			printf '%s\n' "$id"
			read reply < $pipe_name
			echo $reply > /dev/tty
			;;
		create)
			read reply < $pipe_name
			echo $reply > /dev/tty
			;;
		*)
			exit 1
			;;
	esac
	./release.sh mylock
	sleep 1
done >testPipe
