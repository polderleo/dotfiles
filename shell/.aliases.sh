#!/bin/bash

# Set svgo config
alias svgo="svgo --config=$HOME/.svgo.config.js"

# kubectl alias
alias kc="kubectl"

# eza alias
alias ls='eza     --icons --classify --group-directories-first'
alias ll='eza -l  --icons --classify --group-directories-first --header --group --created --modified --octal-permissions --time-style long-iso --git'
alias la='eza -la --icons --classify --group-directories-first --header --group --created --modified --octal-permissions --time-style long-iso --git'
alias lt='eza     --icons --classify --group-directories-first --tree --level=2'

# bat alias (bat will behave like cat, when no interactivity is detected - so it's is safe)
alias bat='bat --theme="Coldark-Dark"'
alias cat='bat'

# sed alias
alias sed='gsed'

# tar alias
alias tar='gtar'

# public wifi login
alias wifi='nextdns deactivate; open http://neverssl.com; read -P "Continue? "; nextdns activate'
