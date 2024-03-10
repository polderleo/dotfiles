#!/bin/bash

# Trackpad: enable tap to click
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true

# Trackpad: enable three finger drag
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool false
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool false
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# Keyboard: enable key repeat when pressing and holding a key and set a fast repeat rate
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
defaults write NSGlobalDomain InitialKeyRepeat -int 16
defaults write NSGlobalDomain KeyRepeat -int 2

# Dock: disable workspace auto-switching
defaults write com.apple.dock workspaces-auto-swoosh -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: always open everything in list view
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder: disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Finder: when performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
