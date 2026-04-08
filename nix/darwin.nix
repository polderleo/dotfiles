
{
  pkgs,
  lib,
  config,
  # secretsPath,
  ...
}:

with lib;

let
  home = "/Users/ldsr";
  configDir = "${home}/dotfiles";
  appicon = name: {
    path = "/Applications/${name}.app";
    icon = "${configDir}/macos/icons/${name}.icns";
  };
in
{
  # Disable management of the nix installation via nix-darwin since I'm using Determinate Nix
  nix.enable = false;

  # sops = {
  #   defaultSopsFile = "${secretsPath}/secrets.yaml";
  #   age.keyFile = "${home}/.config/sops/age/keys.txt";

  #   # Disable automatic key generation
  #   age.sshKeyPaths = [ ];
  #   gnupg.sshKeyPaths = [ ];

  #   secrets = {
  #     nextdns-config = { };
  #   };
  # };


  # Create sourcings for zsh and fish
  programs.zsh.enable = true;
  programs.fish.enable = true;

  users.users.ldsr.home = home;

  # Your Terminal emulator might need Full Disk Access to change icons for all applications
  # environment.customIcons = {
  #   enable = true;
  #   icons = map appicon [
  #     "calibre"
  #     "ImageOptim"
  #     "kitty"
  #     "LogSeq"
  #     "Microsoft Excel"
  #     "Microsoft OneNote"
  #     "Microsoft Teams"
  #     "Microsoft Word"
  #     "Spotify"
  #     "Telegram"
  #     "Visual Studio Code"
  #   ];
  # };

  system.primaryUser = "ldsr";

  # Enable Touch ID for sudo
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true; # Fixes Touch ID for sudo inside tmux and screen
  };

  system.defaults.WindowManager.StandardHideWidgets = true;

  system.defaults.finder = {
    FXPreferredViewStyle = "Nlsv"; # Always open everything in list view
    ShowStatusBar = true; # Show status bar
    ShowPathbar = true; # Show path bar
    _FXSortFoldersFirst = true; # Keep folders on top when sorting by name
    FXEnableExtensionChangeWarning = false; # Disable the warning when changing a file extension
    FXDefaultSearchScope = "SCcf"; # When performing a search, search the current folder by default
  };

  system.defaults.trackpad = {
    Clicking = true; # Enable tap to click
    TrackpadThreeFingerDrag = true; # Enable three finger drag (Highlight text)
    TrackpadCornerSecondaryClick = 2; # Enable Right Click on the trackpad corner\
    ActuationStrength = 0; # Quiet Click enabled (Silent click)
    ForceSuppressed = true; # Suppress force click (Force click disabled)
  };

  system.defaults.NSGlobalDomain = {
    # Enable key repeat when pressing and holding a key and set a fast repeat rate
    ApplePressAndHoldEnabled = false;
    InitialKeyRepeat = 16;
    KeyRepeat = 2;

    AppleShowAllExtensions = true; # Show all filename extensions in Finder

    AppleSpacesSwitchOnActivate = false; # Disable switching to a space when an application is activated
  };

  system.defaults.CustomUserPreferences.NSGlobalDomain."com.apple.trackpad.scaling" = 1.0;
  system.defaults.CustomUserPreferences.NSGlobalDomain."com.apple.mouse.scaling" = 2.0;

  system.defaults.dock = {
    autohide = true; # automatically hide and show the Dock
  };

  system.defaults.screensaver = {
    askForPasswordDelay = 0;
  };

  system.activationScripts.postActivation = {
    text = ''
      # Set default shell to fish
      sudo chsh -s /run/current-system/sw/bin/fish ldsr

      # Run the following script as user ldsr
      sudo -i -u ldsr bash <<'EOF'

      # Disable 'Select the previous input source', because I use Ctrl + Space in Tmux
      defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><false/></dict>'

      # Disable 'Show Spotlight search', because I use Cmd + Space for Raycast
      defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'

      # Move focus to next window: Option + ` (default is Cmd + `; hotkey id 27)
      defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 27 '<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>96</integer><integer>50</integer><integer>524288</integer></array></dict></dict>'

      # Disable 'Save picture of screen as file' (hotkey 28) — would also be Cmd + Shift + 3
      defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 28 '<dict><key>enabled</key><false/></dict>'

      # Copy picture of selected area to clipboard: Cmd + Shift + 2 (hotkey id 31)
      defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 31 '<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>50</integer><integer>19</integer><integer>1179648</integer></array></dict></dict>'

      # Save picture of selected area as file: Cmd + Shift + 3 (hotkey id 30)
      defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 30 '<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>51</integer><integer>20</integer><integer>1179648</integer></array></dict></dict>'

      # Screenshot and recording options (toolbar): Cmd + Shift + 4 (hotkey id 184; default is Cmd + Shift + 5)
      defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 184 '<dict><key>enabled</key><true/><key>value</key><dict><key>type</key><string>standard</string><key>parameters</key><array><integer>52</integer><integer>21</integer><integer>1179648</integer></array></dict></dict>'

      # Activate settings so we don't have to restart
      /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

      # Install keyboard shortcuts
      ${pkgs.bun}/bin/bun run --cwd=${configDir}/macos/karabiner/ build
      EOF
    '';
  };

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # `zap` will move related files of apps that are removed to the trash
      cleanup = "zap";

      extraFlags = [ "--force --verbose" ];
    };
    taps = [
      # Upgrade casks with `brew cu -aqy`
      "buo/cask-upgrade"
    ];

    brews = [
      # Although we already have it in home-manager, this gpg binary is the only one that Fork can find
      "gnupg"
      "batt"
      "speedtest-cli"
    ];

    casks = [
      "1password" # Password manager
      "beeper" # Universal chat app
      "chatgpt" # ChatGPT macOS app
      "cursor" # AI-powered code editor
      "ghostty" # Terminal emulator that uses platform-native UI and GPU acceleration
      "google-chrome" # Web browser
      "google-drive" # Client for Google Drive cloud storage
      "karabiner-elements" # Keyboard customizer
      "keepassxc" # Cross-platform password manager
      "macmediakeyforwarder" # Forward media keys to specific applications
      "notion" # App to write, plan, collaborate, and get organised
      "notion-calendar" # Calendar by Notion
      "raycast" # Control your tools with a few keystrokes
      "readdle-spark" # Email client
      "zed" # High-performance, multiplayer code editor
      "spotify" # Music streaming service
      "gitkraken" # Git client
      "logi-options+" # Logitech Options for MX Master 3S
      "teamviewer" # Remote desktop software
      "orbstack" # Docker desktop alternative
      "timemator" # Time tracking software
      "visual-studio-code" # Code editor
      "figma" # Design tool
      "adobe-acrobat-reader" # PDF reader
      "whatsapp" # Messanger
      "capacities"
      "signal" # Messanger,
      "protonvpn"
      "ngrok"
      "Bruno" # Insomnia alternative API client (https://www.usebruno.com/)
      "parsec" # Remote desktop software
      "steam" # Game platform
      "daisydisk" # Disk usage analyzer
      "codex" # Codex tool
      "codex-app" # Codex app
      "wispr-flow" # The voice-to-text AI that turns speech into clear, polished writing in every app.
      "utm" # Virtualization tool
      "crystalfetch" # easy way to fetch latest Windows
      "tor-browser" # Tor Browser
      "mos"
    ];

    masApps = {
      "Bitwarden" = 1352778147;
    };
  };

  launchd.daemons.batt = {
    path = [ "/opt/homebrew/bin" ];
    serviceConfig = {
      ProgramArguments = [
        "/opt/homebrew/bin/batt"
        "daemon"
        "--always-allow-non-root-access"
      ];
      RunAtLoad = true;
      KeepAlive = true;
      UserName = "root";
      StandardOutPath = "/tmp/batt.log";
      StandardErrorPath = "/tmp/batt.err";
    };
  };

  system.stateVersion = 5;

  # Ollama service
  services.ollama = {
    enable = true;
  };
}
