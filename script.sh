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
    # Check if file is editable, since we will append to it
    if [[ -w "$1" ]]; then
        edit_file "$1"
    else
        echo 'File cannot be edited'
        read -ep 'Custom file path: ' custom_path
        check_file "$custom_path"
    fi
}

edit_file () {

	# cat "$1"
	# printf '\n'
	bat "$1"

    old_words=$(sed '$d' "$1")

    echo $old_words

	# last_line=$(tail )
}

check_file "$default_path"
