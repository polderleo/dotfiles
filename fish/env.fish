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

# Add Go
set -a PATH $HOME/go/bin

# Add dart pub cache
set -a PATH $HOME/.pub-cache/bin

# Add PHP Composer
set -a PATH $HOME/.composer/vendor/bin

# Add Gems
set -a PATH $HOME/.gem/bin

# Add Deno
# set -a PATH $HOME/.deno/bin

# Add .NET tools
set -a PATH $HOME/.dotnet/tools

# Add npm bin
# set -a PATH (npm config get prefix)/bin

# Add bun bin
set -a PATH $HOME/.bun/bin

# Set Gem home
set -gx GEM_HOME $HOME/.gem

# Set .NET root
set -gx DOTNET_ROOT $HOMEBREW_PREFIX/opt/dotnet@6/libexec/
