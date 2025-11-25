set fish_greeting
set sponge_purge_only_on_exit true

# Set PATH and environment
# If TERM_PROGRAM is not tmux, since tmux will already have sourced the environment
if test -z "$TMUX" -a "$TERM_PROGRAM" != tmux
    source ~/dotfiles/fish/env.fish
end

# Add correct new lines for starship prompt
_spaced_prompts

# Set functions directory to dotfiles
set -U fish_function_path ~/dotfiles/fish/functions $fish_function_path
set -U fish_functions_dir ~/dotfiles/fish/functions

# Helper function to save functions to dotfiles
function dotsave --description 'Save current function to dotfiles'
    set funcname (echo $history[1] | string match -r 'function\s+(\w+)' | string replace 'function ' '' | string replace ' ' '')
    if test -n "$funcname"
        funcsave ~/dotfiles/fish/functions/$funcname
        echo "Function '$funcname' saved to dotfiles"
    else
        echo "Could not determine function name from history"
    end
end

# Init Atuin
ATUIN_NOBIND=true atuin init fish | source
bind \ca _atuin_search

# Config any-nix-shell
any-nix-shell fish | source

# fnm
fnm env --use-on-cd --shell fish | source

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

# Temporarily disabled due to micromamba build failure
# eval "$(micromamba shell hook --shell fish)"
