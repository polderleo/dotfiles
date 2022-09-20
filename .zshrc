# Remove the % from Hyper Terminal
unsetopt PROMPT_SP

source $(brew --prefix)/share/antigen/antigen.zsh

# Ignore commands in history that begin with a space
# https://dev.to/epranka/hide-the-exported-env-variables-from-the-history-49ni
export HISTCONTROL=ignorespace

# Change PATH
path=("$HOME/go/bin" $path) # Add Go
path=("$HOME/bin/flutter/bin" $path) # Add Flutter
path=("/usr/local/Caskroom/flutter/3.3.1/flutter/.pub-cache/bin" $path) # Add Flutter pub cache
path=("$HOME/.composer/vendor/bin" $path) # Add PHP Composer
path=("$HOME/.gem/ruby/2.6.0/bin" $path) # Add Gems
path=("$HOME/.deno/bin" $path) # Add Deno
path=("$HOME/.asdf/shims" $path) # Add asdf shims
path=("$(npm config get prefix)/bin" $path) # Add npm bin
export PATH

# Load java
. ~/.asdf/plugins/java/set-java-home.zsh

# Load asdf
$(brew --prefix asdf)/asdf.sh
$(brew --prefix asdf)/etc/bash_completion.d/asdf.bash

# The next lines sources autocomplete scripts for Google Cloud SDK.
autoload -U +X compinit && compinit
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc'
source '/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc'

# Set Gem home
export GEM_HOME="$HOME/.gem"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Antigen plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme
antigen theme petermbenjamin/purity

# Tell Antigen that you're done
antigen apply

# Disable svgo path conversion by default
alias svgo="svgo --config=~/.svgoconfig.js"

# kubectl alias
alias kc="kubectl"
