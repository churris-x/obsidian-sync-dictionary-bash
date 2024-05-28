#!/bin/bash
# MIT Francisco Altimari @1716902569

success () {
    printf '\n\033[0;32mSuccess!\033[0m\n\n'
}

failed () {
    printf '\n\033[0;31mFailed!\033[0m\n\n'
}

echo 'Beggining testing'
echo ''

# -----------------------------------------------------------------------------

echo '1) . script.sh should return 1 and print help:'
echo ''

. script.sh

if [ $? -eq 1 ]; then success; else failed; fi

# -----------------------------------------------------------------------------

echo '2) . script.sh -h | --help should return 0 and print help:'
echo ''

. script.sh -h

if [ $? -eq 0 ]; then success; else failed; fi

. script.sh --help

if [ $? -eq 0 ]; then success; else failed; fi

# -----------------------------------------------------------------------------


echo '3) . script.sh anythibnghere should return 1 and print help:'
echo ''

. script.sh anythinggarb

if [ $? -eq 1 ]; then success; else failed; fi

# -----------------------------------------------------------------------------
