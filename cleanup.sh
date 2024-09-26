#!/bin/bash

# Homebrew
brew cleanup --prune=all

# Nix
nix-store --gc

# Docker
open -a Docker
docker system prune -a # Continue when Docker daemon is running
