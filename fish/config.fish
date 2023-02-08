set fish_greeting

# Set PATH and environment
bass source ~/.env.sh

# Set aliases
source ~/.aliases.sh

# Init starship
starship init fish | source

# Enable iTerm2 shell integration
source ~/.iterm2_shell_integration.fish
