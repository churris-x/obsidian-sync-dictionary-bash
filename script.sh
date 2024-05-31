#!/bin/bash
# MIT Francisco Altimari @1713980634

# TODO: add error if not in a obsidian vault folder
# NOTE: does it make sense to add / substitue the
#       quiet flag with a -f force one?

sync_dictionary () {
    local quiet=false

    # Colour variables
    local RST="\033[0m"
    local WHT="\033[1;1m"
    local RED="\033[1;31m"
    # local GRN="\033[1;32m"
    # local YLW="\033[0;33m"
    # local ORG="\033[1;33m"
    # local BLU="\033[1;34m"

    print_help () {
        if [ $quiet = false ]; then
            printf "A command line utility to keep your obsidian dictionary synced. \n\n"
            printf "${WHT}Usage:${RST} obsidian-sync [ -g | -v ] [OPTIONS]... \n"
            printf "\n  [ ${WHT}-g, --global${RST} | ${WHT}-v, --vault${RST} ] REQUIRED\n"
            printf "\tMutually exclusive option, selects which file to sync.\n"
            printf "\t-g for the global file, -v for the local vault file.\n"
            printf "\n    ${WHT}-i, --interactive${RST}\n"
            printf "\tActivates interactive mode. Shows the current diff between the\n"
            printf "\ttwo files and allows user to choose in which direction to sync.\n"
            printf "\n    ${WHT}-q, --quiet${RST}\n"
            printf "\tSuppress terminal output\n"
            printf "\n    ${WHT}-h, --help${RST}\n"
            printf "\tPrint help\n\n"
        fi
    }
    print_error () {
        printf "${RED}[Error]${RST} ${1}\n"
    }

    # Show help if there are no args
    if [ $# -eq 0 ]; then print_help; return 1; fi

    local direction=1
    local interactive=false

    # While the number of args is greater than 0:
    while [ $# -gt 0 ]; do
        case $1 in
            -h | --help ) print_help; return 0 ;;
            -v | --vault ) direction=-1;;
            -g | --global ) direction=1;;
            -i | --interactive ) interactive=true;;
            -q | --quiet ) quiet=true;;
            -??*) set -- "$@" ${1:0:2} -${1:2} ;; # handler for joined flags
            *) print_error "Unknown argument: $1\n\nTry -h for help"; return 1 ;;
        esac
        shift # Move to next argument
    done

    echo $direction
    echo $quiet

    # TODO: remove this
    return 0

    # Path of your local vault dictionary
    # local_path=./.obsidian/dictionary.txt
    local local_path=./dictionary.txt

    # Path of the global system obsidian dictionary
    local global_path=~/.config/obsidian/Custom\ Dictionary.txt

    if [[ $(uname) == 'Darwin' ]]; then
        local global_path=~/Library/Application\ Support/obsidian/Custom\ Dictionary.txt
    fi

    create_local () {
        # If $1 does not include .obsidian/ warn and ask to proced anyway
        # this should be disabled by f
        echo "$1" > $local_path
        echo date = $(date +%s) >> $local_path # why do i do this 'date =' ?
    }

    check_file () {
        # Check if file is editable, since we will append to it
        if [[ -w "$1" ]]; then
            edit_file "$1"
        else
            print_error 'File cannot be edited'
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

        # If there isn't a local file, create it by copying the global file
        if ! [[ -w $local_path ]]; then
            printf "\n"
            print_error 'Local dictionary not found (tried: "'$local_path'")'
            read -p 'Create new one? [y/n]: ' yn

            case $yn in
                [Yy]*) create_local "$old_words";;
                *) return 0;;
            esac
        fi

        # TODO: figure out how to make script stop?
        echo 'more stuff?'

        # possible states:
        # global (ahead)  |  global (behind)
        # local (behind)  |  local   (ahead)


    	# last_line=$(tail )
    }

    echo 'Checking for dictionary file on: '
    echo $global_path
    printf '\n'

    # TODO: change this to be
    # check file local
    # check file global

    # edit file global
    check_file "$global_path"
}

sync_dictionary "$@"
