{ pkgs, config, ... }:
let
  shellAliases = {
    lg = "lazygit";
    man = "batman";
    nix-switch = "nix run nix-darwin -- switch --flake ~/dotfiles";
    svgo = "svgo --config=$HOME/.svgo.config.js";
    wifi = "nextdns deactivate; open http://neverssl.com; read -P 'Continue? '; nextdns activate";
  };
in
with config.lib.file;
let
  dotfilesDirectory = "/Users/nik/dotfiles";
  dotfile = file: {
    source = mkOutOfStoreSymlink "${dotfilesDirectory}/${file}";
  };
in
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    act # Run GitHub Actions locally
    cloc # Count lines of code
    fd # Alternative to find
    ffmpeg # Play, record, convert, and stream audio and video
    gh # GitHub command-line tool
    gitui # Terminal ui for git
    gnused # GNU version of the famous stream editor
    gnutar # GNU version of the tar archiving utility
    helix # Post-modern modal text editor
    htop # Improved top (interactive process viewer)
    httpie # User-friendly HTTP client
    imagemagick # Manipulate images in many formats
    micromamba # Environment manager
    nextdns # DNS resolver
    nodePackages.svgo # Optimize SVGs
    nushell # Modern alternative shell
    pandoc # Document conversion
    pulumi-bin # Cloud native development platform
    restic # Backup program
    tmux # Terminal multiplexer
    tree # Display directories as trees
    watch # Execute a program periodically
    yq # Process YAML, JSON, XML, CSV and properties documents

    # Fun
    asciiquarium # Aquarium animation
    cmatrix # Matrix animation
    lolcat # Rainbow colors
    sl # Steam locomotive
  ];

  home.file = {
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
    ".config/helix/themes/my_theme.toml" = dotfile "helix/my_theme.toml";
    ".config/nix/nix.conf" = dotfile "nix/nix.conf";
    ".config/starship.toml" = dotfile "starship/starship.toml";

    "Library/LaunchAgents/Timemator.restart.plist" = dotfile "macos/Timemator.restart.plist";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.fish = {
    enable = true;
    shellInitLast = builtins.readFile ../fish/config.fish;
    shellAliases = shellAliases;
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

      # Bind Alt+Left and Alt+Right to move between words
      bindkey "^[[1;3C" forward-word
      bindkey "^[[1;3D" backward-word

      # This adds a blank line before each command output for better readability
      function precmd { echo }
    '';

    shellAliases = shellAliases;

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
    enableFishIntegration = false;
    package = pkgs.fzf.overrideAttrs (oldAttrs: {
      # The normal postInstall script installs shell integrations.
      # I don't want them, because I use the fish plugin `PatrickF1/fzf.fish`.
      postInstall = ''
        install bin/fzf-tmux $out/bin
        installManPage man/man1/fzf.1 man/man1/fzf-tmux.1
      '';
    });
  };

  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
      gui = {
        nerdFontsVersion = 3;
        theme = {
          activeBorderColor = [ "#ee99a0" "bold" ];
          inactiveBorderColor = [ "#a5adcb" ];
          optionsTextColor = [ "#8aadf4" ];
          selectedLineBgColor = [ "#363a4f" ];
          cherryPickedCommitBgColor = [ "#494d64" ];
          cherryPickedCommitFgColor = [ "#ee99a0" ];
          unstagedChangesColor = [ "#ed8796" ];
          defaultFgColor = [ "#cad3f5" ];
          searchingActiveBorderColor = [ "#eed49f" ];
        };
        authorColors = { "*" = "#b7bdf8"; };
      };
    };
  };
}
