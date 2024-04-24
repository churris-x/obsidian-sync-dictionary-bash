#!/bin/bash


# TODO: use `uname` to get the OS system, eg Darwin, *inux, etc
DEFAULT_PATH=~/Library/Application\ Support/obsidian/Custom\ Dictionary.txt

echo 'Checking for dictionary file on: ' 
echo $DEFAULT_PATH
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

check_file "$DEFAULT_PATH"
