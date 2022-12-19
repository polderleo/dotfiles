#!/bin/bash

# Intel Mac
if [ -d "/usr/local/Homebrew" ] ; then
	eval "$(/usr/local/Homebrew/bin/brew shellenv)"
fi

# Apple Silicon
if [ -d "/opt/homebrew" ] ; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add Go
PATH=$PATH:$HOME/go/bin

# Add dart pub cache
PATH=$PATH:$HOME/.pub-cache/bin
 
# Add PHP Composer
PATH=$PATH:$HOME/.composer/vendor/bin
 
# Add Gems
PATH=$PATH:$HOME/.gem/bin
 
# Add Deno
PATH=$PATH:$HOME/.deno/bin
 
# Add npm bin
PATH=$PATH:$(npm config get prefix)/bin

# Set Gem home
export GEM_HOME="$HOME/.gem"
