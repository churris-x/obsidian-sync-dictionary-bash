#!/bin/bash

DEFAULT_PATH=~/Library/Application\ Support/obsidian/Custom\ Dictionary.txt

echo 'Checking for dictionary file on: ' 
echo $DEFAULT_PATH
printf '\n'

edit_file () {
	echo 'path is' $1 

	# cat "$1"
	# printf '\n'
	bat "$1"	

	# last_line=$(tail )
}


if [[ -w "$DEFAULT_PATH" ]]; then
	echo 'Can edit'
	edit_file "$DEFAULT_PATH"
else
	echo 'File cannot be edited'
	read -ep 'Custom file path: ' custom_path
	edit_file "$custom_path"
fi
