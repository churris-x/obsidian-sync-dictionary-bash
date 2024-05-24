# Obsidian Sync Dictionary with Bash

Small script to sync the dictionary file with a bash script.

## Usage
```bash
. script.sh
```

## How it works

You can now create a file inside your vaults `.obsidian` folder that will keep keep up to date with the `Custom Dictionary.txt` file on your computer.

By default this file is expected to be named `dictionary.txt`.

Always assume the global file is correct, unless in interactive mode.

## Planend features

- `-i` Interactive mode: script will prompt for which file to use as the source of truth
- Config management: Have a config file (using [TOML](https://toml.io/en/))
- Installation with Homebrew?
