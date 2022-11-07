#!/usr/bin/env bash

echo "pinentry-program /usr/local/MacGPG2/libexec/pinentry-mac.app/Contents/MacOS/pinentry-mac" > ~/.gnupg/gpg-agent.conf
gpgconf --kill gpg-agent
