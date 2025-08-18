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

  # services.nextdns.enable = true;
  # Manually start and stop the nextdns service with:
  # `sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.nextdns.plist`
  # `sudo launchctl bootstrap system /Library/LaunchDaemons/org.nixos.nextdns.plist`
  # launchd.daemons.nextdns = {
  #   # Uncomment to enable logging
  #   # serviceConfig.StandardErrorPath = "/var/log/nextdns.log";
  #   # serviceConfig.StandardOutPath = "/var/log/nextdns.log";
  #   command = mkForce (
  #     toString (
  #       pkgs.writeShellScript "nextdns-config-watch" ''
  #         trap 'kill $(jobs -p); exit' SIGINT

  #         # `nextdns activate` depends on `launchctl` and `networksetup`
  #         export PATH="/usr/bin:/bin:/usr/sbin:/sbin"

  #         # Make sure nextdns is activated
  #         ${pkgs.nextdns}/bin/nextdns activate

  #         while true; do
  #           # Start long-running nextdns process in the background
  #           ${pkgs.nextdns}/bin/nextdns run --config-file=${config.sops.secrets.nextdns-config.path} &
  #           nextdns_pid=$!

  #           # If the tmpfs is not yet mounted, the file watchers won't trigger on change
  #           # wait4path will exit when the path is mounted
  #           if ! [ -d /run/secrets.d/ ]; then
  #             echo "Secrets volume not yet mounted. This script will restart when it is."
  #             /bin/wait4path /run/secrets.d/ &
  #           elif ! [ -e /run/secrets/ ]; then
  #             echo "Secrets not yet created. Restart the script."
  #             exit &
  #           else
  #             # Monitor symlink and config file in background
  #             # fswatch will exit when those paths are modified
  #             ${pkgs.fswatch}/bin/fswatch -1 ${config.sops.secrets.nextdns-config.path} > /dev/null &
  #           fi

  #           # Wait for at least one process to exit
  #           wait -n
  #           exit_code=$?

  #           # Check if the nextdns process has exited
  #           if ! /bin/ps -p $nextdns_pid > /dev/null; then
  #             echo "Process has exited with code $exit_code. Exiting script."
  #             exit $exit_code
  #           fi

  #           # Kill all other running processes
  #           echo "A monitored file was changed. Restarting."
  #           pids=$(jobs -p)
  #           kill $pids 2> /dev/null
  #           wait $pids

  #           # Before restarting the loop, let's sleep for 100 ms
  #           echo "Restarting in 100 ms..."
  #           /bin/sleep 0.1
  #         done
  #       ''
  #     )
  #   );
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

  # Disable startup chime (the startup sound)
  system.startup.chime = false;

  system.defaults = {
    # Disable sound effects
    # TODO: Find way to set "play user interface sound effects disable"
    NSGlobalDomain = {
      "com.apple.sound.beep.volume" = 0.0;
      "com.apple.sound.beep.feedback" = 0;
    };
    dock = {
      autohide = true; # automatically hide and show the Dock
    };
    # Disable that windows move away when clicking on the Desktop
    WindowManager = {
      EnableStandardClickToShowDesktop = false; # false means “Only in Stage Manager”
    };
    finder = {
      FXPreferredViewStyle = "Nlsv"; # Always open everything in list view
      ShowStatusBar = true; # Show status bar
      ShowPathbar = true; # Show path bar
      _FXSortFoldersFirst = true; # Keep folders on top when sorting by name
      FXEnableExtensionChangeWarning = false; # Disable the warning when changing a file extension
      FXDefaultSearchScope = "SCcf"; # When performing a search, search the current folder by default
    };

  };

  # Enable Touch ID for sudo
  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true; # Fixes Touch ID for sudo inside tmux and screen
  };

  # system.defaults.trackpad = {
  #   Clicking = true; # Enable tap to click
  #   TrackpadThreeFingerDrag = true; # Enable three finger drag
  # };

  # system.defaults.NSGlobalDomain = {
  #   # Enable key repeat when pressing and holding a key and set a fast repeat rate
  #   ApplePressAndHoldEnabled = false;
  #   InitialKeyRepeat = 16;
  #   KeyRepeat = 2;

  #   AppleShowAllExtensions = true; # Show all filename extensions in Finder

  #   AppleSpacesSwitchOnActivate = false; # Disable switching to a space when an application is activated
  # };

  # system.activationScripts.postUserActivation = {
  #   text = ''
  #     # Set default shell to fish
  #     sudo chsh -s /run/current-system/sw/bin/fish ldsr

  #     # Disable "Select the previous input source", because I use Ctrl + Space in Tmux
  #     # defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 60 '<dict><key>enabled</key><false/></dict>'

  #     # Disable "Show Spotlight search", because I use Cmd + Space for Raycast
  #     defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 '<dict><key>enabled</key><false/></dict>'

  #     # Activate settings so we don't have to restart
  #     /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u

  #     # Install keyboard shortcuts
  #     ${pkgs.bun}/bin/bun run --cwd=${configDir}/macos/karabiner/ build
  #     # ${pkgs.bun}/bin/bun run --cwd=${configDir}/macos/phoenix/ build

  #     # Configure Final Cut to enable timeline rendering during playback
  #     defaults write com.apple.FinalCut FFSuspendBGOpsDuringPlay 0

  #     # Configure Apple Mail
  #     defaults write com.apple.mail ShowCcHeader 0
  #     defaults write com.apple.mail EnableContactPhotos  1
  #     defaults write com.apple.mail NSFont SFPro-Regular
  #     defaults write com.apple.mail NSFontSize 12

  #     # Disable autoupgrade - Use `brew cu -aqy` to upgrade apps
  #     defaults write com.DanPristupov.Fork SUEnableAutomaticChecks -bool false
  #     defaults write com.seriflabs.affinitydesigner2 AutoUpdateInterval -bool false
  #     defaults write com.seriflabs.affinityphoto2 AutoUpdateInterval -bool false
  #     defaults write com.proxyman.NSProxy isUsingSystemStatusBar -bool false
  #     defaults write com.proxyman.NSProxy shouldShowUpdatePopup -bool false
  #   '';

  homebrew = {
    enable = true;

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      # `zap` will move related files of apps that are removed to the trash
      cleanup = "zap";
      # This will force an overwrite of apps already present
      # extraFlags = [ "--force" ];
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
      "scroll-reverser" # Reverse the direction of scrolling
      "zed" # High-performance, multiplayer code editor
      "spotify" # Music streaming service
      "gitkraken" # Git client
      "logi-options+" # Logitech Options for MX Master 3S
      "teamviewer" # Remote desktop software
    ];

    masApps = {
      "Bitwarden" = 1352778147;
    };
  };

  system.stateVersion = 5;
}
