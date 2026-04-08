#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title open ghostty
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ~/dotfiles/macos/icons/Ghostty.icns

# Documentation:
# @raycast.author Leopold Stenger

open -a Ghostty
sleep 0.2
open -g "raycast://extensions/raycast/window-management/almost-maximize"
