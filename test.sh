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

# -----------------------------------------------------------------------------

printf '1) ". script.sh" \n  should return 1 and print help:\n\n'

. script.sh

if [ $? -eq 1 ]; then success; else failed; fi

# -----------------------------------------------------------------------------

printf '2) ". script.sh -h | --help" \n  should return 0 and print help:\n\n'

. script.sh -h

if [ $? -eq 0 ]; then success; else failed; fi

. script.sh --help

if [ $? -eq 0 ]; then success; else failed; fi

# -----------------------------------------------------------------------------

printf '3) ". script.sh anythibnghere" \n  should return 1 and print help:\n\n'

. script.sh anythinggarb

if [ $? -eq 1 ]; then success; else failed; fi

# -----------------------------------------------------------------------------
