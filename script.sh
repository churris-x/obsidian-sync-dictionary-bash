#!/bin/bash
# MIT Francisco Altimari @1713980634

# TODO: Make quiet flag suppress printf / echo
# TODO: add error if not in a obsidian vault folder

sync_dictionary () {
    print_help () {
        local HIGH='\033[0;1m'
        local RESET='\033[0m'

        printf "A command line utility to keep your obsidian dictionary synced. \n\n"
        printf "${HIGH}Usage:${RESET} obsidian-sync [ -g | -v ] [OPTIONS]... \n"
        printf "\n  [ ${HIGH}-g, --global${RESET} | ${HIGH}-v, --vault${RESET} ] REQUIRED\n"
        printf "\tMutually exclusive option, selects which file to sync.\n"
        printf "\t-g for the global file, -v for the local vault file.\n"
        printf "\n  ${HIGH}-i, --interactive${RESET}\n"
        printf "\tActivates interactive mode. Shows the current diff between the two files\n"
        printf "\tand allows user to choose in which direction to sync.\n"
        printf "\n  ${HIGH}-q, --quiet${RESET}\n"
        printf "\tSuppress terminal output\n"
        printf "\n  ${HIGH}-h, --help${RESET}\n"
        printf "\tPrint help\n\n"
    }

    print_error () {
        local RESET='\033[0m'

        printf "\033[0;31mError:${RESET} ${1}\n"
    }

    if [ $# -eq 0 ]; then print_help; return 1; fi

    local direction=1
    local interactive=false
    local quiet=false

    # While the number of args is greater than 0:
    while [ $# -gt 0 ]; do
        case $1 in
            -h | --help ) print_help; return 0 ;;
            -v | --vault ) direction=-1;;
            -g | --global ) direction=1;;
            -i | --interactive ) interactive=true;;
            -q | --quiet ) quiet=true;;
            -??*) set -- "$@" ${1:0:2} -${1:2} ;; # handler for joined flags
            *) printf "Unknown argument: $1\n\nTry -h for help\n"; return 1 ;;
        esac
        shift # Move to next argument
    done

    echo $direction
    echo $quiet

    # TODO: remove this
    return 0


    # Path of the global system obsidian dictionary
    local global_path=~/.config/obsidian/Custom\ Dictionary.txt

    # Path of your local vault dictionary
    # local_path=./.obsidian/dictionary.txt
    local local_path=./dictionary.txt

    if [[ $(uname) == 'Darwin' ]]; then
        local global_path=~/Library/Application\ Support/obsidian/Custom\ Dictionary.txt
    fi

    create_local () {
        echo "$1" > $local_path
        echo date = $(date +%s) >> $local_path # why do i do this 'date =' ?
    }

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

        if ! [[ -w $local_path ]]; then
            printf "\n"
            echo 'Local dictionary not found (tried: "'$local_path'")'
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

    check_file "$global_path"
}

sync_dictionary "$@"
