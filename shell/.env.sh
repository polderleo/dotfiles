#!/bin/bash

# Intel Mac
if [ -d "/usr/local/Homebrew" ]; then
	eval "$(/usr/local/Homebrew/bin/brew shellenv)"
fi

# Apple Silicon
if [ -d "/opt/homebrew" ]; then
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

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
