#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title open finder
# @raycast.mode silent

# Optional parameters:
# @raycast.icon /System/Library/CoreServices/Finder.app/Contents/Resources/Finder.icns

# Documentation:
# @raycast.author Leopold Stenger

open -a Finder "$HOME/Downloads" && open -g "raycast://extensions/raycast/window-management/almost-maximize"
