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
ATUIN_NOBIND=true atuin init fish | source
bind \ca _atuin_search

# Config any-nix-shell
any-nix-shell fish | source

function ya
    set tmp (mktemp -t "yazi-cwd.XXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Homebrew completions (after PATH is set in env.fish)
if test -d /opt/homebrew/share/fish/completions
    set -p fish_complete_path /opt/homebrew/share/fish/completions
else if test -d /usr/local/share/fish/completions
    set -p fish_complete_path /usr/local/share/fish/completions
end

if test -d /opt/homebrew/share/fish/vendor_completions.d
    set -p fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
else if test -d /usr/local/share/fish/vendor_completions.d
    set -p fish_complete_path /usr/local/share/fish/vendor_completions.d
end

eval "$(micromamba shell hook --shell fish)"
