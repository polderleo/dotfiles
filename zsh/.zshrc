# Load Antidote
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
source ~/.zsh_plugins.zsh

# Ignore commands in history that begin with a space
# https://dev.to/epranka/hide-the-exported-env-variables-from-the-history-49ni
export HISTCONTROL=ignorespace

# Set PATH and environment
source ~/.env.sh

# Set aliases
source ~/.aliases.sh

# Enable fuzzy history search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
