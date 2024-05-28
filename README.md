# Obsidian Sync Dictionary with Bash

Small script to sync the dictionary file with a bash script.

## Usage
```bash
. script.sh
```

## How it works

You can now create a file inside your vaults `.obsidian` folder that will keep keep up to date with the `Custom Dictionary.txt` file on your computer.

By default this file is expected to be named `dictionary.txt`.

The script requires you to pass which file is going to be synced with either the `-g` flag, meaning the global, or the `-v` flag, meaning the vault file will be synced.

## Planend features

- `-i` Interactive mode: script will prompt for which file to use as the source of truth, showing the diff, with the following prompt -> \[`Y`es, `N`o, `S`wap]
- `-s` Silent flag: don't output anything to terminal
- `-h, --help` Help flag: show summary explaining flags
- Installation with Homebrew?
- Create testing script to help quality and knowing how this is supposed to work
