#!/bin/bash
# MIT Francisco Altimari @1716902569

# Prints Success! and Failed! in green and red respectively
success () {
    printf '\n\033[0;32mSuccess!\033[0m\n\n'
}
failed () {
    printf '\n\033[0;31mFailed!\033[0m\n\n'
}

printf 'Beggining testing\n\n'

echo "---------------------------------------------------------------------"
printf '1) ". script.sh" \n\tshould return 1 and print help:\n\n'

. script.sh

if [ $? -eq 1 ]; then success; else failed; fi

echo "---------------------------------------------------------------------"
printf '2) ". script.sh -q -h" \n\tshould return 0 not print anything:\n'

. script.sh -q -h

if [ $? -eq 0 ]; then success; else failed; fi

printf '   ". script --quiet --help" \n\tshould return 0 not print anything:\n'

. script.sh --quiet --help

if [ $? -eq 0 ]; then success; else failed; fi

echo "---------------------------------------------------------------------"
printf '3) ". script.sh anythibnghere" \n\tshould return 1 and print error:\n\n'

. script.sh anythinggarb

if [ $? -eq 1 ]; then success; else failed; fi

echo "---------------------------------------------------------------------"
printf '4) ". script.sh -hq" \n\tshould return 0 and print help:\n\n'

. script.sh -hq

if [ $? -eq 0 ]; then success; else failed; fi

printf '   ". script.sh -qh" \n\tshould return 0 and not print anything:\n'

. script.sh -qh

if [ $? -eq 0 ]; then success; else failed; fi
