set fish_greeting
set sponge_purge_only_on_exit true

# Set PATH and environment
# If TERM_PROGRAM is not tmux, since tmux will already have sourced the environment
if test -z "$TMUX" -a "$TERM_PROGRAM" != tmux
    source ~/dotfiles/fish/env.fish
end

# Add correct new lines for starship prompt
_spaced_prompts

# Init Atuin
atuin init fish --disable-ctrl-r --disable-up-arrow | source
bind \ca _atuin_search
