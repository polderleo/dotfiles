#!/bin/bash

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install zsh dependencies"
antidote load

echo "Install tmux plugin manager"
./tmux/setup.sh
