# CodeWhisperer pre block. Keep at the top of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.pre.zsh"
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

# Enable iTerm2 shell integration
source ~/.iterm2_shell_integration.zsh

# Init starship
eval "$(starship init zsh)"

# Init zoxide
eval "$(zoxide init --cmd cd zsh)"

# Init Atuin
eval "$(atuin init zsh --disable-ctrl-r --disable-up-arrow)"

# This adds a blank line before each command output for better readability
function precmd {
    echo
}

# CodeWhisperer post block. Keep at the bottom of this file.
[[ -f "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh" ]] && builtin source "${HOME}/Library/Application Support/codewhisperer/shell/zshrc.post.zsh"
