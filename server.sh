#!/bin/bash

while true; do
	read user
	read request
	printf '%s\n' "$request"
	printf 'received from the pipe: %s\n' "$user"
	pipe_name="${user}.pipe"
	case "$request" in 
		create)
			output=$(./create.sh "$user")
                        if [[ "$output" =~ ^ok ]]; then
                                answer="SUCCESS: user created!"
                        else
                                answer="ERROR: user already exists"
                        fi
				echo $answer > "${user}.pipe"
			;;
		display)
			read id
			output=$(./display_wall.sh "$id")
			processed=$(echo "$output" | sed '1d;$d')
			echo $processed > "${user}.pipe"
			;;
		post)
			read message
			read id
			output=$(./post_messages.sh "$user" "$id" "$message")
			if [[ "$output" =~ ^nok ]]; then
				answer="ERROR: check IDs given!!"
			else
				answer="Message Posted!"
			fi
			echo $answer > "${user}.pipe"
			;;
		add)
			read id
			output=$(./add_friend.sh "$user" "$id")
			if [[ "$output" =~ ^nok ]]; then
				answer="ERROR: check IDs given!!"
			else
				answer="SUCCESS: friend added!!"
		        fi
			echo $answer > "${user}.pipe"
			;;
		*)
			echo "Only valid request: add, post, create, display"
			exit 1
			;;
	esac
done <testPipe
