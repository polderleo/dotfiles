#!/bin/bash

# Intel Mac
if [ -d "/usr/local/Homebrew" ]; then
	eval "$(/usr/local/Homebrew/bin/brew shellenv)"
fi

# Apple Silicon
if [ -d "/opt/homebrew" ]; then
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

# Add .NET tools
PATH=$PATH:$HOME/.dotnet/tools

# Add npm bin
PATH=$PATH:$(npm config get prefix)/bin

# Add bun bin
PATH=$PATH:$HOME/.bun/bin

# Set Gem home
export GEM_HOME=$HOME/.gem

# Set .NET root
export DOTNET_ROOT=$HOMEBREW_PREFIX/opt/dotnet@6/libexec/

# Disable brew auto update
export HOMEBREW_NO_AUTO_UPDATE=true

# Set Helix editor
export EDITOR=hx

# Set Docker default platform - fixes issue with M1 Macs
export DOCKER_DEFAULT_PLATFORM=linux/amd64
