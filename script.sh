#!/bin/bash
# MIT @ Francisco Altimari on @1713980634

# TODO: add error if not in a obsidian vault folder

# Path of the global system obsidian dictionary
global_path=~/.config/obsidian/Custom\ Dictionary.txt

# Path of your local vault dictionary
local_path=./.obsidian/dictionary.txt

if [[ $(uname) == 'Darwin' ]]; then
    global_path=~/Library/Application\ Support/obsidian/Custom\ Dictionary.txt
fi

echo 'Checking for dictionary file on: ' 
echo $global_path
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
    # TODO: delete these debug lines
	# cat "$1"
	# printf '\n'
	bat "$1"

    old_words=$(tail "$1")

    # Only trim last line if it is the checksum value
    if [[ $(tail -1 "$1") == 'checksum_v'* ]]; then
        old_words=$(sed '$d' "$1")
    fi

    echo $old_words


    # possible states:
    # global (ahead)  |  global (behind)
    # local (behind)  |  local   (ahead)


	# last_line=$(tail )
}

check_file "$global_path"
