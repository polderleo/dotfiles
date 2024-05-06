#!/bin/bash

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install fisher dependencies"
fish -c "fisher update"

echo "Install zsh dependencies"
antidote load

echo "Setup iTerm2"
./iterm/setup.sh

echo "Configure macOS"
./macos/defaults.sh

echo "Install custom keyboard"
./macos/keyboard.sh

echo "Fix GPG pinentry"
./macos/pinentry.sh

echo "Install tmux plugin manager"
./tmux/setup.sh
