# Essentially the same as `shell/.env.sh`, but for fish. Sourcing `shell/.env.sh`
# directly with something like `bass` or `plugin-foreign-env` worked, but it it
# added ~200ms to shell startup time, which is quite a lot.

# Intel Mac
if test -d "/usr/local/Homebrew"
    eval (/usr/local/Homebrew/bin/brew shellenv)
end

# Apple Silicon
if test -d "/opt/homebrew"
    eval (/opt/homebrew/bin/brew shellenv)
end


# Add bun bin
set -a PATH $HOME/.bun/bin

# Disable brew auto update
set -gx HOMEBREW_NO_AUTO_UPDATE true

# Set Helix editor
set -gx EDITOR hx

# Set Docker default platform - fixes issue with M1 Macs
set -gx DOCKER_DEFAULT_PLATFORM linux/amd64
