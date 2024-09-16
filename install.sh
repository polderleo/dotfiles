#!/bin/bash

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install zsh dependencies"
antidote load

echo "Fix GPG pinentry"
./macos/pinentry.sh

echo "Install tmux plugin manager"
./tmux/setup.sh
