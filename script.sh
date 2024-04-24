#!/bin/bash
# MIT @ Francisco Altimari on @1713980634

default_path=~/.config/obsidian/Custom\ Dictionary.txt

if [[ $(uname) == 'Darwin' ]]; then
    default_path=~/Library/Application\ Support/obsidian/Custom\ Dictionary.txt
fi

echo 'Checking for dictionary file on: ' 
echo $default_path
printf '\n'

check_file () {
    if [[ -w "$1" ]]; then
        echo 'Can edit'
        edit_file "$1"
    else
        echo 'File cannot be edited'
        read -ep 'Custom file path: ' custom_path
        check_file "$custom_path"
    fi
}

edit_file () {
	echo 'path is' $1 

	# cat "$1"
	# printf '\n'
	bat "$1"	

	# last_line=$(tail )
}

check_file "$default_path"
