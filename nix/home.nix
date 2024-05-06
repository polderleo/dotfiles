{ pkgs, config, ... }:
with config.lib.file;
let
  dotfilesDirectory = "/Users/nik/dotfiles";
  dotfile = file: {
    source = mkOutOfStoreSymlink "${dotfilesDirectory}/${file}";
  };
in
{
  home.stateVersion = "23.11";

  home.file = {
    ".aliases.sh" = dotfile "shell/.aliases.sh";
    ".env.sh" = dotfile "shell/.env.sh";

    ".docker/config.json" = dotfile "docker/config.json";
    ".finicky.js" = dotfile "finicky/.finicky.js";
    ".gitconfig" = dotfile "git/.gitconfig";
    ".gitignore" = dotfile "git/.gitignore";
    ".ssh/config" = dotfile "ssh/config";
    ".svgo.config.js" = dotfile "svgo/.svgo.config.js";
    ".tmux.conf" = dotfile "tmux/.tmux.conf";
    ".vimrc" = dotfile "vim/.vimrc";

    ".config/alacritty/alacritty.toml" = dotfile "alacritty/alacritty.toml";
    ".config/atuin/config.toml" = dotfile "atuin/config.toml";
    ".config/fish/config.fish" = dotfile "fish/config.fish";
    ".config/fish/fish_plugins" = dotfile "fish/fish_plugins";
    ".config/gitui/key_bindings.ron" = dotfile "gitui/key_bindings.ron";
    ".config/gitui/theme.ron" = dotfile "gitui/theme.ron";
    ".config/helix/config.toml" = dotfile "helix/config.toml";
    ".config/nix/nix.conf" = dotfile "nix/nix.conf";
    ".config/starship.toml" = dotfile "starship/starship.toml";

    ".zsh_plugins.txt" = dotfile "zsh/.zsh_plugins.txt";
    ".zshrc" = dotfile "zsh/.zshrc";
    ".fzf.zsh" = dotfile "zsh/.fzf.zsh";

    "Library/LaunchAgents/Timemator.restart.plist" = dotfile "macos/Timemator.restart.plist";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
