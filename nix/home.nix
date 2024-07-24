{ pkgs, config, configDir, ... }:
let
  shellAliases = {
    lg = "lazygit";
    man = "batman";
    nix-switch = "nix run nix-darwin -- switch --flake ~/dotfiles";
    svgo = "svgo --config=$HOME/.svgo.config.js";
    wifi = "nextdns deactivate; open http://neverssl.com; read -P 'Continue? '; nextdns activate";
    ffmpeg = "ffmpeg -hide_banner";
  };
in
with config.lib.file;
let
  dotfile = file: {
    source = mkOutOfStoreSymlink "${configDir}/${file}";
  };
in
{
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    act # Run GitHub Actions locally
    any-nix-shell
    cloc # Count lines of code
    delta # Syntax-highlighter for git and diff output
    fd # Alternative to find
    ffmpeg_7 # Play, record, convert, and stream audio and video
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
    restic # Backup program
    tlrc # client for tldr: collaborative cheatsheets for console commands
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
    ".config/kitty/kitty.conf" = dotfile "kitty/kitty.conf";
    ".config/nix/nix.conf" = dotfile "nix/nix.conf";
    ".config/starship.toml" = dotfile "starship/starship.toml";

    # Yazi
    ".config/yazi/theme.toml" = dotfile "yazi/theme.toml";
    ".config/yazi/yazi.toml" = dotfile "yazi/yazi.toml";
    ".config/yazi/keymap.toml" = dotfile "yazi/keymap.toml";
    ".config/yazi/init.lua" = dotfile "yazi/init.lua";

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

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    config = {
      hide_env_diff = true;
    };
  };

  programs.yazi = {
    enable = true;
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
    git = true;
    extraOptions = [
      "--classify"
      "--group-directories-first"
      "--header"
      "--group"
      "--created"
      "--modified"
      "--octal-permissions"

      "--time-style"
      "long-iso"
    ];
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
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --no-gitconfig --paging=never --dark --syntax-theme=Coldark-Dark";
        };
      };
      gui = {
        scrollHeight = 1;
        nerdFontsVersion = 3;
        statusPanelView = "allBranchesLog";
        showCommandLog = false;
        showBottomLine = true;
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
      update = {
        method = "never";
      };
    };
  };

  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      xkb-options = [ "caps:escape" ];
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      maximize = [ "<Control><Super>Return" ];
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [ "<Control><Super>Left" ];
      toggle-tiled-right = [ "<Control><Super>Right" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys" = {
      # This is the shortcut to lock the screen
      screensaver = [ "<Control><Alt>q" ];
    };

  };
}
