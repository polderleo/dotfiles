## Setup

- Run `install.sh`.
- Import uBlock setting via the import features in browser

## Brew

Install from Brewfile: `brew bundle --file=~/dotfiles/macos/Brewfile`  
Dump to Brewfile: `brew bundle dump --file=~/dotfiles/macos/Brewfile --describe --force`  
Match Brewfile: `brew bundle --file=~/dotfiles/macos/Brewfile cleanup`  

Housekeeping with Brew: https://mac.install.guide/homebrew/8.html

## System software update

`softwareupdate -ia`

## SSH Setup

Generate new keyfile: `ssh-keygen -t ed25519 -C "niklasravnsborg@gmail.com"`  
Change password: `ssh-keygen -p -f ~/.ssh/id_ed25519`  
Add password to keychain: `ssh-add --apple-use-keychain ~/.ssh/id_ed25519`  
