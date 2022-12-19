# Remove the % from Hyper Terminal
unsetopt PROMPT_SP

source $HOMEBREW_PREFIX/share/antigen/antigen.zsh

# Ignore commands in history that begin with a space
# https://dev.to/epranka/hide-the-exported-env-variables-from-the-history-49ni
export HISTCONTROL=ignorespace

# The next lines sources autocomplete scripts for Google Cloud SDK.
autoload -U +X compinit && compinit
source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"
source "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Antigen plugins
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions

# Load the theme
antigen theme petermbenjamin/purity

# Tell Antigen that you're done
antigen apply

# Set PATH and environment
source ~/.env.sh

# Set aliases
source ~/.aliases.sh

# Enable fuzzy history search
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
