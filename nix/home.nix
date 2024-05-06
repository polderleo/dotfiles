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
    ".config/fish/fish_plugins" = dotfile "fish/fish_plugins";
    ".config/gitui/key_bindings.ron" = dotfile "gitui/key_bindings.ron";
    ".config/gitui/theme.ron" = dotfile "gitui/theme.ron";
    ".config/helix/config.toml" = dotfile "helix/config.toml";
    ".config/nix/nix.conf" = dotfile "nix/nix.conf";
    ".config/starship.toml" = dotfile "starship/starship.toml";

    "Library/LaunchAgents/Timemator.restart.plist" = dotfile "macos/Timemator.restart.plist";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    shellInitLast = builtins.readFile ../fish/config.fish;
  };

  programs.zsh = {
    enable = true;

    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initExtraFirst = ''
      # Set PATH and environment
      source ~/.env.sh
    '';

    initExtra = ''
      # Ignore commands in history that begin with a space
      # https://dev.to/epranka/hide-the-exported-env-variables-from-the-history-49ni
      export HISTCONTROL=ignorespace

      # Set aliases
      source ~/.aliases.sh

      # Bind Alt+Left and Alt+Right to move between words
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;3D" backward-word

      # This adds a blank line before each command output for better readability
      function precmd { echo }
    '';

    antidote = {
      enable = true;
      plugins = [
        "wintermi/zsh-gcloud"
      ];
    };
  };

  # Universal prompt
  programs.starship = {
    enable = true;
  };

  # Universal history
  programs.atuin = {
    enable = true;
    enableFishIntegration = false; # We set it up manually in config.fish
    flags = [ "--disable-up-arrow" ];
  };

  # Modern replacement for 'ls'
  programs.eza = {
    enable = true;
    icons = true;
  };

  # Modern replacement for 'cd'
  programs.zoxide = {
    enable = true;
    options = [ "--cmd cd" ];
  };

  # Modern replacement for 'cat'
  programs.bat = {
    enable = true;
    config.theme = "Coldark-Dark";

    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = false; # We use PatrickF1/fzf.fish
  };
}
